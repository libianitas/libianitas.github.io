#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import base64
import zipfile
from pathlib import Path
import oracledb

# =========================
# Repo paths
# =========================
ROOT = Path(".")
OUT_DIR = ROOT / "diccionario"
OUT_DIR.mkdir(parents=True, exist_ok=True)

INDEX_MD = ROOT / "index.md"

# Runtime wallet folder (must NOT be committed)
WALLET_DIR = ROOT / ".wallet_runtime"


def write_md(path: Path, content: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


def patch_sqlnet_for_actions(wallet_dir: Path):
    """
    Force auto-login wallet usage (cwallet.sso / ewallet.p12) in non-interactive runners.
    Prevents 'Enter PEM pass phrase:' prompts and stabilizes TLS.
    """
    sqlnet_path = wallet_dir / "sqlnet.ora"
    if not sqlnet_path.exists():
        return

    text = sqlnet_path.read_text(encoding="utf-8", errors="ignore")

    # Ensure wallet location points to extracted directory
    if "WALLET_LOCATION" not in text:
        text += (
            "\nWALLET_LOCATION = (SOURCE = (METHOD = FILE) "
            f"(METHOD_DATA = (DIRECTORY = {wallet_dir})))\n"
        )

    # Recommended for ADW
    if "SSL_SERVER_DN_MATCH" not in text:
        text += "\nSSL_SERVER_DN_MATCH = yes\n"

    # Force wallet override (prefer wallet in this dir)
    if "SQLNET.WALLET_OVERRIDE" not in text:
        text += "\nSQLNET.WALLET_OVERRIDE = TRUE\n"

    sqlnet_path.write_text(text, encoding="utf-8")


def unzip_wallet_from_b64(wallet_b64: str, target_dir: Path) -> Path:
    """
    Decode base64 wallet zip and extract into target_dir.
    Returns directory that contains tnsnames.ora/sqlnet.ora.
    """
    target_dir.mkdir(parents=True, exist_ok=True)

    zip_path = target_dir / "wallet.zip"
    zip_bytes = base64.b64decode(wallet_b64)
    zip_path.write_bytes(zip_bytes)

    with zipfile.ZipFile(zip_path, "r") as zf:
        zf.extractall(target_dir)

    # Patch sqlnet to avoid PEM prompts on CI
    patch_sqlnet_for_actions(target_dir)

    # Optional: remove PEM to prevent passphrase prompt (safe in runtime dir)
    pem = target_dir / "ewallet.pem"
    if pem.exists():
        pem.unlink()

    return target_dir


def get_adw_connection():
    user = os.environ["ADW_USER"]
    password = os.environ["ADW_PASSWORD"]
    tns_alias = os.environ["ADW_TNS_ALIAS"]
    wallet_b64 = os.environ["ADW_WALLET_B64"]

    # 1) Extract wallet
    tns_admin = unzip_wallet_from_b64(wallet_b64, WALLET_DIR)

    # 2) Set TNS_ADMIN for compatibility
    os.environ["TNS_ADMIN"] = str(tns_admin)

    # Debug (you can remove later)
    print("Wallet files:", list(Path(tns_admin).glob("*")))

    # 3) Connect (force config_dir + wallet_location)
    conn = oracledb.connect(
        user=user,
        password=password,
        dsn=tns_alias,
        config_dir=str(tns_admin),
        wallet_location=str(tns_admin),
    )
    return conn


def fetch_tables_and_columns(conn, owner: str):
    """
    Returns dict: {table_name: [(column_name, dtype, nullable, default), ...]}
    Filters:
      - excludes TMP tables
      - includes DIM_, FACT_, BRIDGE_, MV_
    """
    sql = """
    SELECT
      c.table_name,
      c.column_name,
      c.data_type,
      c.data_length,
      c.data_precision,
      c.data_scale,
      c.nullable,
      c.data_default
    FROM all_tab_columns c
    WHERE c.owner = :owner
      AND c.table_name NOT LIKE '%TMP%'
      AND (
             c.table_name LIKE 'DIM_%'
          OR c.table_name LIKE 'FACT_%'
          OR c.table_name LIKE 'BRIDGE_%'
          OR c.table_name LIKE 'MV_%'
      )
    ORDER BY c.table_name, c.column_id
    """
    cur = conn.cursor()
    cur.execute(sql, owner=owner.upper())

    tables = {}
    for row in cur:
        table_name = row[0]
        col_name = row[1]
        data_type = row[2]
        data_length = row[3]
        data_precision = row[4]
        data_scale = row[5]
        nullable = row[6]
        data_default = row[7]

        # Format datatype
        dtype = data_type
        if data_type in ("VARCHAR2", "CHAR", "NVARCHAR2", "NCHAR"):
            dtype = f"{data_type}({data_length})"
        elif data_type == "NUMBER":
            if data_precision is not None:
                if data_scale is not None:
                    dtype = f"NUMBER({data_precision},{data_scale})"
                else:
                    dtype = f"NUMBER({data_precision})"

        tables.setdefault(table_name, []).append(
            (col_name, dtype, nullable, (data_default.strip() if data_default else ""))
        )

    cur.close()
    return tables


def generate_table_md(owner: str, table_name: str, columns):
    lines = []
    lines.append(f"# {owner}.{table_name}\n")
    lines.append("| Column | Type | Nullable | Default |")
    lines.append("|---|---|---|---|")
    for col, dtype, nullable, default in columns:
        lines.append(f"| {col} | {dtype} | {nullable} | {default} |")
    lines.append("")
    return "\n".join(lines)


def main():
    owner = os.getenv("ADW_OWNER", "DWADW").upper()

    with get_adw_connection() as conn:
        tables = fetch_tables_and_columns(conn, owner)

    # Generate per-table markdown
    index_lines = [f"# Diccionario de datos - {owner}\n", "## Tablas\n"]

    for table_name, cols in tables.items():
        md_path = OUT_DIR / f"{owner}.{table_name}.md"
        write_md(md_path, generate_table_md(owner, table_name, cols))
        index_lines.append(f"- [{owner}.{table_name}](diccionario/{owner}.{table_name}.md)")

    write_md(INDEX_MD, "\n".join(index_lines) + "\n")
    print(f"OK. Tablas generadas: {len(tables)}")


if __name__ == "__main__":
    main()

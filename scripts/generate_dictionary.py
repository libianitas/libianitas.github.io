#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import base64
import zipfile
from pathlib import Path
import oracledb

# =========================
# Rutas del repo
# =========================
ROOT = Path(".")
OUT_DIR = ROOT / "diccionario"
OUT_DIR.mkdir(parents=True, exist_ok=True)

INDEX_MD = ROOT / "index.md"

# Carpeta runtime para el wallet (NO debe versionarse)
WALLET_DIR = ROOT / ".wallet_runtime"


def write_md(path: Path, content: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")

def unzip_wallet_from_b64(wallet_b64: str, target_dir: Path) -> Path:
    target_dir.mkdir(parents=True, exist_ok=True)
    zip_path = target_dir / "wallet.zip"
    zip_bytes = base64.b64decode(wallet_b64)
    zip_path.write_bytes(zip_bytes)

    with zipfile.ZipFile(zip_path, "r") as zf:
        zf.extractall(target_dir)
    
    # Buscamos y borramos CUALQUIER sqlnet.ora en el wallet extraído
    # El modo Thin NO lo necesita si usamos wallet_location en oracledb.connect
    for extra_sqlnet in target_dir.rglob("sqlnet.ora"):
        extra_sqlnet.unlink()
        print(f"Limpiando configuración antigua: {extra_sqlnet.name}", flush=True)

    return target_dir

def get_adw_connection():
    user = os.environ["ADW_USER"]
    password = os.environ["ADW_PASSWORD"]
    tns_alias = os.environ["ADW_TNS_ALIAS"]
    wallet_b64 = os.environ["ADW_WALLET_B64"]
    wallet_password = os.getenv("ADW_WALLET_PASSWORD")

    base_tns_admin = unzip_wallet_from_b64(wallet_b64, WALLET_DIR)
    
    # Encontrar la carpeta real (donde quedó tnsnames.ora) y convertir a absoluta
    tns_admin_path = base_tns_admin
    for path in base_tns_admin.rglob("tnsnames.ora"):
        tns_admin_path = path.parent.resolve() # .resolve() da la ruta completa
        break

    print(f"Conectando con TNS_ADMIN absoluto: {tns_admin_path}", flush=True)

    conn = oracledb.connect(
        user=user,
        password=password,
        dsn=tns_alias,
        config_dir=str(tns_admin_path),
        wallet_location=str(tns_admin_path),
        wallet_password=wallet_password
    )
    return conn


def fetch_tables_and_columns(conn, owner: str):
    """
    Retorna dict: {table_name: [(column_name, dtype, nullable, default), ...]}
    Filtros:
      - excluye TMP
      - incluye DIM_, FACT_, BRIDGE_, MV_
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

        # Formatear datatype
        dtype = data_type
        if data_type in ("VARCHAR2", "CHAR", "NVARCHAR2", "NCHAR"):
            dtype = f"{data_type}({data_length})"
        elif data_type == "NUMBER":
            if data_precision is not None:
                if data_scale is not None:
                    dtype = f"NUMBER({data_precision},{data_scale})"
                else:
                    dtype = f"NUMBER({data_precision})"

        default_txt = ""
        if data_default is not None:
            default_txt = str(data_default).strip()

        tables.setdefault(table_name, []).append(
            (col_name, dtype, nullable, default_txt)
        )

    cur.close()
    return tables


def generate_table_md(owner: str, table_name: str, columns):
    lines = []
    lines.append(f"# {owner}.{table_name}\n")
    lines.append("| Columna | Tipo | Nulo | Default |")
    lines.append("|---|---|---|---|")
    for col, dtype, nullable, default in columns:
        lines.append(f"| {col} | {dtype} | {nullable} | {default} |")
    lines.append("")
    return "\n".join(lines)


def main():
    owner = os.getenv("ADW_OWNER", "DWADW").upper()

    with get_adw_connection() as conn:
        tables = fetch_tables_and_columns(conn, owner)

    # Generar Markdown por tabla
    index_lines = [f"# Diccionario de datos - {owner}\n", "## Tablas\n"]

    for table_name, cols in tables.items():
        md_path = OUT_DIR / f"{owner}.{table_name}.md"
        write_md(md_path, generate_table_md(owner, table_name, cols))
        index_lines.append(f"- [{owner}.{table_name}](diccionario/{owner}.{table_name}.md)")

    write_md(INDEX_MD, "\n".join(index_lines) + "\n")
    print(f"OK. Tablas generadas: {len(tables)}", flush=True)


if __name__ == "__main__":
    main()

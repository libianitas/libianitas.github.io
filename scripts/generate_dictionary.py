import os
import base64
import zipfile
from pathlib import Path
import oracledb

# =========================
# Paths del repo
# =========================
ROOT = Path(".")
OUT_DIR = ROOT / "diccionario"
OUT_DIR.mkdir(parents=True, exist_ok=True)

INDEX_MD = ROOT / "index.md"

# Carpeta temporal para wallet (NO se versiona)
WALLET_DIR = ROOT / ".wallet_runtime"


def unzip_wallet_from_b64(wallet_b64: str, target_dir: Path) -> Path:
    """
    Decodifica el wallet ZIP desde base64 y lo extrae en target_dir.
    Retorna el path del directorio que contiene tnsnames.ora/sqlnet.ora.
    """
    target_dir.mkdir(parents=True, exist_ok=True)

    zip_path = target_dir / "wallet.zip"
    zip_bytes = base64.b64decode(wallet_b64)
    zip_path.write_bytes(zip_bytes)

    with zipfile.ZipFile(zip_path, "r") as zf:
        zf.extractall(target_dir)

    # Normalmente wallet trae estos archivos en la raíz extraída:
    # tnsnames.ora, sqlnet.ora, cwallet.sso, ewallet.p12, etc.
    # Devolvemos target_dir como TNS_ADMIN
    return target_dir


def get_adw_connection():
    user = os.environ["ADW_USER"]
    password = os.environ["ADW_PASSWORD"]
    tns_alias = os.environ["ADW_TNS_ALIAS"]
    wallet_b64 = os.environ["ADW_WALLET_B64"]

    # 1) Extraer wallet en runtime
    tns_admin = unzip_wallet_from_b64(wallet_b64, WALLET_DIR)
    print("Wallet files:", list(Path(tns_admin).glob("*")))

    # 2) Configurar TNS_ADMIN (por compatibilidad)
    os.environ["TNS_ADMIN"] = str(tns_admin)

    # 3) Conectar (FORZANDO config_dir y wallet_location)
    conn = oracledb.connect(
        user=user,
        password=password,
        dsn=tns_alias,
        config_dir=str(tns_admin),
        wallet_location=str(tns_admin),
    )
    return conn



def write_md(path: Path, content: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


def fetch_tables_and_columns(conn, owner: str):
    """
    Retorna dict {table_name: [ (column_name, data_type, nullable, data_default) ... ]}
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

        # Formato de tipo
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
            (col_name, dtype, nullable, (data_default.strip() if data_default else None))
        )
    cur.close()
    return tables


def generate_table_md(owner: str, table_name: str, columns):
    lines = []
    lines.append(f"# {owner}.{table_name}\n")
    lines.append("| Column | Type | Nullable | Default |")
    lines.append("|---|---|---|---|")
    for col, dtype, nullable, default in columns:
        default_txt = default if default else ""
        lines.append(f"| {col} | {dtype} | {nullable} | {default_txt} |")
    lines.append("")
    return "\n".join(lines)


def main():
    # Puedes parametrizar OWNER por env si quieres
    # Ej: export ADW_OWNER=DWADW
    owner = os.getenv("ADW_OWNER", "DWADW").upper()

    with get_adw_connection() as conn:
        tables = fetch_tables_and_columns(conn, owner)

    # Generar MD por tabla
    index_lines = []
    index_lines.append(f"# Diccionario de datos - {owner}\n")
    index_lines.append("## Tablas\n")

    for table_name, cols in tables.items():
        md_path = OUT_DIR / f"{owner}.{table_name}.md"
        write_md(md_path, generate_table_md(owner, table_name, cols))
        index_lines.append(f"- [{owner}.{table_name}](diccionario/{owner}.{table_name}.md)")

    write_md(INDEX_MD, "\n".join(index_lines) + "\n")

    print(f"OK. Tablas generadas: {len(tables)}")


if __name__ == "__main__":
    main()

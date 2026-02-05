import os
import json
import zipfile
import base64
from pathlib import Path
from collections import defaultdict
import oracledb

ROOT = Path(".")
OUT_INDEX = ROOT / "index.md"
OUT_DIR = ROOT / "diccionario"
OUT_DIR.mkdir(parents=True, exist_ok=True)

def write_text(path: Path, content: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")

def unzip_wallet_from_b64(wallet_b64: str, target_dir: Path):
    target_dir.mkdir(parents=True, exist_ok=True)
    raw = base64.b64decode(wallet_b64)
    zip_path = target_dir / "wallet.zip"
    zip_path.write_bytes(raw)
    with zipfile.ZipFile(zip_path, "r") as z:
        z.extractall(target_dir)
    zip_path.unlink(missing_ok=True)

def get_adw_connection():
    user = os.environ["DB_USER"]
    password = os.environ["DB_PASSWORD"]
    dsn = os.environ["DB_SERVICE"]  # Ej: adwanalyticsprod_high
    wallet_dir = os.environ["WALLET_DIR"]
    wallet_password = os.environ.get("WALLET_PASSWORD")

    return oracledb.connect(
        user=user,
        password=password,
        dsn=dsn,
        config_dir=wallet_dir,
        wallet_location=wallet_dir,
        wallet_password=wallet_password
    )

def extract_metadata(owner: str):
    conn = None
    cur = None
    try:
        conn = get_adw_connection()
        cur = conn.cursor()

        cur.execute("""
            SELECT table_name
            FROM all_tables
            WHERE owner = :1
            ORDER BY table_name
        """, [owner])
        tables = [r[0] for r in cur.fetchall()]

        metadata = {}

        for table in tables:
            cur.execute("""
                SELECT
                    c.column_id,
                    c.column_name,
                    c.data_type,
                    c.data_length,
                    c.data_precision,
                    c.data_scale,
                    c.nullable,
                    cc.comments
                FROM all_tab_columns c
                LEFT JOIN all_col_comments cc
                  ON cc.owner = c.owner
                 AND cc.table_name = c.table_name
                 AND cc.column_name = c.column_name
                WHERE c.owner = :1
                  AND c.table_name = :2
                ORDER BY c.column_id
            """, [owner, table])

            cols = []
            for r in cur.fetchall():
                cols.append({
                    "column_id": r[0],
                    "column_name": r[1],
                    "data_type": r[2],
                    "data_length": r[3],
                    "data_precision": r[4],
                    "data_scale": r[5],
                    "nullable": r[6],
                    "comments": r[7]
                })
            metadata[table] = cols

        return metadata
    finally:
        if cur: cur.close()
        if conn: conn.close()

def detect_module(table_name: str) -> str:
    t = table_name.upper()
    if t.endswith("_OTM"):
        return "OTM"
    if t.endswith("_OM"):
        return "OM"
    return "OTROS"

def format_dtype(c: dict) -> str:
    dtype = c["data_type"]
    if c["data_type"] in ("NUMBER", "FLOAT") and c["data_precision"] is not None:
        scale = c["data_scale"] if c["data_scale"] is not None else 0
        return f"{dtype}({c['data_precision']},{scale})"
    if c["data_length"]:
        return f"{dtype}({c['data_length']})"
    return dtype

def generate_markdown(owner: str, metadata: dict):
    module_tables = defaultdict(list)
    for table in sorted(metadata.keys()):
        module_tables[detect_module(table)].append(table)

    # index.md en RAÍZ
    index_md = [
        "# 📘 Diccionario de Datos",
        "",
        f"**Esquema:** `{owner}`",
        "",
        "## 📚 Módulos",
        ""
    ]
    if "OTM" in module_tables:
        index_md.append("- [OTM](diccionario/otm.md)")
    if "OM" in module_tables:
        index_md.append("- [OM](diccionario/om.md)")
    if "OTROS" in module_tables:
        index_md.append("- [OTROS](diccionario/otros.md)")
    write_text(OUT_INDEX, "\n".join(index_md))

    # 1 MD por módulo, con tablas + columnas adentro
    for mod in ["OTM", "OM", "OTROS"]:
        if mod not in module_tables:
            continue

        tables = module_tables[mod]
        module_file = OUT_DIR / f"{mod.lower()}.md"

        md = [
            f"# 📦 Módulo {mod}",
            "",
            f"Tablas del esquema `{owner}` del módulo **{mod}**.",
            "",
            "↩️ Volver al [Inicio](../index.md)",
            "",
            "## 📋 Tablas",
            ""
        ]

        for table in tables:
            md.append(f"- [{table}](#{table.lower().replace('_','-')})")

        md += [""]

        for table in tables:
            md += [
                f"## 🧩 {table}",
                "",
                "| # | Columna | Tipo de Dato | Nullable | Descripción |",
                "|---|--------|--------------|----------|-------------|"
            ]

            for c in metadata[table]:
                dtype = format_dtype(c)
                comment = (c["comments"] or "").replace("|", "\\|").replace("\n", " ")
                md.append(
                    f"| {c['column_id']} | {c['column_name']} | {dtype} | "
                    f"{c['nullable']} | {comment} |"
                )

            md += ["", "---", ""]

        write_text(module_file, "\n".join(md))

def main():
    owner = os.environ.get("OWNER", "DWADW")

    # Preparar wallet desde secret (base64 zip)
    wallet_b64 = os.environ["WALLET_ZIP_B64"]
    wallet_dir = ROOT / ".wallet"
    unzip_wallet_from_b64(wallet_b64, wallet_dir)

    os.environ["WALLET_DIR"] = str(wallet_dir)

    metadata = extract_metadata(owner)
    generate_markdown(owner, metadata)

    print(json.dumps({"status": "OK", "owner": owner, "tables": len(metadata)}))

if __name__ == "__main__":
    main()


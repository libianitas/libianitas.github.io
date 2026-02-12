import os
import oracledb
from contextlib import contextmanager

def _mask(s: str | None) -> str:
    if not s:
        return "None"
    if len(s) <= 4:
        return "***"
    return s[:2] + "***" + s[-2:]

@contextmanager
def get_adw_connection():
    user = os.getenv("ADW_USER") or os.getenv("DB_USER")
    password = os.getenv("ADW_PASSWORD") or os.getenv("DB_PASSWORD")
    dsn = os.getenv("ADW_TNS_ALIAS") or os.getenv("DB_SERVICE")  # ej: adwanalyticsprod_high
    wallet_dir = os.getenv("ADW_WALLET_DIR") or os.getenv("WALLET_DIR") or "wallet"
    wallet_pwd = os.getenv("ADW_WALLET_PASSWORD") or os.getenv("WALLET_PASSWORD")

    if not user or not password or not dsn:
        raise RuntimeError(
            "Missing env vars. Need ADW_USER/ADW_PASSWORD/ADW_TNS_ALIAS "
            "(or DB_USER/DB_PASSWORD/DB_SERVICE)."
        )

    # Fuerza thin + wallet (independiente del sqlnet.ora)
    oracledb.defaults.config_dir = wallet_dir
    oracledb.defaults.wallet_location = wallet_dir
    if wallet_pwd:
        oracledb.defaults.wallet_password = wallet_pwd

    print(f"Conectando a [{dsn}] en modo THIN (wallet_dir={wallet_dir}) user={_mask(user)}", flush=True)

    conn = None
    try:
        conn = oracledb.connect(user=user, password=password, dsn=dsn)
        yield conn
    finally:
        if conn:
            conn.close()


def main():
    owner = os.getenv("ADW_OWNER", "DWADW")

    with get_adw_connection() as conn:
        cur = conn.cursor()

        # Test mínimo: confirma service + sysdate
        cur.execute("select sys_context('userenv','service_name'), sysdate from dual")
        service, sysdate = cur.fetchone()
        print("SERVICE_NAME =", service)
        print("SYSDATE      =", sysdate)

        # --- aquí sigue tu lógica real de diccionario ---
        # Ejemplo: listar tablas del esquema owner
        cur.execute("""
            select table_name
            from all_tables
            where owner = :owner
            order by table_name
        """, owner=owner)

        tables = [r[0] for r in cur.fetchall()]
        print(f"Owner={owner}, tables={len(tables)}")

        cur.close()


if __name__ == "__main__":
    main()

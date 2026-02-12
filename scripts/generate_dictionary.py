import os
import oracledb

user = os.environ["ADW_USER"]
password = os.environ["ADW_PASSWORD"]
tns_alias = os.environ["ADW_TNS_ALIAS"]
wallet_dir = os.environ["ADW_WALLET_DIR"]
wallet_password = os.environ["ADW_WALLET_PASSWORD"]

# Fuerza modo Thin (recomendado en GitHub Actions)
oracledb.defaults.thin_mode = True

conn = oracledb.connect(
    user=user,
    password=password,
    dsn=tns_alias,
    config_dir=wallet_dir,
    wallet_location=wallet_dir,
    wallet_password=wallet_password
)

with conn.cursor() as cur:
    cur.execute("select 1 from dual")
    print("ADW CONNECT OK. Result:", cur.fetchone()[0])

conn.close()

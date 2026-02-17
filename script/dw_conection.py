import os, oracledb

owner = os.getenv("ADW_OWNER", "DWADW").upper()

conn = oracledb.connect(
    user=os.environ["ADW_USER"],
    password=os.environ["ADW_PASSWORD"],
    dsn=os.environ["ADW_TNS_ALIAS"],
)

cur = conn.cursor()
cur.execute("""
  SELECT table_name, num_rows
  FROM all_tables
  WHERE owner = :owner
  ORDER BY table_name
""", owner=owner)

for t, n in cur.fetchall():
    print(t, n)

cur.close()
conn.close()

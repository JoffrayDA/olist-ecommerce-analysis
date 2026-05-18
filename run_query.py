import duckdb
import sys

con = duckdb.connect('olist.duckdb')

sql_file = sys.argv[1]
with open(sql_file, 'r') as f:
    queries = f.read()

for query in queries.split(';'):
    query = query.strip()
    if query:
        result = con.execute(query).df()
        if not result.empty:
            print(result.to_string())
            print()

con.close()
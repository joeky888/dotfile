Sqlite Query
=====
* $ sqlite3 ./data.db # Open a db file
* $ .dump             # List all tables and struct of it
* $ .tables           # List all tables
* $ .schema           # Get struct of all tables
* $ .show                    # Print format
* $ .explain on              # Turn on column names on query results

MYSQL Query
=====
* > `SELECT table_name FROM information_schema.tables;` # Get all tables
* > SELECT * FROM tableName; # Get all data from a table

Import .gz to database (mysql)
=====
* $ apt install pv -y
* $ zcat dbpackfile.sql.gz | pv -cN zcat | mysql -uuser -ppass dbname

UI
=====
* Sqlitebrowser - Sqlite ui written in Qt

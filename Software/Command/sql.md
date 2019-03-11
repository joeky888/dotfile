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
* $ zcat < [Database].sql.gz | mysql -u root -ppass [Database Name in MySQL]
* Or with progress bar
* $ apt install pv -y
* $ zcat [Database].sql.gz | pv -cN zcat | mysql -uuser -ppass [Database Name in MySQL]

UI
=====
* Sqlitebrowser - Sqlite ui written in Qt

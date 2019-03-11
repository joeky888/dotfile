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
* See also ~/dotfile/Programming/RelationalDB.md
```sql
show databases; /* List all databases */
create database [DatabaseName]; /* Create a database */
describe [DatabaseName]; /* Get info from a database */
use [DatabaseName]; /* Use a database */

show tables; /* List all tables */

SELECT table_name FROM information_schema.tables; /* Get all tables */
SELECT * FROM tableName; /* Get all data from a table */
```

Import .gz to database (mysql)
=====
* $ zcat < [Database].sql.gz | mysql -h 127.0.0.1 --port=3306 -u root -ppass [Database Name in MySQL]
* Or with progress bar
* $ apt install pv -y
* $ zcat [Database].sql.gz | pv -cN zcat | mysql -h 127.0.0.1 --port=3306 -uuser -ppass [Database Name in MySQL]

UI
=====
* Sqlitebrowser - Sqlite ui written in Qt

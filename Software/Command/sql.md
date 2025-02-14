Sqlite Query
=====
* $ sqlite3 ./data.db # Open a db file
* $ .dump             # List all tables and struct of it
* $ .tables           # List all tables
* $ .schema           # Get struct of all tables
* $ .show                    # Print format
* $ .explain on              # Turn on column names on query results

Postgres Create a database and a user to it
=====
```sql
create database mydb;
create user myuser with encrypted password 'mypass';
GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;
-- If above doesn't work
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO myuser;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO myuser;
ALTER DATABASE mydb OWNER TO myuser;
```

Postgres move data to another empty db (搬家)
=====
```sql
pg_dump -c -C -h localhost source_db | psql -h destination_host -U destination_user -p destination_port destination_db
```

MYSQL Query
=====
* See also ~/dotfile/Programming/RelationalDB.md
```sql
show databases; /* List all databases */
create database [DatabaseName]; /* Create a database */
describe [DatabaseName]; /* Get info from a database */
use [DatabaseName]; /* Use a database */

show tables; /* List all tables */
show create table [TableName] /* Get structure of a table */

SELECT table_name FROM information_schema.tables; /* Get all tables */
SELECT * FROM tableName; /* Get all data from a table */
```
* Insert if not exist, Update if exist
```sql
-- Mysql and Sqlite
REPLACE INTO table (id, field, field2)
       SELECT 3, 'C', 'Z'
       WHERE NOT EXISTS (SELECT 1 FROM table WHERE id=3);

-- Postgresql - Use Update and Insert at the same time
UPDATE table SET field='C', field2='Z' WHERE id=3;
INSERT INTO table (id, field, field2)
       SELECT 3, 'C', 'Z'
       WHERE NOT EXISTS (SELECT 1 FROM table WHERE id=3);
```

Export all database
=====
* $ mysqldump -h 127.0.0.1 --port=3306 -u user -p123456 --opt --all-databases --no-autocommit --skip-lock-tables > db.sql
* $ mysqldump -h 127.0.0.1 --port=3306 -u user -p123456 --opt --all-databases --no-autocommit --skip-lock-tables | gzip > "db.sql.gz"
* Limit rows
* $ mysqldump -h 127.0.0.1 --port=3306 -u user -p123456 --opt --all-databases --no-autocommit --skip-lock-tables --where="1 limit 1000" > db.sql

Import .gz to database (mysql)
=====
* $ zcat < [Database].sql.gz | mysql -h 127.0.0.1 --port=3306 -u root -ppass [Database Name in MySQL]
* Or with progress bar
* $ apt install pv -y
* $ zcat [Database].sql.gz | pv -cN zcat | mysql -h 127.0.0.1 --port=3306 -uuser -ppass [Database Name in MySQL]
* Or using gzcat
* $ gzcat [Database].sql.gz | pv -cN gzcat | mysql -h 127.0.0.1 --port=3306 -uuser -ppass [Database Name in MySQL]

PostgreSQL truncate and reset id
=====
```sql
-- Erase all data and reset id
TRUNCATE `TABLENAME` RESTART IDENTITY CASCADE;

-- Only reset id
ALTER SEQUENCE <TABLE_NAME>_<COLUMN_NAME>_seq RESTART WITH 4044007;
-- For example ALTER SEQUENCE public.market_prices_history_id_seq RESTART WITH 4044007;
```


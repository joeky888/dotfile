Basics
=====
* Row(列)     == Tuple(值組) == 一筆資料
* Field(欄位) == Attribute(屬性)
* Primary Key(主鍵)
    * 具有唯一識別性的欄位
    * id
* Super key(超鍵)
    * 只要具有一個唯一識別性的屬性的集合即可稱爲 Super key
    * 最小的 Super key 集合爲單一元素 {id}
    * 最大的 Super key 集合爲全部元素 {id, birthday, phone, class}
* Candidate Key(候選鍵)
    * 具有最少元素的 Super key 即可稱爲 Candidate Key
    * 簡單說就是足以區分各 Tuple 不會發生碰撞所需的最小 table
    * Eg: {id}、{phone}、{birthday, class}
* Alternative Key(替代鍵)
    * 有機會成爲 Primary Key(主鍵) 的其他鍵
* Foreign Key(外來鍵)
    * 非主鍵但是在另一個 table 是主鍵
    * 不具唯一識別性

Data type
=====
* char: static-memory-allocation string
* varchar: dynamic memory allocation string
* int
* float
* decimal(m,n): Format a number. (m=total length, n=float point length)
* date: YYYY-MM-DD
* time: HH:MM:SS
* timestamp: YYYYMMDDHHMMSS

MyISAM vs InnoDB
=====
* MyISAM: Faster
    * Default option of Mysql
* InnoDB: More secure
    * Support Transaction
        * Atomicity(原子性)：對資料庫的操作要麼全部被執行，要麼都不執行。
        * Consistency(一致性)：交易應確保資料庫的狀態從一個一致狀態轉變為另一個一致狀態。
        * Isolation(隔離性)：多個交易並發執行時，一個交易的執行不應影響其他交易的執行。
        * Durability(持久性)：資料庫的修改應該永久保存在資料庫中。
    * Support Foreign Key
    * Support Rollback (Undo)

Create and delete database
=====
* Create <Database|Schema> <DBName>
```sql
Create Database Mydb1;
Create Schema   Mydb2;
```
* Delete <Database|Schema> <DBName>
```sql
Drop Database Mydb1;
Drop Schema   Mydb2;
```

Create and delete table
=====
```sql
CREATE TABLE Department
(Dname CHAR(10) NOT NULL,
Dno INT,
Dadd CHAR(20),
PRIMARY KEY(Dno)
) ENGINE=INNODB;
```
```sql
DROP TABLE Department;
```

Add/Drop/Update a new Field from an exist table
=====
```sql
ALTER TABLE Emp
ADD Sex CHAR(1);
```
```sql
ALTER TABLE Emp
DROP Sex;
```

Insert/Delete/Update tuples in a table
=====
```sql
INSERT INTO MyTable (Ssn, Name, Address, Salary)
VALUES (‘F111111111’, ‘myname’, ‘myaddress’, 20000);

DELETE FROM employee WHERE Salary < 20000;
DELETE FROM employee WHERE Ssn = ‘F111111111’;

UPDATE employee SET Address = 'myAddress', Salary =10000 WHERE Ssn = 'F111111113';
```

Selection
=====
* Selection
    * Select    (must)
    * From      (must)
    * Where     (optional)
    * Group by  (optional)
    * Having    (optional for Group by)
    * Order by  (optional)
* Expression function
    * COUNT()
        * COUNT(*): 計算表格中共有幾筆非空記錄
        * COUNT(欄位名稱): 此屬性有幾筆非空值
        * COUNT(DISTINCT 欄位名稱): 此屬性有幾筆不同的非空值
    * SUM()
    * AVG()
    * MAX()
    * MIN()
* 列出供應商 “大勝” 有供應的所有零件中,重量最重之重量
```sql
SELECT MAX(數量) AS 最大數量
    FROM Supplier as S, Component as C, Project_supp_Component P
    WHERE S.供應商代號= P.供應商代號 AND
    C. 零件代號= P.零件代號 AND
    S.供應商名稱=‘大勝’;
```
* 列出位於高雄的供應商數目
```sql
SELECT COUNT(*) as 供應商數目
FROM Supplier
WHERE 城市=‘高雄’;
```


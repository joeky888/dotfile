Start server
=====
* $ mongod --dbpath ../path/to/mydb

Connect to server
=====
* $ mongo
* By defalt it will use test db
* create and use a db called "mydb"
* $ use mydb

Show all dbs
=====
* $ show dbs

Insert and Create "hi" collection
=====
* $ db.hi.insert({"Hi" : {"text" : "this is first hi"}})
* If collection "db.hi" is not exist, it will automatically created one

Show all collections in a db
=====
* $ db.getCollectionNames()

Show all data in a collection
=====
* $ show db.hi.find()

Kill a collection
=====
* $ show db.hi.drop()

Kill current db
=====
* db.dropDatabase()
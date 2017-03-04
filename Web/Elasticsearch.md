Concept
=====
* Index -> database
* Types -> tables
* Documents -> rows
* Fields -> columns
* localhost:9200/a/b/c, a = index, b = type, c = id
* Shard
    * an index is composed of many shards
    * Search and save documents

Create new database
=====
* Download elasticsearch.zip and unzip it
* $ cd elasticsearch/bin
* $ ./elasticsearch
* Change the cluster name in config/elasticsearch.yml

Add new index
=====
* Add an index called twitter
* number\_of\_shards = number of shards in an index
* number\_of\_replicas = number of copies from each in other machines
```sh
curl -XPUT 'localhost:9200/twitter?pretty' -d'
{
    "settings" : {
        "index" : {
             "number_of_shards" : 5,
             "number_of_replicas" : 1
         }
     }
 }'
```

Remove index
=====
* Remove an index called twitter
```sh
curl -XDELETE 'localhost:9200/twitter?pretty'
```

Add types
=====
* Add `questions` and `user` type to `twitter` index
```sh
curl -XPUT 'localhost:9200/twitter?pretty' -d'
{
    "mappings": {
        "questions": {
            "_all": {
                "enabled": false
            },
            "properties": {
                "created": {
                    "format": "strict_date_optional_time||epoch_millis",
                    "type": "date"
                },
                "title": {
                    "type": "text"
                },
                "body": {
                    "type": "text"
                },
                "user_id": {
                    "type": "keyword"
                },
                "comments": {
                    "type": "keyword"
                },
                "answers": {
                    "type": "keyword"
                }
            }
        },
        "user": {
            "_all": {
                "enabled": false
            },
            "properties": {
                "age": {
                    "type": "integer"
                },
                "name": {
                    "type": "text"
                },
                "title": {
                    "type": "text"
                }
            }
        }
    }
}'
```

Search in traditional chinese / simplified chinese
=====
* Insetall smartcn plugin
* Restart server
* Test
```sh
curl -XPOST 'localhost:9200/_analyze?pretty' -d'
{
  "analyzer": "smartcn",
  "text": "smartcn 可以支持簡體的搜尋，是官方發佈的外掛，可惜似乎不開源"
}'
```

Install Head plugin to show index in web browser
=====
* Install head plugin
* Add two dangerous lines to config/elasticsearch.yml
```yaml
http.cors.enabled: true
http.cors.allow-origin: /https?:\/\/localhost(:[0-9]+)?/
```
* Restart elasticsearch

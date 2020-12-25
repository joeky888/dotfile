Display a field of json
=====
```sql
{job="mysql"} | json | line_format "{{.message}}"
```

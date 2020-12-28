Display a field of json
=====
```sql
{job="mysql"} | json | line_format "{{.message}}"
```
* And query
```sql
{k8s_container="pf-affiliate",k8s_namespace="tgc"} | json | line_format "{{.message}}" |= "err"
```

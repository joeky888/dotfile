Basic
=====
```go
func main() {
    var m sync.Map
    // Insert
    m.Store("1","a")
    // Select
    fmt.Println(m.Load("1"))
    // Delete
    m.Delete("1")
    // Iterate
    m.Range(func(k, v interface{}) bool {
        fmt.Println(k,v)
        return true // If false, function will exit immediately
    })
}
```

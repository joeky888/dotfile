Unbuffered channel (Sync)
=====
```go
func main() {
    c := make(chan bool)
    go func() {
        fmt.Println("GO GO GO")
        c <- true
    }()
    <-c
}
// Print GO GO GO
```
* Or
```go
func main() {
    c := make(chan bool)
    go func() {
        fmt.Println("GO GO GO")
        <-c
    }()
    c <- true
}
// Print GO GO GO
```

Buffered channel (Async)
=====
```go
func main() {
    c := make(chan bool, 1)
    go func() {
        fmt.Println("GO GO GO")
        <-c
    }()
    c <- true
}
// Print Nothing
```

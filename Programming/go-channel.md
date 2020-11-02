Buffered vs Unbuffered
=====
* Buffered chan is Async while Unbffered chan is Sync
    * Buffered channel will not wait for the receiver
* Buffered Channel can also be used in
    * thread pool
    * rate limit
    * batch and buffer mode (eg. batch 10 items every sec in a memory buffer of 999 items)

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

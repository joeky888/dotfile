Null and non-Null
=====
* Go uses `nil`
* Rust uses Option<T> which throws Some and None

Error handling
=====
* Go uses `err != nil`
* Rust uses Result<T> which throws Ok and Err

Anonymous function (closure)
=====
* Go uses `func(x) { print(x) }`
* Rust uses `|x| { println("{}", x); }`

Dynamic array
=====
* Go uses slice
```go
slice := make([]int, 5, 10)
slice = append(slice, 6)
fmt.Printf("Slice: %+v", slice)
```
* Rust uses vector
```rust
let mut xs = vec![1i32, 2, 3];
xs.push(6);
println!("Vector: {:?}", xs);
```


Null and non-Null
=====
* Go uses `nil`
* Rust uses Option<T> which throws Some and None
    * Option<T>.unwrap() will give the value or panic if the value is None

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

Hashmap
=====
* Go uses map
```go
attended := map[string]bool{
    "Ann": true,
    "Joe": true,
}
if val, ok := attended["Ann"]; ok {
    //do something here
}
```
* Rust uses hashmap
```go
let mut hash = HashMap::new();

hash.insert("one", "eins");
hash.insert("two", "zwei");
hash.insert("three", "drei");

let data = match hash.get("one") {
    None => "",
    Some(v) => *v
};
assert_eq!(data, "eins");
```

Struct and Method
=====
```go
type Cart struct {
    Name  string
    Price int
}

func (this *Cart) GetPrice() {
    fmt.Println("price:", this.Price)
}
```
```rust
#[derive(Debug)]
struct Cart {
    Name: u32,
    Price: u32,
}

impl Cart {
    pub fn GetPrice(&self) -> u32 {
        self.Name * self.Price
    }
}
```

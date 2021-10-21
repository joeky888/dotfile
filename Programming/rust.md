Install new packages to current project
=====
* $ go get github.com/xxx/xxx
* $ cargo install cargo-edit # Must install cargo-edit firsttt
* $ cargo add xxx

Print
=====
* Print value and address
```rust
let x = 1;
let ptr_y = &x;
println!("x: {}, ptr_y: {}, address: {:p}", x, ptr_y, ptr_y);
```

Null and non-Null
=====
* Go uses `nil`
* Rust uses Option<T> which throws Some and None
    * Option<T>.unwrap() will give the value or panic if the value is None
    * Option<T>.expect("Some error msg here") same with unwrap but gives msg when panic

Error handling
=====
* Go uses `err != nil`
* Rust uses Result<T> which throws Ok and Err
    * Result<T>.unwrap() will give the value or panic if the value is None
    * Result<T>.expect("Some error msg here") same with unwrap but gives msg when panic
    * `Result<T>.unwrap_or_else(|err| panic!("Couldn't read: {}", err.to_string()))` same with expect but gives both error and custom msg

Question mark ?
=====
* Used to simplified match-case statements
* Gets the value or returns the error from the Promise Result<T> or Option<T>
* Result<String, std::io::Error>? means
```go
if err != nil {
    return err
}
return val
```

String vs str
=====
* Always use &str not str which means `char*` in C++, immutable
* String means std::string in C++, mutable

Sprint
=====
* Go uses fmt.Sprint
* Rust uses format!("{} {}!", hello, world);

Interface (a collection of methods that others can implement)
=====
* Go uses interface
* Rust uses trait

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
    fn new(name: u32, price: u32) -> Self {
        Self { Name:name, Price:price }
    }

    pub fn GetPrice(&self) -> u32 {
        self.Name * self.Price
    }
}
```

Smart pointer
=====
* Go doesn't have smart pointers
* Rust uses Box<T>

Loop in array and hashmap
=====
* Go uses `for range`
* Rust uses `iter()`
```go
// simple for loop
for i := 0; i < 10; i++ {
    fmt.Println(i)
}

// loop in built-in hashmap
for k, v := range m {
    fmt.Printf("key[%s] value[%s]\n", k, v)
}

// loop in thread-safe sync.Map
m.Range(func(k, v interface{}) bool {
    fmt.Println(k,v)
    return true
})
```
```rust
// using for_each
(0..10).for_each(|i| {
    result[i * 3 / 3] = data[0] + data[1] + data[0 + 1 + 2];
});

// array with iter() and map
let nums = vec![1, 2, 3, 4, 5];
let nums = nums.iter().map(|x| x * 2).collect::<Vec<i32>>();

// array with iter().enumerate()
let v = vec![1, 2, 3];
for (i, n) in v.iter().enumerate() {
    println!("v[{}] = {}", i, n);
}

// hashmap with iter()
for (key, value) in items.iter() {
    println!("ITER KEY, VALUE: {} {}", key, value);
}

// rayon-rs powered for_each
(0..3).into_par_iter().for_each(|i| {
    result[i * 3 / 3] = data[0] + data[1] + data[0 + 1 + 2];
});

// rayon-rs powered hashmap(hashbrown)
// hashbrown = { version = "0.11.2", features = ["rayon"] }
items.par_iter().for_each(|(key, value)| println!("key={} value={}", key, value));
```

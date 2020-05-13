Performance
=====
* Don't use too many mutex lock
* Use pointer when using append() function

3 Ways to controll goroutines
=====
* context.Done()
* <-channels
* sync.WaitGroup.Wait()

Class method get/set
=====
```go
type Cart struct {
    Name  string
    Price int
}

func (this *Cart) GetPrice() {
    fmt.Println("price:", this.Price)
}

func (this *Cart) SetPrice(price int) {
    fmt.Println("[pointer] Update Price to", price)
    this.Price = price
}

func main() {
    c := &Cart{"bage", 100}
    c.GetPrice()
    c.SetPrice(200)
    c.GetPrice()
}
```

Class bind custom function to an object
=====
```go
type Thing struct {
    Name  string
    Num   int
    OnChange func()
}

func NewThing(someParameter string) (*Thing, error) {
    this := new(Thing)
    this.Name = someParameter
    this.Num = 33 // <- a very sensible default value
    return this, nil
}
```
* Usage
```go
t, _ := NewThing("hi")
t.OnChange = func() {
    fmt.Print(t)
}
t.OnChange()
```

Reflect interface value
=====
```go
val := reflect.ValueOf(unkownTypeInterfaceObj)

val.Interface() // Original value
val.Addr().Interface() // Get address (if original value is vlue)
val.Elem().Interface() // Get value (if original value is address)

val.Index(i) // Get i-th element (if original value is an array)
val.Index(i).Set(someValue) // Set i-th element (if original value is an array)
val.Len() // Get array length (if original value is an array)

val.Kind() == reflect.Uint32 // Check type

/* Create value to a new variable */
typ := reflect.TypeOf(unkownTypeInterfaceObj)
newVal := reflect.New(typ).Interface()

/* Create slice of a type */
arr := reflect.MakeSlice(reflect.SliceOf(typ), 0, 0)
arr = reflect.Append(arr, someVal) // Push a value to slice
arr.Interface()
```

Colorful output
=====
```go
import (
    "github.com/mattn/go-colorable"
    "fmt"
)
out := colorable.NewColorableStdout()
fmt.Fprintln(out, "\u001b[30mTEXT30\u001b[39m")
fmt.Fprintln(out, "\u001b[31mTEXT31\u001b[39m")
fmt.Fprintln(out, "\u001b[32mTEXT32\u001b[39m")
fmt.Fprintln(out, "\u001b[33mTEXT33\u001b[39m")
fmt.Fprintln(out, "\u001b[34mTEXT34\u001b[39m")
fmt.Fprintln(out, "\u001b[35mTEXT35\u001b[39m")
fmt.Fprintln(out, "\u001b[36mTEXT36\u001b[39m")
fmt.Fprintln(out, "\u001b[37mTEXT37\u001b[39m")
fmt.Fprintln(out, "\u001b[90mTEXT90\u001b[39m")
fmt.Fprintln(out, "\u001b[91mTEXT91\u001b[39m")
fmt.Fprintln(out, "\u001b[92mTEXT92\u001b[39m")
fmt.Fprintln(out, "\u001b[93mTEXT93\u001b[39m")
fmt.Fprintln(out, "\u001b[94mTEXT94\u001b[39m")
fmt.Fprintln(out, "\u001b[95mTEXT95\u001b[39m")
fmt.Fprintln(out, "\u001b[96mTEXT96\u001b[39m")
fmt.Fprintln(out, "\u001b[97mTEXT97\u001b[39m")

fmt.Fprintln(out, "\u001b[40mTEXT40\u001b[49m")
fmt.Fprintln(out, "\u001b[41mTEXT41\u001b[49m")
fmt.Fprintln(out, "\u001b[42mTEXT42\u001b[49m")
fmt.Fprintln(out, "\u001b[43mTEXT43\u001b[49m")
fmt.Fprintln(out, "\u001b[44mTEXT44\u001b[49m")
fmt.Fprintln(out, "\u001b[45mTEXT45\u001b[49m")
fmt.Fprintln(out, "\u001b[46mTEXT46\u001b[49m")
fmt.Fprintln(out, "\u001b[47mTEXT47\u001b[49m")
fmt.Fprintln(out, "\u001b[100mTEXT100\u001b[49m")
fmt.Fprintln(out, "\u001b[101mTEXT101\u001b[49m")
fmt.Fprintln(out, "\u001b[102mTEXT102\u001b[49m")
fmt.Fprintln(out, "\u001b[103mTEXT103\u001b[49m")
fmt.Fprintln(out, "\u001b[104mTEXT104\u001b[49m")
fmt.Fprintln(out, "\u001b[105mTEXT105\u001b[49m")
fmt.Fprintln(out, "\u001b[106mTEXT106\u001b[49m")
fmt.Fprintln(out, "\u001b[107mTEXT107\u001b[49m")
```

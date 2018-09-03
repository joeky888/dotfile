Constructor of a class
=====
```go
package mything

type Thing struct {
    Name  string
    Num   int
}

func NewThing(someParameter string) *Thing {
    this := new(Thing)
    this.Name = someParameter
    this.Num = 33 // <- a very sensible default value
    return this
}
// Or with err
func NewThing(someParameter string) (*Thing, error) {
    this := new(Thing)
    this.Name = someParameter
    this.Num = 33 // <- a very sensible default value
    return this, nil
}
// Or just
func NewThing(someParameter string) *Thing {
    return &Thing{someParameter, 33}
}
```
* Usage
```go
import "mything"

t := mything.NewThing("hi")
```

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

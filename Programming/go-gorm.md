Preloading
=====
```go
type Order struct {
	gorm.Model
	OrderItems []OrderItem
}

type OrderItem struct {
	gorm.Model
	OrderID uint
}

func main() {
	db, err := gorm.Open("sqlite3", "test.db")
	if err != nil {
		panic(err)
	}
	defer db.Close()
	db.LogMode(true)

	db.AutoMigrate(&Order{})
	db.AutoMigrate(&OrderItem{})

	db.Create(&Order{})
	db.Create(&Order{})
	db.Create(&OrderItem{OrderID: 1})
	db.Create(&OrderItem{OrderID: 1})

	var order Order
	db.Preload("OrderItems").Where("id = 1").Find(&order)
	fmt.Printf("%+v", order)
}
```

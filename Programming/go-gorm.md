Preloading with gorm.Model
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

Preloading with foreign key
=====
```go
type Order struct {
	OrderID    uint
	OrderItems []OrderItem `gorm:"foreignkey:OrderIDOfOrderItem; association_foreignkey:OrderID"`
}

type OrderItem struct {
	OrderItemID uint
	OrderIDOfOrderItem uint
}

func main() {
	db, err := gorm.Open("sqlite3", "test.db")
	if err != nil {
		panic(err)
	}
	defer db.Close()
	db.LogMode(true)

	db.AutoMigrate(
		&Order{},
		&OrderItem{},
	)

	db.Create(&Order{OrderID: 1})
	db.Create(&Order{OrderID: 2})
	db.Create(&OrderItem{OrderItemID: 1, OrderIDOfOrderItem: 1})
	db.Create(&OrderItem{OrderItemID: 2, OrderIDOfOrderItem: 1})

	var order Order
	db.Preload("OrderItems").Where("order_id = 1").Find(&order)
	fmt.Printf("%+v", order)
}
```

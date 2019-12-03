SQL and Golang numbers
=====
* TINYINT = int8 = (-128~127)
* SMALLINT = int16 = (-32768~327677)
* INT = int32 = (-2147483648~2147483647)
* BIGINT = int64 = (-9223372036854775808~9223372036854775807)
* TINYINT UNSIGNED = uint8 = (0~255)
* SMALLINT UNSIGNED = uint16 = (0~65535)
* INT UNSIGNED = uint32 = (0~4294967295)
* BIGINT UNSIGNED = uint64 = (0~18446744073709551615)
* FLOAT = float32 = (-3.402823466E+38~3.402823466E+38)
* DOUBLE = float64 = (-1.7976931348623157E+308~1.7976931348623157E+308)
* DECIMAL(6,2) = `6 total number of digits, 4 before and 2 after the decimal point` = (github.com/shopspring/)decimal.Decimal

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
	db.Preload("OrderItems").Where("id = 1").First(&order)
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
	db.Preload("OrderItems").Where("order_id = 1").First(&order)
	fmt.Printf("%+v", order)
}
```

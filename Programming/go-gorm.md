### SQL and Golang numbers

| MySQL           | Go              | Range                                                            |
| --------------- | --------------- | ---------------------------------------------------------------- |
| TINYINT         | int8            | (-128~127)                                                       |
| SMALLINT        | int16           | (-32768~327677)                                                  |
| INT             | int32           | (-2147483648~2147483647)                                         |
| BIGINT          | int64           | (-9223372036854775808~9223372036854775807)                       |
| TINYINT         | uint8           | (0~255)                                                          |
| SMALLINT        | uint16          | (0~65535)                                                        |
| INT UNSIGNED    | uint32          | (0~4294967295)                                                   |
| BIGINT UNSIGNED | uint64          | (0~18446744073709551615)                                         |
| FLOAT           | float32         | (-3.402823466E+38~3.402823466E+38)                               |
| DOUBLE          | float64         | (-1.7976931348623157E+308~1.7976931348623157E+308)               |
| DECIMAL(6,2)    | decimal.Decimal | 6 total number of digits, 4 before and 2 after the decimal point |

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

Insert or Update
=====
```go
package main

import (
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
)

type Order struct {
	ID   uint32 `gorm:"primary_key;AUTO_INCREMENT"`
	Name string
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
	)

	o := Order{ID: 1, Name: "453"}
	// Method 1
	db.Where("id = ?", o.ID).Save(&o)
	// Method 2
	db.Where("id = ?", o.ID).Assign(o).FirstOrCreate(&o)
}

```

Json array
=====
```go
package main

import (
	"database/sql/driver"
	"strings"
	"encoding/json"
	"fmt"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
)

type User struct {
	ID  uint32 `gorm:"primary_key;AUTO_INCREMENT"`
	IPs IP     `gorm:"type:json"`
}

type IP []string

// Value Overide
func (p IP) Value() (driver.Value, error) {
	str, err := json.Marshal(p)
	return string(str), err
}

// Scan Overide
func (p *IP) Scan(input interface{}) error {
	in := strings.TrimPrefix(strings.TrimSuffix(input.(string), "'"), "'")
	err := json.Unmarshal([]byte(in), p)
	return err
}

func main() {
	db, err := gorm.Open("sqlite3", "test.db")
	if err != nil {
		panic(err)
	}
	defer db.Close()
	db.LogMode(true)

	// Create table
	db.AutoMigrate(
		&User{},
	)

	var u User
	db.Create(&User{IPs: IP{"0.0.0.0", "1.1.1.1"}})

	db.Where("id = ?", 1).First(&u)
	fmt.Printf("%+v\n", u)
}

```

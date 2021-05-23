### SQL and Golang numbers

| MySQL             | Go              | Range                                                            |
| ----------------- | --------------- | ---------------------------------------------------------------- |
| TINYINT(1)        | bool            | (0~1)                                                            |
| TINYINT           | int8            | (-128~127)                                                       |
| SMALLINT          | int16           | (-32768~327677)                                                  |
| INT               | int32           | (-2147483648~2147483647)                                         |
| BIGINT            | int64           | (-9223372036854775808~9223372036854775807)                       |
| TINYINT UNSIGNED  | uint8           | (0~255)                                                          |
| SMALLINT UNSIGNED | uint16          | (0~65535)                                                        |
| INT UNSIGNED      | uint32          | (0~4294967295)                                                   |
| BIGINT UNSIGNED   | uint64          | (0~18446744073709551615)                                         |
| FLOAT             | float32         | (-3.402823466E+38~3.402823466E+38)                               |
| DOUBLE            | float64         | (-1.7976931348623157E+308~1.7976931348623157E+308)               |
| DECIMAL(6,2)      | decimal.Decimal | 6 total number of digits, 4 before and 2 after the decimal point |

| PostgreSQL       | Go                  | Range                                                            |
| ---------------- | ------------------- | ---------------------------------------------------------------- |
| boolean          | bool                | (0~1)                                                            |
| smallint         | int8,int16,uint8    | (-32768~32767)                                                   |
| integer          | int32,uint16        | (-2147483648~2147483647)                                         |
| bigint           | int64,uint32,uint64 | (-9223372036854775808~9223372036854775807)                       |
| real             | float32             | 6 decimal digits precision                                       |
| double precision | float64             | 15 decimal digits precision                                      |
| decimal(6,2)     | decimal.Decimal     | 6 total number of digits, 4 before and 2 after the decimal point |

Transaction
=====
* Must be called inside of db.Transaction closure
```go
func CreateAnimals(db *gorm.DB) error {
  return db.Transaction(func(tx *gorm.DB) error {
    // do some database operations in the transaction (use 'tx' from this point, not 'db')
    if err := tx.Create(&Animal{Name: "Giraffe"}).Error; err != nil {
      // return any error will rollback
      return err
    }

    if err := tx.Create(&Animal{Name: "Lion"}).Error; err != nil {
      return err
    }

    // return nil will commit
    return nil
  })
}
```

Soft delete and hard delete
=====
```go
type Order struct {
	gorm.Model
}

// Soft delete
db.Delete(&order)
// Hard delete
db.Unscoped().Delete(&order)
```

Preloading with gorm.Model
=====
```go
package main

import (
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
)

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

Preloading with foreign key and OrderItemID stored on Order table
=====
```go
package main

import (
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
)

type Order struct {
	OrderID    uint
	ItemID     uint
	OrderItems []*OrderItem `gorm:"foreignkey:OrderItemID; association_foreignkey:ItemID"`
}

type OrderItem struct {
	OrderItemID uint
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

	db.Create(&Order{OrderID: 1, ItemID: 1})
	db.Create(&Order{OrderID: 2, ItemID: 2})
	db.Create(&OrderItem{OrderItemID: 1})
	db.Create(&OrderItem{OrderItemID: 2})

	var order Order
	db.Preload("OrderItems").Where("order_id = 1").First(&order)
	fmt.Printf("%+v", order)
}
```

Preloading with foreign key and OrderID stored on OrderItem table
=====
```go
package main

import (
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
)

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

// Value Override
func (p IP) Value() (driver.Value, error) {
	str, err := json.Marshal(p)
	return string(str), err
}

// Scan Override
func (p *IP) Scan(input interface{}) error {
	return json.Unmarshal(input.([]byte), p)
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

Bulk insert and upsert(update or insert)
=====
* [](https://github.com/t-tiger/gorm-bulk-insert) or [](https://github.com/bombsimon/gorm-bulk/blob/master/examples/bulk_insert.go)
```go
// For mysql, spcifying which columns to update
db := db.Model(&MyType{}).
		Set(
			"gorm:insert_option",
			"ON DUPLICATE KEY UPDATE field1 = VALUES(field1), field2 = VALUES(field2)",
		)
// For pgsql, spcifying which columns to update
db := db.Model(&MyType{}).
		Set(
			"gorm:insert_option",
			"ON CONFLICT (city_key) DO UPDATE SET city_key = EXCLUDED.city_key, city_id = EXCLUDED.city_id",
		)
gormbulk.BulkInsert(db, sliceValue, 3000)
```
* The DUPLICATE/CONFLICT update sql can be auto genareted
```go
var matchFirstCap = regexp.MustCompile("(.)([A-Z][a-z]+)")
var matchAllCap = regexp.MustCompile("([a-z0-9])([A-Z])")

func ToSnakeCase(str string) string {
	snake := matchFirstCap.ReplaceAllString(str, "${1}_${2}")
	snake = matchAllCap.ReplaceAllString(snake, "${1}_${2}")
	return strings.ToLower(snake)
}

func getSqlName(field reflect.StructField) string {
	fieldSnake := ""

	for _, value := range strings.Split(field.Tag.Get("gorm"), ";") {
		if value == "skip" {
			return ""
		}
		if value == "" {
			continue
		}
		v := strings.Split(value, ":")
		k := strings.TrimSpace(strings.ToUpper(v[0]))
		if k == "COLUMN" {
			fieldSnake = strings.TrimSpace(v[1])
			break
		}
	}

	if fieldSnake == "" {
		fieldSnake = ToSnakeCase(field.Name)
	}

	return fieldSnake
}

func getFieldType(typ reflect.Type) []string {
	filedsStr := make([]string, 0)
	for i := 0; i < typ.NumField(); i++ {
		fieldTyp := typ.Field(i).Type

		if fieldTyp.Kind() == reflect.Ptr {
			fieldTyp = fieldTyp.Elem()
		}

		if fieldTyp.Name() == "Time" { // time.Time is a struct kind, ignore
			filedsStr = append(filedsStr, getSqlName(typ.Field(i)))
			continue
		}

		if fieldTyp.Kind() == reflect.Struct {
			filedsStr = append(filedsStr, getFieldType(fieldTyp)...)
			continue
		}

		filedsStr = append(filedsStr, getSqlName(typ.Field(i)))
	}

	return filedsStr
}

func GenUpdatePgsql(value interface{}) string {
	sql := "UPDATE SET "

	typ := reflect.TypeOf(value)
	if typ.Kind() == reflect.Ptr {
		// *struct -> struct in order to use .NumField()
		typ = typ.Elem()
	}

	sqlFields := getFieldType(typ)

	sqlStrs := make([]string, 0, len(sqlFields))
	for i := 0; i < len(sqlFields); i++ {
		if sqlFields[i] != "" { // Not `skip`
			sqlStrs = append(sqlStrs, sqlFields[i]+" = EXCLUDED."+sqlFields[i])
		}
	}

	return sql + strings.Join(sqlStrs, ", ")
}

func main() {
	order := &Order{}
	log.Println(GenUpdatePgsql(order))
}
```

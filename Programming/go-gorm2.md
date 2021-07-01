Bulk Insert vs Batch Insert
=====
* Bulk: insert all, e.g. insert 10000 at one time
* Batch: group insert with a buffer size, e.g. insert 1000 at one time for all 10000 records

Custom type like Json array
=====
```go
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
```

Custom type like Json array
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

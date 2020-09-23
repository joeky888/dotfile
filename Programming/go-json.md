Json notes
=====
* Always using github.com/json-iterator/go
* Make sure "omitempty" is combined with pointer type, otherwise it will be removed for zero-values (0 and "")
```go
Field *string `json:"field,omitempty"`
```

Flatten json and Nested json
=====
* Flatten
```go
type MyStruct struct {
	gorm.Model
}
```
* Nested
```go
type MyStruct struct {
	Model gorm.Model
}
```

Bool with optional quotes "true" / true / "false" / false
=====
```go
package main

import (
	"encoding/json"
	"log"
)

type User struct {
	ID      uint32   `gorm:"primary_key;AUTO_INCREMENT"`
	IsOwner flexBool `json:"is_owner"`
}

type flexBool bool

func (b flexBool) MarshalJSON() ([]byte, error) {
	return json.Marshal(bool(b))
}

func (b *flexBool) UnmarshalJSON(data []byte) error {
	if len(data) >= 2 && data[0] == '"' && data[len(data)-1] == '"' {
		data = data[1 : len(data)-1]
	}

	var tmp bool
	err := json.Unmarshal(data, &tmp)
	if err != nil {
		return err
	}

	*b = flexBool(tmp)
	return nil
}
func main() {
	user := &User{}

	// "true"
	if err := json.Unmarshal([]byte(`{"id": 1, "is_owner": "true"}`), user); err != nil {
		log.Panic(err)
	}
	log.Println(user.IsOwner)

	// true
	if err := json.Unmarshal([]byte(`{"id": 1, "is_owner": true}`), user); err != nil {
		log.Panic(err)
	}
	log.Println(user.IsOwner)
}
```

package database

import (
	"time"

	"github.com/dgrijalva/jwt-go"
)

// User struct
type User struct {
	ID        uint32 `gorm:"primary_key;AUTO_INCREMENT" json:"id"`
	CreatedAt time.Time
	UpdatedAt time.Time
	DeletedAt *time.Time
	UserName  string `gorm:"unique;not null"`
	Password  string
}

// PlaygroundToken struct
type PlaygroundTokenClaims struct {
	UID      uint32 `json:"uid"`
	UserName string `json:"username"`
	jwt.StandardClaims
}

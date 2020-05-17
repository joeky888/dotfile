package database

import (
	"fmt"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/joeky888/go-playground/config"
	"golang.org/x/crypto/bcrypt"
)

var DB *gorm.DB

func InitDatabase() {
	dsn := fmt.Sprintf("%v:%v@tcp(%v:%v)/%v?charset=%v&parseTime=true&loc=UTC&multiStatements=true",
		config.Env.Database.Username,
		config.Env.Database.Password,
		config.Env.Database.Host,
		config.Env.Database.Port,
		config.Env.Database.DbName,
		config.Env.Database.Encoding)
	db, err := gorm.Open("mysql", dsn)
	if err != nil {
		panic(err)
	}
	DB = db

	DB.LogMode(config.Env.Database.LogMode)
	dbSeed()
}

func dbSeed() {
	if !ifTableExist(DB, "users") {
		DB.AutoMigrate(&User{})
		if err := CreateNewUser(&User{
			UserName: "joeky",
			Password: "123456",
		}); err != nil {
			panic(err)
		}
	}
}

func bcryptHash(payload string) string {
	password := []byte(payload)

	// Hashing the password with the default cost of 10
	hashedPassword, err := bcrypt.GenerateFromPassword(password, bcrypt.DefaultCost)
	if err != nil {
		panic(err)
	}
	return string(hashedPassword)
}

// bcryptCompare compares hashedPassword and password
func bcryptCompare(hashedPassword, password string) bool {
	if err := bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password)); err != nil {
		return false
	}
	return true
}

func ifTableExist(db *gorm.DB, tableName string) bool {
	count := 0
	dbErr := db.Table(`INFORMATION_SCHEMA.TABLES`).
		Where(`table_schema = ?
			AND table_name = ?
			AND TABLE_TYPE = 'BASE TABLE'`,
			config.Env.Database.DbName, tableName).Count(&count)

	if dbErr.Error == nil {
		return count > 0
	}
	return false
}

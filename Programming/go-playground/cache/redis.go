package cache

import (
	"github.com/go-redis/redis"
	"github.com/joeky888/go-playground/config"
)

var Redis *redis.Client

func InitCache() {
	Redis = redis.NewClient(&redis.Options{
		Addr:     config.Env.Redis.Host + ":" + config.Env.Redis.Port,
		Password: config.Env.Redis.Password,
		DB:       0, // use default DB
	})
}

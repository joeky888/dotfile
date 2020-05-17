package main

import (
	"github.com/gin-gonic/gin"
	"github.com/joeky888/go-playground/cache"
	"github.com/joeky888/go-playground/config"
	"github.com/joeky888/go-playground/database"
	"github.com/joeky888/go-playground/endpoint"
	"github.com/joeky888/go-playground/router"
	"github.com/joeky888/go-playground/util"
)

func init() {
	config.InitConfig()
	database.InitDatabase()
	cache.InitCache()
	util.InitLogger()
	go endpoint.Manager.Start() // Websocket
	gin.SetMode(gin.DebugMode)
}

func main() {
	r := router.InitRouter()
	defer func() {
		if err := util.Logger.Sync(); err != nil {
			panic(err)
		}
	}()
	defer func() {
		if err := database.DB.Close(); err != nil {
			panic(err)
		}
	}()
	defer func() {
		if err := cache.Redis.Close(); err != nil {
			panic(err)
		}
	}()

	if err := r.Run(config.Env.HTTP.Addr); err != nil {
		panic(err)
	}
}

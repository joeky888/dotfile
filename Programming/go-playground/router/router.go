package router

import (
	"fmt"
	"net/http"
	"strconv"
	"strings"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-contrib/gzip"
	"github.com/gin-gonic/gin"
	"github.com/joeky888/go-playground/cache"
	"github.com/joeky888/go-playground/endpoint"
	"github.com/joeky888/go-playground/util"
	"go.uber.org/zap"
)

// InitRouter defines all routers
func InitRouter() *gin.Engine {
	r := gin.New()
	// Recovery middleware recovers from any panics and writes a 500 if there was one.
	r.Use(gin.Recovery())
	// r.Use(gin.Logger(), gin.Recovery())

	r.Use(ginzap(util.Logger, "Mon Jan 2 15:04:05 -0700 MST 2006", true))
	r.Use(gzip.Gzip(gzip.DefaultCompression))

	r.Use(cors.New(cors.Config{
		AllowOrigins: []string{
			"*",
			// "http://1.2.3.4",
		},
		AllowMethods:     []string{"GET", "POST", "PUT", "PATCH", "OPTIONS", "HEAD"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Accept", "Authorization"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
	}))

	r.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "ok",
		})
	})

	r.NoRoute(func(c *gin.Context) {
		c.String(http.StatusNotFound, "The incorrect API route.")
		util.Logger.Debug(fmt.Sprintf("The incorrect API route. %s%s", c.Request.Host, c.Request.URL))
	})
	r.POST("/register", endpoint.RegisterNewUser)
	r.POST("/login", endpoint.LoginUser)

	apiUser := r.Group("user")
	apiUser.Use(authMiddleware)
	{
		apiUser.GET("me", endpoint.Me)
	}

	apiWs := r.Group("/ws") // websocket
	apiWs.Use(authMiddleware)
	{
		apiWs.GET("me", endpoint.WsMe)
	}

	return r
}

func ginzap(logger *zap.Logger, timeFormat string, utc bool) gin.HandlerFunc {
	return func(c *gin.Context) {
		start := time.Now()
		path := c.Request.URL.Path
		query := c.Request.URL.RawQuery

		// ↑↑↑↑↑↑↑↑↑↑ before handler ↑↑↑↑↑↑↑↑↑
		c.Next()
		// ↓↓↓↓↓↓↓↓↓↓ after handler  ↓↓↓↓↓↓↓↓↓

		end := time.Now()
		latency := end.Sub(start)
		if utc {
			end = end.UTC()
		}

		if len(c.Errors) > 0 {
			for _, e := range c.Errors.Errors() {
				logger.Error(e)
			}
		} else {
			logger.Info(path,
				zap.Int("status", c.Writer.Status()),
				zap.String("method", c.Request.Method),
				zap.String("path", path),
				zap.String("query", query),
				zap.String("ip", c.ClientIP()),
				zap.String("user-agent", c.Request.UserAgent()),
				zap.String("time", end.Format(timeFormat)),
				zap.Duration("latency", latency),
			)
		}
	}
}

func authMiddleware(c *gin.Context) {
	authtoken := c.Request.Header.Get("Authorization")

	if authtoken == "" {
		c.AbortWithStatusJSON(endpoint.ErrNoToken.HTTPStatus, endpoint.ErrNoToken)
		return
	}
	authtoken = strings.TrimPrefix(authtoken, "Bearer ")

	uid, err := util.JwtDecrypt(authtoken)

	if err != nil {
		util.Logger.Error(err.Error())
		c.AbortWithStatusJSON(endpoint.ErrInvalidToken.HTTPStatus, endpoint.ErrInvalidToken)
		return
	}

	storedToken, err := cache.Redis.Get(strconv.Itoa(int(uid))).Result()
	if err != nil || storedToken != authtoken {
		c.AbortWithStatusJSON(endpoint.ErrTokenExpire.HTTPStatus, endpoint.ErrTokenExpire)
		return
	}

	c.Set("id", uid)
	// ↑↑↑↑↑↑↑↑↑↑ before handler ↑↑↑↑↑↑↑↑↑
	c.Next()
	// ↓↓↓↓↓↓↓↓↓↓ after handler  ↓↓↓↓↓↓↓↓↓
}

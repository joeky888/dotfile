package endpoint

import (
	"encoding/json"
	"fmt"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/gofrs/uuid"
	"github.com/gorilla/websocket"
	"github.com/joeky888/go-playground/cache"
	"github.com/joeky888/go-playground/database"
	"github.com/joeky888/go-playground/request"
	"github.com/joeky888/go-playground/util"
)

// RegisterNewUser curl -i localhost:8080/register -d '{"username":"joeky", "password":"123456"}'
func RegisterNewUser(c *gin.Context) {
	user := request.RegisterInput{}
	if err := c.BindJSON(&user); err != nil {
		c.AbortWithStatusJSON(ErrRegisterBind.HTTPStatus, ErrRegisterBind)
		return
	}

	if err := database.CreateNewUser(&database.User{
		UserName: user.Username,
		Password: user.Password,
	}); err != nil {
		c.AbortWithStatusJSON(ErrRegisterCreate.HTTPStatus, ErrRegisterCreate)
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"message": "ok",
	})
}

// LoginUser curl -i localhost:8080/login -d '{"username":"joeky", "password":"123456"}'
func LoginUser(c *gin.Context) {
	user := request.LoginInput{}
	if err := c.BindJSON(&user); err != nil {
		c.AbortWithStatusJSON(ErrRegisterBind.HTTPStatus, ErrRegisterBind)
		return
	}

	userEntity := database.User{UserName: user.Username, Password: user.Password}
	if !database.SearchUser(&userEntity) {
		c.AbortWithStatusJSON(ErrLoginNotFound.HTTPStatus, ErrLoginNotFound)
		return
	}

	token, err := util.JwtEncrypt(userEntity.ID, userEntity.UserName)
	if err != nil {
		c.AbortWithStatusJSON(ErrJwtEncrypt.HTTPStatus, ErrJwtEncrypt)
		return
	}

	util.Logger.Sugar().Debugf("UserID: %d UserName: %s Token: %s", userEntity.ID, userEntity.UserName, token)
	cache.Redis.Set(fmt.Sprint(userEntity.ID), token, 0)

	c.JSON(http.StatusOK, gin.H{
		"message": "ok",
		"token":   token,
	})
}

// Me curl -i -H "Authorization: Bearer xxx.xxx.xxx" localhost:8080/user/me
func Me(c *gin.Context) {
	id, ok := c.Get("id")
	uid := id.(uint32)
	if !ok {
		c.AbortWithStatusJSON(ErrLoginNotFound.HTTPStatus, ErrLoginNotFound)
		return
	}

	userEntity, err := database.SearchUserByID(uid)
	if err != nil {
		c.AbortWithStatusJSON(ErrLoginNotFound.HTTPStatus, ErrLoginNotFound)
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "ok",
		"user":    userEntity,
	})
}

// WsMe websocat ws://localhost:8080/ws/me -H "Authorization: Bearer xxx.xxx.xxx"
func WsMe(c *gin.Context) {
	id, ok := c.Get("id")
	uid := id.(uint32)
	if !ok {
		c.AbortWithStatusJSON(ErrLoginNotFound.HTTPStatus, ErrLoginNotFound)
		return
	}

	userEntity, err := database.SearchUserByID(uid)
	if err != nil {
		c.AbortWithStatusJSON(ErrLoginNotFound.HTTPStatus, ErrLoginNotFound)
		return
	}

	conn, err := (&websocket.Upgrader{CheckOrigin: func(r *http.Request) bool { return true }}).Upgrade(c.Writer, c.Request, nil)
	if err != nil {
		c.AbortWithStatusJSON(ErrLoginNotFound.HTTPStatus, ErrLoginNotFound)
		return
	}
	// websocket connect
	uuID, err := uuid.NewV4()
	if err != nil {
		c.AbortWithStatusJSON(ErrLoginNotFound.HTTPStatus, ErrLoginNotFound)
		return
	}
	client := &Client{ID: uuID.String(), Socket: conn, Send: make(chan []byte)}

	Manager.Register <- client

	go client.Read()
	go client.Write()
	go client.Ping()

	fmt.Println(userEntity)
	userByte, err := json.Marshal(userEntity)
	if err != nil {
		panic(err)
	}

	for {
		time.Sleep(3 * time.Second)
		client.Send <- []byte(time.Now().String())
		client.Send <- userByte
	}
}

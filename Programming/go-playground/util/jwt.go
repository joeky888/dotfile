package util

import (
	"time"

	"github.com/dgrijalva/jwt-go"
	"github.com/joeky888/go-playground/config"
	"github.com/joeky888/go-playground/database"
)

// JwtEncrypt JwtEncrypt
func JwtEncrypt(uid uint32, username string) (string, error) {

	tokenClaims := database.PlaygroundTokenClaims{
		UID: uid,
		UserName: username,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: time.Now().Unix() + config.Env.HTTP.TokenExpireSecond,
			Issuer:    "playground-offical",
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, tokenClaims)
	tokenString, err := token.SignedString([]byte(config.JwtSecretKey))

	if err != nil {
		return "", err
	}

	return tokenString, nil

}

// JwtDecrypt JwtDecrypt
func JwtDecrypt(cipherText string) (uint32, error) {
	token, err := jwt.ParseWithClaims(cipherText, &database.PlaygroundTokenClaims{}, func(token *jwt.Token) (interface{}, error) {
		return []byte(config.JwtSecretKey), nil
	})

	if err != nil {
	} else {
		// pass
		if playgroundToken, ok := token.Claims.(*database.PlaygroundTokenClaims); ok && token.Valid {
			return playgroundToken.UID, nil
		}
	}

	return 0, err
}

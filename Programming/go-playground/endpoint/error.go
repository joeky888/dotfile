package endpoint

import (
	"errors"
	"net/http"
)

// APIError error struct
type APIError struct {
	Code         int32  `json:"code"`
	ErrorMessage string `json:"msg"`
	HTTPStatus   int    `json:"-"`
	Err          error  `json:"-"`
}

func newErr(code int32, httpStatus int, message string) APIError {
	return APIError{
		Code:         code,
		HTTPStatus:   httpStatus,
		ErrorMessage: message,
		Err:          errors.New(message),
	}
}

var (
	ErrRegisterBind   = newErr(901, http.StatusBadRequest, "Register bind error")
	ErrRegisterCreate = newErr(902, http.StatusBadRequest, "Register DB create error")
	ErrLoginNotFound  = newErr(903, http.StatusBadRequest, "Login user or password wrong error")
	ErrJwtEncrypt     = newErr(904, http.StatusBadRequest, "Jwt creation failed")
	ErrNoToken        = newErr(905, http.StatusBadRequest, "Jwt token not found")
	ErrInvalidToken   = newErr(906, http.StatusBadRequest, "Jwt token invalid")
	ErrTokenExpire    = newErr(907, http.StatusBadRequest, "Jwt expired")
)

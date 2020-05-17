package util

import (
	"encoding/json"
	"time"

	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
)

var Logger *zap.Logger

func InitLogger() {
	rawCfg := []byte(`{
		"level": "debug",
		"encoding": "console",
		"development": true,
		"outputPaths": ["stdout"],
		"errorOutputPaths": ["stderr"],
		"initialFields": {},
		"encoderConfig": {
		  "messageKey": "message",
		  "levelKey": "level",
		  "levelEncoder": "lowercase",
		  "timeKey": "timestamp"
		}
	      }`)

	var cfg zap.Config
	if err := json.Unmarshal(rawCfg, &cfg); err != nil {
		panic(err)
	}
	cfg.EncoderConfig.EncodeTime = zapcore.TimeEncoder(func(t time.Time, enc zapcore.PrimitiveArrayEncoder) {
		enc.AppendString(t.UTC().Format("2006-01-02T15:04:05Z0700"))
		// 2019-08-13T04:39:11Z
	})
	cfg.EncoderConfig.EncodeDuration = zapcore.StringDurationEncoder

	logger, err := cfg.Build()
	if err != nil {
		panic(err)
	}

	// logger.Debug("Debug msg")
	// logger.Info("Info msg")
	// logger.Warn("Warn msg")
	// logger.Error("Error msg")
	// logger.Fatal("Fatal msg")

	// logger.Sugar().Debugf("debugf")
	// logger.Sugar().Warn("Warn")

	Logger = logger
	// if err := logger.Sync(); err != nil {
	// 	panic(err)
	// }
}

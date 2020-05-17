package config

import (
	"fmt"
	"strings"

	"github.com/spf13/viper"
)

// Config config model of env
type Config struct {
	Database  *DatabaseConfig
	HTTP      *HTTPConfig
	Redis     *RedisConfig
	Websocket *WebSocketConfig
	Logger    *LoggerConfig
	GRPC      *GRPCConfig
	Gin       *GinConfig
}

// Env is a global variable which stores all env variables from defaults and yaml
var Env Config

const (
	JwtSecretKey = "&Ea:p+CxrF@5D7&;"
)

// InitConfig init config file using viper
func InitConfig() {
	// database
	{
		viper.SetDefault("database.username", "root")
		viper.SetDefault("database.password", "123456")
		viper.SetDefault("database.host", "localhost")
		viper.SetDefault("database.port", "3306")
		viper.SetDefault("database.encoding", "utf8")
		viper.SetDefault("database.dbname", "playground")
		viper.SetDefault("database.timeout", "5000")
		viper.SetDefault("database.maxidleconns", "10")
		viper.SetDefault("database.maxconns", "10")
		viper.SetDefault("database.logmode", "true")
		viper.SetDefault("database.migrate", "false")
	}
	// redis
	{
		viper.SetDefault("redis.host", "localhost")
		viper.SetDefault("redis.port", "6379")
		viper.SetDefault("redis.password", "123456")
		viper.SetDefault("redis.index", "0")
		viper.SetDefault("redis.maxidleconns", "10")
		viper.SetDefault("redis.maxconns", "10")
		viper.SetDefault("redis.wait", "true")
		viper.SetDefault("redis.writetimeout", "100")
		viper.SetDefault("redis.readtimeout", "1000")
		viper.SetDefault("redis.idletimeout", "300000")
	}

	// HTTP
	{
		viper.SetDefault("http.addr", ":8080")
		// viper.SetDefault("http.pingaddr", "http://127.0.0.1:18086")
		// viper.SetDefault("http.b2baddr", ":18087")
		// viper.SetDefault("http.pingb2baddr", "http://127.0.0.1:18087")
		// viper.SetDefault("http.wsaddr", ":18088")
		// viper.SetDefault("http.pingwsaddr", "http://127.0.0.1:18088")
		// viper.SetDefault("http.baseurl", "")
		// viper.SetDefault("http.enablesports", []uint{})
		// viper.SetDefault("http.disableoffertypes", []uint{})
		viper.SetDefault("http.tokenexpiresecond", 7*24*60*60) // give it 1 week
		// viper.SetDefault("http.gamesummarytype", 1)
		// viper.SetDefault("http.enablemtspositioncheck", false)
	}

	// gin
	{
		viper.SetDefault("gin.logenable", "false")
		viper.SetDefault("gin.cachemode", "inmemory")
	}
	// grpc
	{
		viper.SetDefault("grpc.server", ":8443")
		viper.SetDefault("grpc.mlmapi", ":8443")
	}

	// websocket
	{
		viper.SetDefault("websocket.pingdelay", "10")
	}

	// Load config.yaml
	viper.SetConfigName("config")                    // name of config file (without extension)
	viper.SetConfigType("yaml")                      // REQUIRED if the config file does not have the extension in the name
	viper.AddConfigPath(".")                         // path to look for the config file in
	viper.AddConfigPath("./config")                  // call multiple times to add many search paths
	viper.AddConfigPath("/go/src/playground/config") // call multiple times to add many search paths
	viper.SetEnvKeyReplacer(strings.NewReplacer(".", "_"))
	viper.AutomaticEnv()
	err := viper.ReadInConfig() // Find and read the config file
	if err != nil {             // Handle errors reading the config file
		panic(fmt.Errorf("Fatal error config file: %s \n", err))
	}

	if err := viper.Unmarshal(&Env); err != nil {
		panic(err)
	}
}

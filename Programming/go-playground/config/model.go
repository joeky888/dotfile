package config

// DatabaseConfig 資料庫連線設定
type DatabaseConfig struct {
	Username     string
	Password     string
	Host         string
	Port         int
	Encoding     string
	DbName       string
	Timeout      int
	MaxIdleConns int
	MaxConns     int
	LogMode      bool
	Migrate      bool
}

// HTTPConfig http setting
type HTTPConfig struct {
	Addr              string
	TokenExpireSecond int64
	BaseURL           string
}

// WebSocketConfig web socket setting
type WebSocketConfig struct {
	PingAddr  string
	Addr      string
	PingDelay int64
}

// GinConfig  GIN 套件相關設定
type GinConfig struct {
	LogEnable bool
	CacheMode string
}

// RedisConfig redis 設定
type RedisConfig struct {
	Host         string
	Port         string
	Password     string
	Index        int
	MaxIdleConns int
	MaxConns     int
	WriteTimeout int
	ReadTimeout  int
	IdleTimeout  int
	Wait         bool
}

// LoggerConfig logger setting
type LoggerConfig struct {
	StdLevel  string
	FileLevel string
	Formatter string
}

// GRPCConfig config
type GRPCConfig struct {
	Server string
}

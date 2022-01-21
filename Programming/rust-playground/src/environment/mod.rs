use config::{builder::DefaultState, Config, ConfigBuilder, ConfigError, Environment, File};
use lazy_static::lazy_static;
use serde::Deserialize;
use std::sync::RwLock;

lazy_static! {
    pub static ref SETTINGS: RwLock<Settings> =
        RwLock::new(Settings::new().expect("Settings new() failed"));
}
#[derive(Debug, Deserialize)]
pub struct Settings {
    pub debug: Debug,
    pub database: Database,
    pub redis: Redis,
}

#[derive(Debug, Deserialize)]
pub struct Debug {
    pub enable: bool,   // config logger level
    pub color: bool,    // config logger color
    pub fileline: bool, // config logging file:line
}

#[derive(Debug, Deserialize)]
pub struct Database {
    pub url: String,
}

#[derive(Debug, Deserialize)]
pub struct Redis {
    pub url: String,
}

impl Settings {
    pub fn new() -> Result<Self, ConfigError> {
        Self::from_default_config()?
            .add_source(File::with_name("config/config.yml").required(false))
            .add_source(Environment::with_prefix("CORE").separator("_"))
            .build()?
            .try_deserialize()
    }

    fn from_default_config() -> Result<ConfigBuilder<DefaultState>, ConfigError> {
        let s = Config::builder()
            // Start off by merging in the "default" configuration file
            .set_default("database.url", "postgres://127.0.0.1")?
            .set_default("redis.url", "127.0.0.1:6379")?
            .set_default("debug.enable", true)?
            .set_default("debug.color", true)?
            .set_default("debug.fileline", true)?;
        Ok(s)
    }
}


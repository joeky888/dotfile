use config::{Config, ConfigError, Environment, File};
use lazy_static::lazy_static;
use serde::Deserialize;
use std::path::Path;
use std::sync::RwLock;

lazy_static! {
    pub static ref SETTINGS: RwLock<Settings> = RwLock::new(Settings::new().unwrap());
}
#[derive(Debug, Deserialize)]
pub struct Settings {
    pub database: Database,
    pub redis: Redis,
    pub debug: Debug,
}

#[derive(Debug, Deserialize)]
pub struct Debug {
    pub enable: bool, // config logger level
    pub color: bool,  // config logger color
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
        let mut s = Config::new();

        s.set_default("database.url", "postgres://127.0.0.1")?;
        s.set_default("redis.url", "127.0.0.1:6379")?;
        s.set_default("debug.enable", "true")?;
        s.set_default("debug.color", "true")?;

        // Start off by merging in the "default" configuration file
        let config_file = "config/config.yml";
        if Path::new(config_file).exists() {
            s.merge(File::with_name(config_file))?;
        }
        s.merge(Environment::with_prefix("APP").separator("_"))?;

        s.try_into()
    }
}


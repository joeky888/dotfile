use config::{Config, ConfigError, Environment, File};
use lazy_static::lazy_static;
use serde::Deserialize;
use std::{path::Path, sync::RwLock};

lazy_static! {
    pub static ref SETTINGS: RwLock<Settings> = RwLock::new(Settings::must_new());
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
    // pub fn new() -> Result<Self, ConfigError> {
    //     let mut s = Config::new();

    //     // s.set_default("debug.enable", "true")?;
    //     // s.set_default("debug.color", "true")?;
    //     Self::init_default(&mut s)?;

    //     let config_file = "config/config.yml";
    //     if Path::new(config_file).exists() {
    //         s.merge(File::with_name(config_file))?;
    //     }

    //     s.merge(Environment::with_prefix("APP").separator("_"))?;
    //     s.try_into()
    // }

    pub fn must_new() -> Self { // New enviorment and panics if error
        let mut s = Config::new();

        // s.set_default("debug.enable", "true")?;
        // s.set_default("debug.color", "true")?;
        Self::init_default(&mut s).expect("init default failed");

        let config_file = "config/config.yml";
        if Path::new(config_file).exists() {
            s.merge(File::with_name(config_file)).expect("merge config_file failed");
        }

        s.merge(Environment::with_prefix("APP").separator("_")).expect("merge prefix failed");
        s.try_into().expect("mustNew try_into failed")
    }

    fn init_default(config: &mut Config) -> Result<&mut Config, ConfigError> {
        config.set_default("database.url", "postgres://127.0.0.1")?;
        config.set_default("redis.url", "127.0.0.1:6379")?;

        config.set_default("debug.enable", true)?;
        config.set_default("debug.color", true)?;
        config.set_default("debug.fileline", true)?;
        Ok(config)
    }
}

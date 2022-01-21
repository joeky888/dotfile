#![forbid(unsafe_code)]
#![deny(unused_imports)]
#![deny(unused_must_use)]
#![deny(dead_code)]
#![deny(clippy::all, clippy::perf, clippy::nursery, clippy::pedantic)]
#![deny(clippy::filetype_is_file)]
#![deny(clippy::cargo)]
#![deny(clippy::unwrap_used)]
#![deny(clippy::panic)]
#![deny(clippy::match_like_matches_macro)]
#![deny(clippy::needless_update)]
#![allow(clippy::cargo_common_metadata)]

mod environment;
mod logger;

fn main() {
    logger::init();
    // let settings = environment::Settings::new();
    // environment::SETTINGS.read().unwrap().database
    log::debug!("{:?}", environment::SETTINGS.read().expect("read env failed"));
    log::debug!("{:?}", environment::SETTINGS.read().expect("read env failed").database.url);
    // environment::init();

    // log::debug!("{:?}", environment::SETTINGS.read().unwrap().get_str("qqq").unwrap());

    // log::debug!("{:?}",
    // environment::SETTINGS.read().unwrap().try_into::<HashMap<String, String>>().unwrap());

    // log::debug!("debug!");
    // log::info!("info!");
    // log::warn!("warn!");
    // log::error!("error!");
}

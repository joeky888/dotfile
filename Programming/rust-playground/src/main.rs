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
#![warn(
    missing_copy_implementations,
    missing_debug_implementations,
    missing_docs,
    rustdoc::broken_intra_doc_links,
    trivial_numeric_casts,
    unused_allocation
)]
#![allow(clippy::cargo_common_metadata)]

mod environment;
mod logger;

fn main() {
    logger::init();
    // let settings = environment::Settings::new();
    // environment::SETTINGS.read().unwrap().database
    log::debug!(
        "{:?}",
        environment::SETTINGS.read().expect("read env failed")
    );
    log::debug!(
        "{}",
        environment::SETTINGS
            .read()
            .expect("read env failed")
            .database
            .url
    );
    // log::debug!("debug!");
    // log::info!("info!");
    // log::warn!("warn!");
    // log::error!("error!");
}


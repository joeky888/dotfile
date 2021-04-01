mod environment;
mod logger;

fn main() {
    logger::init();
    // let settings = environment::Settings::new();
    // environment::SETTINGS.read().unwrap().database
    log::debug!("{:?}", environment::SETTINGS.read().unwrap());
    log::debug!("{:?}", environment::SETTINGS.read().unwrap().database.url);
    // environment::init();

    // log::debug!("{:?}", environment::SETTINGS.read().unwrap().get_str("qqq").unwrap());

    // log::debug!("{:?}",
    // environment::SETTINGS.read().unwrap().try_into::<HashMap<String, String>>().unwrap());

    // log::debug!("debug!");
    // log::info!("info!");
    // log::warn!("warn!");
    // log::error!("error!");
}

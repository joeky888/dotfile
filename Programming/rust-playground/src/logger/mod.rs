use backtrace::Backtrace;
use env_logger::{fmt::Color, Env};
use std::io::Write;
use chrono::prelude::Local;

pub fn init() {
    env_logger::Builder::from_env(Env::default().default_filter_or("trace"))
        .format(|buf, record| {
            let mut style = buf.style();
            let mut stack_trace = String::from("");

            match record.level() {
                log::Level::Trace => style.set_color(Color::Cyan).set_bold(true),
                log::Level::Debug => style.set_color(Color::Blue).set_bold(true),
                log::Level::Info => style.set_color(Color::Green).set_bold(true),
                log::Level::Warn => {
                    stack_trace = format!("\n{:?}", Backtrace::new());
                    style.set_color(Color::Yellow).set_bold(true)
                }
                log::Level::Error => {
                    stack_trace = format!("\n{:?}", Backtrace::new());
                    style.set_color(Color::Red).set_bold(true)
                }
            };

            // buf.timestamp() is the default timestamp and is human-unreadable
            // chrono::prelude::Local can display a better local time format
            // See https://github.com/chronotope/chrono/blob/main/src/format/strftime.rs

            // If you need to see the stack trace when build with --release
            // You need to add `debug = 1` under the section [profile.release]
            // which however, will increase the binary size

            let _ = writeln!(
                buf,
                "[{}] {} {} {}",
                Local::now().format("%Y-%m-%dT%H:%M:%S%.3f%z"),
                style.value(record.level()),
                record.args(),
                stack_trace
            );
            writeln!(
                &mut std::io::stderr(),
                "[{}] {} {} {}",
                Local::now().format("%Y-%m-%dT%H:%M:%S%.3f%z"),
                style.value(record.level()),
                record.args(),
                stack_trace
            )
        })
        .init();
}

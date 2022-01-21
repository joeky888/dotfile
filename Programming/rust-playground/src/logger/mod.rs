use crate::environment;
use backtrace::Backtrace;
use chrono::prelude::Local;
use env_logger::{fmt::Color, Env};
use std::io::Write;

pub fn init() {
    let log_level = if environment::SETTINGS
        .read()
        .expect("read env failed")
        .debug
        .enable
    {
        "debug"
    } else {
        "info"
    };

    env_logger::Builder::from_env(Env::default().default_filter_or(log_level))
        .format(|buf, record| {
            let mut level_style = buf.style();
            let mut time_style = buf.style();
            let mut stack_style = buf.style();
            let mut message_style = buf.style();
            let mut fileline_style = buf.style();

            let mut stack_trace = String::new();

            if environment::SETTINGS.read().expect("read env failed").debug.color {
                time_style.set_color(Color::Green);
                // level_style.set_color(Color::White);
                // stack_style.set_color(Color::White);
                message_style.set_color(Color::Cyan);
                fileline_style.set_color(Color::Yellow).set_bold(true);

                // Use the same color set the zap logger does
                match record.level() {
                    log::Level::Trace => level_style.set_color(Color::Blue).set_bold(true),
                    log::Level::Debug => level_style.set_color(Color::Magenta),
                    log::Level::Info => level_style.set_color(Color::Blue),
                    log::Level::Warn => {
                        stack_trace = format!("\n{:?}", Backtrace::new());
                        stack_style.set_color(Color::Yellow);
                        level_style.set_color(Color::Yellow)
                    }
                    log::Level::Error => {
                        stack_trace = format!("\n{:?}", Backtrace::new());
                        stack_style.set_color(Color::Red);
                        level_style.set_color(Color::Red)
                    }
                };
            } else {
                match record.level() {
                    log::Level::Warn | log::Level::Error => {
                        stack_trace = format!("\n{:?}", Backtrace::new());
                    }
                    _ => {}
                };
            }

            // buf.timestamp() is the default timestamp and is human-unreadable
            // chrono::prelude::Local provides a better local time format
            // See https://github.com/chronotope/chrono/blob/main/src/format/strftime.rs

            // If you need to see the stack trace when build with --release
            // You need to add `debug = 1` under the section [profile.release]
            // which however, this will increase the binary size

            // let mut fileline = String::new();

            let fileline = if environment::SETTINGS.read().expect("read env failed").debug.fileline {
                let file = record.file().unwrap_or("");
                let line = record.line().unwrap_or(0);
                format!("{}:{}", file, line)
            } else {
                String::new()
            };
            writeln!(
                buf,
                "{} {} {} {} {}",
                // Local::now().format("[%Y-%m-%dT%H:%M:%S%.3f%z]"),
                time_style.value(Local::now().format("[%Y-%m-%dT%H:%M:%S%.3f%z]")),
                fileline_style.value(fileline),
                level_style.value(record.level()),
                message_style.value(record.args()),
                stack_style.value(stack_trace),
            )
        })
        .init();
}

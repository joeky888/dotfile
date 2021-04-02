use backtrace::Backtrace;
use chrono::prelude::Local;
use env_logger::{fmt::Color, fmt::Style, Env};
use std::{io::Write, time};

pub fn init() {
    env_logger::Builder::from_env(Env::default().default_filter_or("trace"))
        .format(|buf, record| {
            let mut level_style = buf.style();
            let mut time_style = buf.style();
            let mut stack_style = buf.style();

            let mut stack_trace = String::new();

            time_style.set_color(Color::Cyan);
            stack_style.set_color(Color::Magenta);
            // let mut stdout = StandardStream::stdout(ColorChoice::Always);
            // stdout.set_color(ColorSpec::new().set_fg(Some(Color::Green)))?;

            // Use the same color set the zap logger does
            match record.level() {
                log::Level::Trace => level_style.set_color(Color::Blue).set_bold(true),
                log::Level::Debug => level_style.set_color(Color::Magenta),
                log::Level::Info => level_style.set_color(Color::Blue),
                log::Level::Warn => {
                    stack_trace = format!("\n{:?}", Backtrace::new());
                    level_style.set_color(Color::Yellow)
                }
                log::Level::Error => {
                    stack_trace = format!("\n{:?}", Backtrace::new());
                    level_style.set_color(Color::Red)
                }
            };

            // buf.timestamp() is the default timestamp and is human-unreadable
            // chrono::prelude::Local can display a better local time format
            // See https://github.com/chronotope/chrono/blob/main/src/format/strftime.rs

            // If you need to see the stack trace when build with --release
            // You need to add `debug = 1` under the section [profile.release]
            // which however, will increase the binary size
            // let timestamp = Local::now().format("%Y-%m-%dT%H:%M:%S%.3f%z");
            // let mut colored_time = ColorSpec::new().set_fg(Some(termcolor::Color::Yellow));

            writeln!(
                buf,
                "{} {} {} {}",
                // Local::now().format("[%Y-%m-%dT%H:%M:%S%.3f%z]"),
                time_style.value(Local::now().format("[%Y-%m-%dT%H:%M:%S%.3f%z]")),
                level_style.value(record.level()),
                record.args(),
                stack_style.value(stack_trace),
            )
        })
        .init();
}


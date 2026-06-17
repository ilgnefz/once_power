use chrono::Local;
use dirs::document_dir;
use std::fs::{create_dir_all, OpenOptions};
use std::io::Write;
use std::path::PathBuf;

/// 获取日志文件路径
fn get_log_path() -> Option<PathBuf> {
    let date = Local::now().format("%Y%m%d").to_string();
    document_dir().map(|dir| dir.join("OncePower").join(format!("err-{}.log", date)))
}

/// 确保日志目录存在
fn ensure_log_dir() -> bool {
    if let Some(log_path) = get_log_path() {
        if let Some(parent) = log_path.parent() {
            match create_dir_all(parent) {
                Ok(_) => return true,
                Err(e) => {
                    eprintln!("[RUST LOG] Failed to create log directory: {:?}", e);
                    return false;
                }
            }
        }
    }
    false
}

/// 写入日志到文件（仅发布模式）
fn write_log_to_file(message: &str) {
    if !ensure_log_dir() {
        return;
    }

    if let Some(log_path) = get_log_path() {
        if let Ok(mut file) = OpenOptions::new().create(true).append(true).open(log_path) {
            let timestamp = Local::now().format("%Y-%m-%d %H:%M:%S%.3f");
            let log_entry = format!("[{}] {}\n", timestamp, message);

            let _ = file.write_all(log_entry.as_bytes());
            let _ = file.flush();
        }
    }
}

/// 写入错误日志
/// 调试模式：打印到控制台
/// 发布模式：写入日志文件
pub fn write_error(message: &str) {
    let log_message = format!("[ERROR] {}", message);

    #[cfg(debug_assertions)]
    {
        println!("[RUST] {}", log_message);
    }

    #[cfg(not(debug_assertions))]
    {
        write_log_to_file(&log_message);
    }
}

/// 写入警告日志
/// 调试模式：打印到控制台
/// 发布模式：写入日志文件
pub fn write_warning(message: &str) {
    let log_message = format!("[WARNING] {}", message);

    #[cfg(debug_assertions)]
    {
        println!("[RUST] {}", log_message);
    }

    #[cfg(not(debug_assertions))]
    {
        write_log_to_file(&log_message);
    }
}

/// 写入信息日志
/// 调试模式：打印到控制台
/// 发布模式：写入日志文件
pub fn write_info(message: &str) {
    let log_message = format!("[INFO] {}", message);

    #[cfg(debug_assertions)]
    {
        println!("[RUST] {}", log_message);
    }

    #[cfg(not(debug_assertions))]
    {
        write_log_to_file(&log_message);
    }
}

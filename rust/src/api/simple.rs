use filetime_creation::{FileTime, set_file_atime, set_file_ctime, set_file_mtime};
use trash;
use zhconv::zhconv;

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(sync)]
pub fn set_ctime(file_path: String, time: i64) -> Result<(), String> {
    let file_time = FileTime::from_unix_time(time as i64, 0);
    set_file_ctime(&file_path, file_time).map_err(|e| e.to_string())
}

#[flutter_rust_bridge::frb(sync)]
pub fn set_mtime(file_path: String, time: i64) -> Result<(), String> {
    let file_time = FileTime::from_unix_time(time as i64, 0);
    set_file_mtime(&file_path, file_time).map_err(|e| e.to_string())
}

#[flutter_rust_bridge::frb(sync)]
pub fn set_atime(file_path: String, time: i64) -> Result<(), String> {
    let file_time = FileTime::from_unix_time(time as i64, 0);
    set_file_atime(&file_path, file_time).map_err(|e| e.to_string())
}

#[flutter_rust_bridge::frb(sync)]
pub fn simplified_to_traditional(text: String) -> String {
    zhconv(&text, "zh-Hant".parse().unwrap())
}

#[flutter_rust_bridge::frb(sync)]
pub fn traditional_to_simplified(text: String) -> String {
    zhconv(&text, "zh-Hans".parse().unwrap())
}

#[flutter_rust_bridge::frb]
pub async fn delete_to_trash(file_path: String) -> Option<String> {
    trash::delete(&file_path).map_err(|e| e.to_string()).err()
}

#[flutter_rust_bridge::frb]
pub async fn delete_all_to_trash(file_paths: Vec<String>) -> Option<String> {
    trash::delete_all(&file_paths)
        .map_err(|e| e.to_string())
        .err()
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
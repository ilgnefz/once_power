use rexif::{ExifTag};
use zhconv::{zhconv};
use trash;

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb]
pub fn get_image_capture_date(image_path: String) -> Option<String> {
    let exif_data = match rexif::parse_file(&image_path) {
        Ok(data) => data,
        Err(_) => return None,
    };
    for entry in exif_data.entries {
        if entry.tag == ExifTag::DateTimeOriginal {
            return Some(entry.value.to_string());
        }
    }
    None
}

#[flutter_rust_bridge::frb(sync)] 
pub fn simplified_to_traditional(text: String) -> String {
    zhconv(&text, "zh-Hant".parse().unwrap())
}

#[flutter_rust_bridge::frb(sync)] 
pub fn traditional_to_simplified(text: String) -> String {
    zhconv(&text, "zh-Hans".parse().unwrap())
}

#[flutter_rust_bridge::frb(sync)]
pub fn delete_to_trash(file_path: String) -> Option<String> {
    match std::fs::metadata(&file_path) {
        Ok(_) => {},
        Err(e) => return Some(format!("{}", e)),
    };
    
    match trash::delete(file_path) {
        Ok(_) => None,
        Err(e) => Some(e.to_string()),
    }
}
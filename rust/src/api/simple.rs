use rexif::ExifTag;
use trash;
use zhconv::zhconv;

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

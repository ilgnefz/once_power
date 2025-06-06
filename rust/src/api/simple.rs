use rexif::{parse_file, ExifTag};

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



#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

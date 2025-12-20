use exif::{In, Tag, Value};
use std::fs::File;
use std::io::BufReader;

pub struct CameraInfo {
    pub make: Option<String>,
    pub model: Option<String>,
    pub capture: Option<String>,
    pub latitude: Option<f64>,
    pub longitude: Option<f64>,
}

#[flutter_rust_bridge::frb]
pub fn get_image_meta_info(image_path: String) -> Option<CameraInfo> {
    let file = File::open(&image_path).ok()?;
    let mut buf_reader = BufReader::new(file);
    let exif_reader = exif::Reader::new();
    
    // 解析 EXIF 数据
    let exif = exif_reader.read_from_container(&mut buf_reader).ok()?;

    let mut make = None;
    let mut model = None;
    let mut capture = None;
    let mut latitude = None;
    let mut longitude = None;

    // 提取基础信息
    if let Some(field) = exif.get_field(Tag::Make, In::PRIMARY) {
        let value = field.display_value().with_unit(&exif).to_string();
        // 移除双引号并转换为String类型
        make = Some(value.trim_matches('"').to_string());
    }
    if let Some(field) = exif.get_field(Tag::Model, In::PRIMARY) {
        let value = field.display_value().to_string();
        // 移除双引号并转换为String类型
        model = Some(value.trim_matches('"').to_string());
    }
    if let Some(field) = exif.get_field(Tag::DateTimeOriginal, In::PRIMARY) {
        capture = Some(field.display_value().to_string());
    }

    // 提取并转换 GPS 数据
    let lat_field = exif.get_field(Tag::GPSLatitude, In::PRIMARY);
    let lat_ref_field = exif.get_field(Tag::GPSLatitudeRef, In::PRIMARY);
    if let (Some(lat), Some(lat_ref)) = (lat_field, lat_ref_field) {
        latitude = parse_gps_coord(lat, lat_ref);
    }

    let lon_field = exif.get_field(Tag::GPSLongitude, In::PRIMARY);
    let lon_ref_field = exif.get_field(Tag::GPSLongitudeRef, In::PRIMARY);
    if let (Some(lon), Some(lon_ref)) = (lon_field, lon_ref_field) {
        longitude = parse_gps_coord(lon, lon_ref);
    }

    Some(CameraInfo {
        make,
        model,
        capture,
        latitude,
        longitude,
    })
}

/// 解析 kamadak-exif 的 GPS 坐标字段
fn parse_gps_coord(field: &exif::Field, ref_field: &exif::Field) -> Option<f64> {
    // 确保值是 Rational 类型（度、分、秒）
    if let Value::Rational(ref dms) = field.value {
        if dms.len() >= 3 {
            let deg = dms[0].to_f64();
            let min = dms[1].to_f64();
            let sec = dms[2].to_f64();
            
            let mut dd = deg + (min / 60.0) + (sec / 3600.0);
            
            // 处理方位引用 (N/S, E/W)
            let ref_str = ref_field.display_value().to_string();
            if ref_str.contains('S') || ref_str.contains('W') {
                dd = -dd;
            }
            return Some(dd);
        }
    }
    None
}
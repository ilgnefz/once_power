use lofty::prelude::*;
use lofty::probe::Probe;
use rexif::{ExifTag, TagValue};
use std::path::Path;

use crate::api::{file_type::{AudioMetaInfo, PhotoMetaInfo}, gps_info::{is_in_china, wgs84_to_gcj02}};

/// 验证日期字符串是否有效
/// 过滤掉像 ":  :     :  : " 这样的无效格式，但保留包含"上午"或"下午"的有效日期
fn is_valid_date(date_str: &str) -> bool {
    // 去除空格后检查是否为空或者只有冒号和空格
    let cleaned = date_str.replace(' ', "");
    if cleaned.is_empty() || cleaned.chars().all(|c| c == ':' || c == ' ') {
        return false;
    }
    
    // 如果包含上午或下午，认为是有效的中文格式
    if date_str.contains("上午") || date_str.contains("下午") {
        return true;
    }
    
    // 检查是否至少包含一些数字（基本的日期验证）
    date_str.chars().any(|c| c.is_ascii_digit())
}

/// 处理EXIF日期字符串，转换为标准格式
/// 输入格式: "2020:03:10 18:56:08"
/// 输出格式: "2020-03-10T18:56:08"
/// 处理失败时返回: "0000-01-01T00:00:00"
fn format_date(date_str: &str) -> String {
    let trimmed = date_str.trim();
    let date_str = trimmed.chars().take(19).collect::<String>();
    let parts: Vec<&str> = date_str.split_whitespace().collect();
    
    if parts.is_empty() {
        return "0000-01-01T00:00:00".to_string();
    }
    
    let date_part = parts[0];
    let date_part = date_part.replace(':', "-");
    
    let time_part = parts.get(1).unwrap_or(&"00:00:00");
    
    format!("{}T{}", date_part, time_part)
}

/// 解析GPS坐标并转换为高德地图坐标
/// 直接处理rexif的URational数据，避免字符串转换的中间步骤
fn parse_gps_coordinates(lat_value: &TagValue, lon_value: &TagValue) -> Result<(f64, f64), String> {
    // 直接从URational数据解析坐标
    let wgs_lat = parse_urational_coordinate(lat_value)?;
    let wgs_lon = parse_urational_coordinate(lon_value)?;
    
    // 判断是否在中国境内
    if is_in_china(wgs_lat, wgs_lon) {
        // 转换为火星坐标(GCJ-02)
        let (gcj_lat, gcj_lon) = wgs84_to_gcj02(wgs_lat, wgs_lon);
        Ok((gcj_lat, gcj_lon))
    } else {
        // 境外保持WGS84坐标
        Ok((wgs_lat, wgs_lon))
    }
}

/// 直接从URational数据解析坐标
fn parse_urational_coordinate(value: &TagValue) -> Result<f64, String> {
    match value {
        TagValue::URational(rationals) => {
            if rationals.len() < 3 {
                return Err("GPS坐标需要至少3个有理数".to_string());
            }
            
            // 解析度分秒
            let degrees = rationals[0].numerator as f64 / rationals[0].denominator.max(1) as f64;
            let minutes = rationals[1].numerator as f64 / rationals[1].denominator.max(1) as f64;
            let seconds = rationals[2].numerator as f64 / rationals[2].denominator.max(1) as f64;
            
            // 转换为十进制度
            Ok(degrees + (minutes / 60.0) + (seconds / 3600.0))
        },
        _ => Err("GPS坐标必须是有理数数组".to_string())
    }
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_image_meta_info(image_path: String) -> Option<PhotoMetaInfo> {
    let exif_data = match rexif::parse_file(&image_path) {
        Ok(data) => data,
        Err(_) => return None,
    };

    let mut make = None;
    let mut model = None;
    let mut latitude = None;
    let mut longitude = None;
    let mut lat_value = None;
    let mut lon_value = None;
    
    // 分别保存三个日期字段
    let mut date_time_original = None;
    let mut date_time_digitized = None;
    let mut date_time = None;

    // 收集EXIF数据
    for entry in exif_data.entries {
        match entry.tag {
            ExifTag::Make => make = Some(entry.value.to_string()),
            ExifTag::Model => model = Some(entry.value.to_string()),
            ExifTag::DateTimeOriginal => date_time_original = Some(entry.value.to_string()),
            ExifTag::DateTimeDigitized => date_time_digitized = Some(entry.value.to_string()),
            ExifTag::DateTime => date_time = Some(entry.value.to_string()),
            ExifTag::GPSLatitude => lat_value = Some(entry.value),
            ExifTag::GPSLongitude => lon_value = Some(entry.value),
            _ => {},
        }
    }
    
    // 按照优先级顺序给capture赋值，过滤无效日期并处理格式
    let mut capture = date_time_original
        .filter(|dt| is_valid_date(dt))
        .or(date_time_digitized.filter(|dt| is_valid_date(dt)))
        .or(date_time.filter(|dt| is_valid_date(dt)));

    if capture.is_none() {
        return None;
    } else {
        capture = capture.map(|dt| format_date(&dt));
    }
    
    // 解析GPS坐标
    if let (Some(lat_val), Some(lon_val)) = (lat_value, lon_value) {
        match parse_gps_coordinates(&lat_val, &lon_val) {
            Ok((lat, lon)) => {
                latitude = Some(lat);
                longitude = Some(lon);
            },
            Err(e) => {
                eprintln!("GPS坐标解析失败: {}", e);
            }
        }
    }
   
    Some(PhotoMetaInfo {
        make,
        model,
        capture,
        latitude,
        longitude,
    })
}

#[flutter_rust_bridge::frb(sync)]
// 注意：这是完整的 get_audio_info 函数实现
pub fn get_audio_meta_info(file_path: &str) -> AudioMetaInfo {
    let mut info = AudioMetaInfo {
        title: String::new(),
        artist: String::new(),
        album: String::new(),
        year: String::new(),
    };

    let path = Path::new(file_path);
    let tagged_file = Probe::open(path)
        .expect("ERROR: Bad path provided!")
		.read()
		.expect("ERROR: Failed to read file!");

    let tag = match tagged_file.primary_tag() {
        Some(primary_tag) => primary_tag,
        None => return info,
    };

    info.title = tag.title().unwrap_or_default().to_string();
    info.artist = tag.artist().unwrap_or_default().to_string();
    info.album = tag.album().unwrap_or_default().to_string();
    info.year = tag.get_string(ItemKey::RecordingDate)
        .or_else(|| tag.get_string(ItemKey::Year))
        .unwrap_or_default().to_string();

    info
}
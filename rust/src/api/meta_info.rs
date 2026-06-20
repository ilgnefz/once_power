use std::collections::HashMap;

use crate::api::file_info::parse_str_datetime;
use crate::api::log::write_error;
use crate::api::models::{AudioMetaInfo, Resolution, VideoMetaInfo};
use exiftool_rs::ExifTool;
use roxmltree::Document;

/// 验证日期字符串是否有效
/// 过滤掉像 ":  :     :  : " 这样的无效格式，但保留包含"上午"或"下午"的有效日期
pub fn is_valid_date(date_str: &str) -> bool {
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
fn format_date(date_str: &str) -> Option<String> {
    let trimmed = date_str.trim();
    let date_str = trimmed.chars().take(19).collect::<String>();
    let parts: Vec<&str> = date_str.split_whitespace().collect();

    if parts.is_empty() {
        // TOOD: 添加错误日志
        write_error(&format!("Invalid date format: {}", date_str));
        return None;
    }

    let date_part = parts[0];
    let date_part = date_part.replace(':', "-");

    let time_part = parts.get(1).unwrap_or(&"00:00:00");

    Some(format!("{}T{}", date_part, time_part))
}

// pub fn datetime_to_int(date_str: &str) -> Option<i64> {
//     let formatted = format_date(date_str)?;
//     let naive = NaiveDateTime::parse_from_str(&formatted, "%Y-%m-%dT%H:%M:%S").ok()?;
//     let utc = Utc.from_utc_datetime(&naive);
//     Some(utc.timestamp())
// }

pub fn get_audio_meta_info(file_path: &str) -> AudioMetaInfo {
    let mut info: AudioMetaInfo = AudioMetaInfo {
        title: String::new(),
        artist: String::new(),
        album: String::new(),
        year: String::new(),
    };

    let et = ExifTool::new();
    let tags = match et.extract_info(file_path) {
        Ok(tags) => tags,
        Err(why) => {
            write_error(&format!(
                "Error extracting tags from {}: {:?}",
                file_path, why
            ));
            Vec::new()
        }
    };

    if tags.is_empty() {
        return info;
    }

    let wanted_tags = ["Title", "Artist", "Album", "Date"];

    let results: HashMap<&str, String> = tags
        .iter()
        .filter(|tag| wanted_tags.contains(&tag.name.as_str()))
        .map(|tag| (tag.name.as_str(), tag.print_value.clone()))
        .collect();

    info.title = results.get("Title").cloned().unwrap_or_default();
    info.artist = results.get("Artist").cloned().unwrap_or_default();
    info.album = results.get("Album").cloned().unwrap_or_default();
    info.year = results.get("Date").cloned().unwrap_or_default();

    info
}

pub fn get_image_size(image_path: &str, ext: &str) -> Option<Resolution> {
    if ext == "svg" {
        return get_svg_size(image_path);
    }
    match imagesize::size(image_path) {
        Ok(size) => {
            // info.width = size.width as u32;
            // info.height = size.height as u32;
            Some(Resolution {
                width: size.width as u32,
                height: size.height as u32,
            })
        }
        Err(why) => {
            write_error(&format!(
                "Error getting dimensions for {}: {:?}",
                image_path, why
            ));
            None
        }
    }
}

pub fn get_svg_size(svg_path: &str) -> Option<Resolution> {
    let doc = Document::parse(svg_path).ok()?;
    let svg = doc.root_element();

    // 优先 width / height
    if let (Some(w), Some(h)) = (svg.attribute("width"), svg.attribute("height")) {
        let w = parse_svg_length(w)?;
        let h = parse_svg_length(h)?;
        return Some(Resolution {
            width: w,
            height: h,
        });
    }

    // 其次 viewBox
    if let Some(view_box) = svg.attribute("viewBox") {
        let parts: Vec<&str> = view_box.split_whitespace().collect();
        if parts.len() == 4 {
            let w = parts[2].parse::<f32>().ok()?;
            let h = parts[3].parse::<f32>().ok()?;
            return Some(Resolution {
                width: w as u32,
                height: h as u32,
            });
        }
    }

    None
}

fn parse_svg_length(s: &str) -> Option<u32> {
    let s = s
        .trim()
        .trim_end_matches('%') // 忽略 %
        .trim_end_matches("px") // 忽略 px
        .trim_end_matches("pt") // 忽略 pt
        .trim_end_matches("em"); // 忽略 em

    let v = s.parse::<f32>().ok()?;

    // 防御非法值
    if !v.is_finite() || v < 0.0 {
        return None;
    }

    Some(v.round() as u32)
}

pub fn get_video_meta_info(video_path: &str) -> VideoMetaInfo {
    let mut info: VideoMetaInfo = VideoMetaInfo {
        width: 0,
        height: 0,
        make: String::new(),
        model: String::new(),
        capture: None,
    };

    let et = ExifTool::new();
    let tags = match et.extract_info(video_path) {
        Ok(tags) => tags,
        Err(why) => {
            write_error(&format!(
                "Error extracting tags from {}: {:?}",
                video_path, why
            ));
            Vec::new()
        }
    };

    if tags.is_empty() {
        return info;
    }

    let wanted_tags = [
        "SourceImageWidth",
        "SourceImageHeight",
        "ImageWidth",
        "ImageHeight",
        "AndroidMake",
        "AndroidModel",
        "CreateDate",
        "MediaCreateDate",
        "TrackCreateDate",
    ];

    let results: HashMap<&str, String> = tags
        .iter()
        .filter(|tag| wanted_tags.contains(&tag.name.as_str()))
        .map(|tag| (tag.name.as_str(), tag.print_value.clone()))
        .collect();

    info.width = results
        .get("SourceImageWidth")
        .cloned()
        .and_then(|s| s.parse().ok())
        .filter(|&v| v != 0)
        .or_else(|| {
            results
                .get("ImageWidth")
                .cloned()
                .and_then(|s| s.parse().ok())
                .filter(|&v| v != 0)
        })
        .unwrap_or(0);
    info.height = results
        .get("SourceImageHeight")
        .cloned()
        .and_then(|s| s.parse().ok())
        .filter(|&v| v != 0)
        .or_else(|| {
            results
                .get("ImageHeight")
                .cloned()
                .and_then(|s| s.parse().ok())
                .filter(|&v| v != 0)
        })
        .unwrap_or(0);
    info.make = results.get("AndroidMake").cloned().unwrap_or_default();
    info.model = results.get("AndroidModel").cloned().unwrap_or_default();

    let capture = results
        .get("CreateDate")
        .filter(|dt| is_valid_date(dt))
        .or(results
            .get("MediaCreateDate")
            .filter(|dt| is_valid_date(dt)))
        .or(results
            .get("TrackCreateDate")
            .filter(|dt| is_valid_date(dt)));
    info.capture = capture.and_then(|dt| parse_str_datetime(dt));

    info
}

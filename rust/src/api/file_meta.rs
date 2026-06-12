use std::collections::HashMap;

use crate::api::file_type::{AudioMetaInfo, PsdMetaInfo, VideoMetaInfo};
use exiftool_rs::ExifTool;

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
pub fn format_date(date_str: &str) -> String {
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

#[flutter_rust_bridge::frb(sync)]
pub fn get_audio_meta_info(file_path: &str) -> AudioMetaInfo {
    let mut info: AudioMetaInfo = AudioMetaInfo {
        title: String::new(),
        artist: String::new(),
        album: String::new(),
        year: String::new(),
    };

    let et = ExifTool::new();
    let tags = et.extract_info(file_path).unwrap();

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

#[flutter_rust_bridge::frb(sync)]
pub fn get_psd_meta_info(psd_path: &str) -> PsdMetaInfo {
    let mut info: PsdMetaInfo = PsdMetaInfo {
        width: 0,
        height: 0,
    };

    let et = ExifTool::new();
    let tags = et.extract_info(psd_path).unwrap();

    let wanted_tags = ["ImageWidth", "ImageHeight"];

    let results: HashMap<&str, String> = tags
        .iter()
        .filter(|tag| wanted_tags.contains(&tag.name.as_str()))
        .map(|tag| (tag.name.as_str(), tag.print_value.clone()))
        .collect();

    info.width = results
        .get("ImageWidth")
        .cloned()
        .unwrap_or_default()
        .parse()
        .unwrap_or(0);
    info.height = results
        .get("ImageHeight")
        .cloned()
        .unwrap_or_default()
        .parse()
        .unwrap_or(0);

    info
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_video_meta_info(video_path: &str) -> VideoMetaInfo {
    let mut info: VideoMetaInfo = VideoMetaInfo {
        width: 0,
        height: 0,
        make: String::new(),
        model: String::new(),
        capture: String::new(),
    };

    let et = ExifTool::new();
    let tags = et.extract_info(video_path).unwrap();

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

    if let Some(dt) = capture {
        info.capture = format_date(dt);
    }

    info
}

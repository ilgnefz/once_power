use std::io::sink;

use chrono::{DateTime, Datelike, Local, NaiveDateTime, TimeZone};
use flutter_rust_bridge::frb;
use rayon::iter::{IntoParallelRefIterator, ParallelIterator};
use uuid::Uuid;

use crate::api::base_info::get_base_info;
use crate::api::extension::app_extension;
use crate::api::image_info::get_image_meta_info;
use crate::api::meta_info::{get_audio_meta_info, get_image_size, get_video_meta_info};
use crate::api::models::{DateInfo, FileMetaInfo, FileType, Resolution};
use crate::frb_generated::StreamSink;

use super::models::FileInfo;

#[flutter_rust_bridge::frb(sync)]
pub fn sort_file_info_by_paths(paths: Vec<String>, file_info_list: Vec<FileInfo>) -> Vec<FileInfo> {
    let path_index: std::collections::HashMap<String, usize> = paths
        .into_iter()
        .enumerate()
        .map(|(idx, path)| (path, idx))
        .collect();

    let mut sorted_list = file_info_list;
    sorted_list.sort_by_key(|file_info| *path_index.get(&file_info.path).unwrap_or(&usize::MAX));

    sorted_list
}

#[flutter_rust_bridge::frb(sync)]
pub fn generate_id() -> String {
    Uuid::new_v4().to_string()
}

// #[flutter_rust_bridge::frb]
pub fn get_list_stream_pool(paths: Vec<String>, sink: StreamSink<FileInfo>) -> Result<(), String> {
    let num_cpus = std::cmp::max(1, num_cpus::get() - 1);
    let pool = rayon::ThreadPoolBuilder::new()
        .num_threads(num_cpus)
        .build()
        .map_err(|e| e.to_string())?;

    pool.install(|| {
        paths.par_iter().for_each(|file_path| {
            let file_info = generate_info(file_path);
            let _ = sink.add(file_info);
        });
    });
    Ok(())
}

pub fn get_list_stream(paths: Vec<String>, sink: StreamSink<FileInfo>) -> Result<(), String> {
    for file_path in paths {
        let file_info = generate_info(&file_path);
        let _ = sink.add(file_info);
    }
    Ok(())
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_list_pool(paths: Vec<String>) -> Vec<FileInfo> {
    let num_cpus = std::cmp::max(1, num_cpus::get() - 1);
    let pool = rayon::ThreadPoolBuilder::new()
        .num_threads(num_cpus)
        .build()
        .map_err(|e| e.to_string())
        .unwrap();

    let list: Vec<FileInfo> = pool.install(|| {
        paths
            .par_iter()
            .map(|file_path| generate_info(file_path))
            .collect()
    });
    sort_file_info_by_paths(paths, list)
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_list(paths: Vec<String>) -> Vec<FileInfo> {
    let mut list = Vec::new();
    for file_path in paths {
        let file_info = generate_info(&file_path);
        list.push(file_info);
    }
    list
}

fn generate_info(file_path: &str) -> FileInfo {
    let base_info = get_base_info(file_path);
    let id = generate_id();
    let name = base_info.name.clone();
    let new_name = name.clone();
    let parent = base_info.parent.clone();
    let path = file_path;
    let temp_path = "".to_string();
    let before_path = file_path;
    let is_dir = base_info.is_dir.clone();
    let ext = base_info.ext.clone();
    let new_ext = ext.clone();
    let created = get_date_info(base_info.create.clone());
    let modified = get_date_info(Some(base_info.modify.clone()));
    let accessed = get_date_info(Some(base_info.access.clone()));
    let file_type = get_file_type(&ext.to_lowercase(), is_dir);
    let mut resolution: Option<Resolution> = None;
    let mut meta_info: Option<FileMetaInfo> = None;
    if file_type == FileType::Audio {
        meta_info = Some(get_audio_info(file_path));
    }
    if file_type == FileType::Video {
        let (video_resolution, file_meta_info) = get_video_info(file_path);
        meta_info = Some(file_meta_info);
        resolution = Some(video_resolution);
    }
    if file_type == FileType::Image {
        (resolution, meta_info) = get_image_info(file_path, &ext);
    }
    let thumbnail: Option<Vec<u8>> = None;
    let size = base_info.size;
    let group = "".to_string();
    let checked = true;
    FileInfo {
        id,
        name,
        new_name,
        parent,
        path: path.to_string(),
        temp_path,
        before_path: before_path.to_string(),
        ext,
        new_ext,
        created,
        modified,
        accessed,
        file_type,
        resolution,
        meta_info,
        thumbnail,
        size,
        group,
        checked,
    }
}

fn get_file_type(extension: &str, is_dir: bool) -> FileType {
    if is_dir {
        FileType::Folder
    } else if app_extension::IMAGE.contains(&extension) {
        FileType::Image
    } else if app_extension::VIDEO.contains(&extension) {
        FileType::Video
    } else if app_extension::AUDIO.contains(&extension) {
        FileType::Audio
    } else if app_extension::DOC.contains(&extension) {
        FileType::Doc
    } else if app_extension::ARCHIVE.contains(&extension) {
        FileType::Archive
    } else {
        FileType::Other
    }
}

fn get_audio_info(file_path: &str) -> FileMetaInfo {
    let audio_meta_info = get_audio_meta_info(file_path);
    let mut file_meta_info = FileMetaInfo::default();
    file_meta_info.title = audio_meta_info.title;
    file_meta_info.artist = audio_meta_info.artist;
    file_meta_info.album = audio_meta_info.album;
    file_meta_info.year = audio_meta_info.year;
    let meta_info = file_meta_info;
    meta_info
}

fn get_video_info(file_path: &str) -> (Resolution, FileMetaInfo) {
    let video_meta_info = get_video_meta_info(file_path);
    let mut file_meta_info = FileMetaInfo::default();
    let resolution = Resolution {
        width: video_meta_info.width,
        height: video_meta_info.height,
    };
    file_meta_info.make = video_meta_info.make;
    file_meta_info.model = video_meta_info.model;
    file_meta_info.capture = get_date_info(video_meta_info.capture);
    // println!("拍摄日期: {}", video_meta_info.capture);
    (resolution, file_meta_info)
}

fn get_image_info(file_path: &str, ext: &str) -> (Option<Resolution>, Option<FileMetaInfo>) {
    let resolution = get_image_size(file_path, ext);
    let file_meta_info: Option<FileMetaInfo> = match get_image_meta_info(file_path.to_owned()) {
        Some(meta) => Some(FileMetaInfo {
            title: "".to_string(),
            artist: "".to_string(),
            album: "".to_string(),
            year: "".to_string(),
            make: meta.make.unwrap_or("".to_string()),
            model: meta.model.unwrap_or("".to_string()),
            capture: get_date_info(meta.capture),
            latitude: meta.latitude,
            longitude: meta.longitude,
            location: "".to_string(),
        }),
        None => None,
    };
    (resolution, file_meta_info)
}

pub fn parse_str_datetime(s: &str) -> Option<DateTime<Local>> {
    // 解析为无时区日期时间
    let naive = NaiveDateTime::parse_from_str(s, "%Y:%m:%d %H:%M:%S").ok()?;
    // 方式一：将其视为本地时间（直接使用系统时区）
    // 注意：如果时区转换存在歧义（如夏令时切换），single() 会返回 None
    Local.from_local_datetime(&naive).single()
    // 方式二：如果希望一律视为 UTC 再转本地（更可预测）
    // let utc = DateTime::<Utc>::from_naive_utc_and_offset(naive, Utc);
    // Some(utc.with_timezone(&Local))
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_date_info(date: Option<DateTime<Local>>) -> Option<DateInfo> {
    if date.is_none() {
        return None;
    }
    // let date = local.format("%Y-%m-%d%H:%M:%S").to_string();
    let weekday = WEEKDAY_NAMES[date.unwrap().weekday().num_days_from_monday() as usize]
        .iter()
        .map(|s| s.to_string())
        .collect::<Vec<String>>();

    Some(DateInfo {
        date: date.unwrap(),
        weekday,
    })
}

const WEEKDAY_NAMES: &[&[&str]] = &[
    &["周一", "星期一", "月曜日", "Monday"],
    &["周二", "星期二", "火曜日", "Tuesday"],
    &["周三", "星期三", "水曜日", "Wednesday"],
    &["周四", "星期四", "木曜日", "Thursday"],
    &["周五", "星期五", "金曜日", "Friday"],
    &["周六", "星期六", "土曜日", "Saturday"],
    &["周日", "星期日", "日曜日", "Sunday"],
];

use chrono::{DateTime, Local, Utc};
use filetime_creation::FileTime;
use std::fs;
use std::path::Path;

use super::models::BaseInfo;

pub fn get_base_info(file_path: &str) -> BaseInfo {
    let path = Path::new(file_path);
    let metadata = fs::metadata(path.to_string_lossy().to_string().as_str()).unwrap();
    let is_dir = metadata.is_dir();
    let (name, ext) = get_name_extension(path, is_dir);
    let parent = path.parent().unwrap().to_string_lossy().to_string();
    let create = FileTime::from_creation_time(&metadata).map(|f| filetime_to_local(f));
    let modify = filetime_to_local(FileTime::from_last_modification_time(&metadata));
    let access = filetime_to_local(FileTime::from_last_access_time(&metadata));
    let size = if is_dir {
        calculate_dir_size(Path::new(file_path))
    } else {
        metadata.len()
    };
    BaseInfo {
        name,
        ext,
        parent,
        create,
        modify,
        access,
        size,
        is_dir,
    }
}

fn get_name_extension(path: &Path, is_dir: bool) -> (String, String) {
    if is_dir {
        (
            path.file_name()
                .unwrap_or_default()
                .to_string_lossy()
                .to_string(),
            String::new(),
        )
    } else {
        (
            path.file_stem()
                .unwrap_or_else(|| path.file_name().unwrap())
                .to_string_lossy()
                .to_string(),
            path.extension()
                .map(|e| e.to_string_lossy().to_string())
                .unwrap_or_default(),
        )
    }
}

fn filetime_to_local(ft: FileTime) -> DateTime<Local> {
    let sys_time: std::time::SystemTime = ft.into();
    let duration = sys_time
        .duration_since(std::time::UNIX_EPOCH)
        .expect("Time is before UNIX epoch");
    DateTime::<Utc>::from_timestamp(duration.as_secs() as i64, duration.subsec_nanos())
        .expect("Invalid timestamp")
        .with_timezone(&Local)
}

/// 获取时间戳，支持1970年以前的时间（返回负数）
// fn get_timestamp(time: std::time::SystemTime) -> Result<i64, String> {
//     let epoch = std::time::UNIX_EPOCH;
//     match time.duration_since(epoch) {
//         Ok(duration) => Ok(duration.as_secs() as i64),
//         Err(_e) => {
//             // 时间早于1970年，计算负数时间戳
//             match epoch.duration_since(time) {
//                 Ok(duration) => Ok(-(duration.as_secs() as i64)),
//                 Err(_) => Err("时间计算失败".to_string()),
//             }
//         }
//     }
// }

/// 计算文件夹的总大小（包括所有子文件和子文件夹）
fn calculate_dir_size(path: &Path) -> u64 {
    let mut total_size = 0;

    if let Ok(entries) = std::fs::read_dir(path) {
        for entry in entries {
            if let Ok(entry) = entry {
                let entry_path = entry.path();
                if let Ok(metadata) = std::fs::metadata(&entry_path) {
                    if metadata.is_dir() {
                        total_size += calculate_dir_size(&entry_path);
                    } else {
                        total_size += metadata.len();
                    }
                }
            }
        }
    }

    total_size
}

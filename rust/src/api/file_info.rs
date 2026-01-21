use std::fs;
use std::path::Path;
use uuid::Uuid;

use super::file_type::RFileInfo;

#[flutter_rust_bridge::frb(sync)]
pub fn get_file_info(file_path: &str) -> Result<RFileInfo, String> {
    let path = Path::new(file_path);
    let id = Uuid::new_v4().to_string();
    let name = path.file_stem().unwrap_or_else(|| path.file_name().unwrap()).to_string_lossy().to_string();
    let parent = path.parent().unwrap().to_string_lossy().to_string();
    let metadata = fs::metadata(path.to_string_lossy().to_string().as_str()).map_err(|e| e.to_string())?;
    let ext = if metadata.is_dir() {
        "dir".to_string()
    } else {
        path.extension()
            .map(|e| e.to_string_lossy().to_string())
            .unwrap_or_default()
    };
    let create_time = get_timestamp(metadata.created().map_err(|e| e.to_string())?)?;
    let modify_time = get_timestamp(metadata.modified().map_err(|e| e.to_string())?)?;
    let access_time = get_timestamp(metadata.accessed().map_err(|e| e.to_string())?)?;
    let size = if metadata.is_dir() { calculate_dir_size(Path::new(file_path)) } else { metadata.len() };
    Ok(RFileInfo {
        id,
        name,
        ext,
        parent,
        create_time,
        modify_time,
        access_time,
        size,
    })
}

/// 获取时间戳，支持1970年以前的时间（返回负数）
fn get_timestamp(time: std::time::SystemTime) -> Result<i64, String> {
    let epoch = std::time::UNIX_EPOCH;
    match time.duration_since(epoch) {
        Ok(duration) => Ok(duration.as_secs() as i64),
        Err(_e) => {
            // 时间早于1970年，计算负数时间戳
            match epoch.duration_since(time) {
                Ok(duration) => Ok(-(duration.as_secs() as i64)),
                Err(_) => Err("时间计算失败".to_string()),
            }
        }
    }
}

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

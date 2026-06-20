use std::path::Path;

use chrono::{DateTime, Local};
use flutter_rust_bridge::frb;

#[frb(type_64bit_int)]
#[derive(Debug, Clone)]
pub struct BaseInfo {
    pub name: String,
    pub ext: String,
    pub parent: String,
    pub create: Option<DateTime<Local>>,
    pub modify: DateTime<Local>,
    pub access: DateTime<Local>,
    pub size: u64,
    pub is_dir: bool,
}

pub struct AudioMetaInfo {
    pub title: String,
    pub artist: String,
    pub album: String,
    pub year: String,
}

pub struct PhotoMetaInfo {
    pub make: Option<String>,
    pub model: Option<String>,
    pub capture: Option<DateTime<Local>>,
    pub latitude: Option<f64>,
    pub longitude: Option<f64>,
}

pub struct VideoMetaInfo {
    pub width: u32,
    pub height: u32,
    pub make: String,
    pub model: String,
    pub capture: Option<DateTime<Local>>,
}

#[frb(type_64bit_int)]
#[derive(Debug, Clone)]
pub struct FileInfo {
    pub id: String,
    #[frb(non_final)]
    pub name: String,
    #[frb(non_final)]
    pub new_name: String,
    #[frb(non_final)]
    pub parent: String,
    #[frb(non_final)]
    pub path: String,
    #[frb(non_final)]
    pub temp_path: String,
    pub before_path: String,
    #[frb(non_final)]
    pub ext: String,
    #[frb(non_final)]
    pub new_ext: String,
    #[frb(non_final)]
    pub created: Option<DateInfo>,
    #[frb(non_final)]
    pub modified: Option<DateInfo>,
    #[frb(non_final)]
    pub accessed: Option<DateInfo>,
    #[frb(non_final)]
    pub file_type: FileType,
    pub resolution: Option<Resolution>,
    pub meta_info: Option<FileMetaInfo>,
    #[frb(non_final)]
    pub thumbnail: Option<Vec<u8>>,
    pub size: u64,
    #[frb(non_final)]
    pub group: String,
    #[frb(non_final)]
    pub checked: bool,
}

impl FileInfo {
    #[flutter_rust_bridge::frb(sync)]
    pub fn is_dir(&self) -> bool {
        self.file_type == FileType::Folder
    }

    #[flutter_rust_bridge::frb(sync)]
    pub fn full_old_name(&self) -> String {
        if self.is_dir() {
            return self.name.clone();
        } else {
            format!("{}.{}", &self.name, &self.ext).to_string()
        }
    }

    #[flutter_rust_bridge::frb(sync)]
    pub fn full_new_name(&self) -> String {
        if self.is_dir() {
            return self.new_name.clone();
        } else {
            format!("{}.{}", &self.new_name, &self.new_ext).to_string()
        }
    }

    #[flutter_rust_bridge::frb(sync)]
    pub fn new_path(&self, is_undo: bool) -> String {
        if is_undo {
            return self.before_path.clone();
        } else {
            Path::new(&self.parent)
                .join(self.full_new_name())
                .to_string_lossy()
                .to_string()
        }
    }
}

#[derive(Debug, Clone)]
pub struct DateInfo {
    pub date: DateTime<chrono::Local>,
    pub weekday: Vec<String>,
}

#[derive(Debug, Clone, PartialEq)]
pub enum FileType {
    Image,
    Video,
    Audio,
    Doc,
    Archive,
    Folder,
    Other,
}

#[derive(Default, Debug, Clone)]
pub struct Resolution {
    pub width: u32,
    pub height: u32,
}

#[derive(Default, Debug, Clone)]
pub struct FileMetaInfo {
    pub title: String,
    pub artist: String,
    pub album: String,
    pub year: String,
    pub capture: Option<DateInfo>,
    pub make: String,
    pub model: String,
    pub longitude: Option<f64>,
    pub latitude: Option<f64>,
    pub location: String,
}

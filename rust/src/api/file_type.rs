pub struct RFileInfo {
    pub id: String,
    pub name: String,
    pub ext: String,
    pub parent: String,
    pub create_time: i64,
    pub modify_time: i64,
    pub access_time: i64,
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
    pub make: String,
    pub model: String,
    pub capture: String,
    pub latitude: Option<f64>,
    pub longitude: Option<f64>,
}

pub struct VideoMetaInfo {
    pub width: u32,
    pub height: u32,
    pub make: String,
    pub model: String,
    pub capture: String,
}

pub struct PsdMetaInfo {
    pub width: u32,
    pub height: u32,
}
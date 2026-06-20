pub mod app_extension {
    pub const FILTER: &[&str] = &["ini", "lnk"];
    pub const AUDIO: &[&str] = &[
        "aac", "ac3", "aiff", "ape", "au", "cda", "dts", "flac", "midi", "mp3", "m4a", "ogg",
        "opus", "ra", "rm", "rmx", "sacd", "vqf", "wav", "wma",
    ];
    pub const DOC: &[&str] = &[
        "azw3", "accdb", "doc", "docx", "csv", "epub", "et", "log", "md", "mdx", "mobi", "ods",
        "odt", "odp", "oplog", "pdf", "ppt", "pptm", "pptx", "rtf", "txt", "wps", "xls", "xlsm",
        "xlsx",
    ];
    pub const IMAGE: &[&str] = &[
        "3fr", "apng", "arw", "avif", "bmp", "dib", "dng", "cr3", "exif", "fpx", "gif", "gpr",
        "heic", "ico", "jfif", "jpe", "jpeg", "jpg", "nef", "orf", "pcd", "pcx", "png", "psd",
        "pvr", "raf", "svg", "tga", "tif", "tiff", "raw", "rw2", "webp",
    ];
    pub const VIDEO: &[&str] = &[
        "3gp",
        "3g2",
        "asf",
        "avi",
        "dat",
        "divx",
        "dvd",
        "f4v",
        "flv",
        "m3u8",
        "m4v",
        "mkv",
        "mov",
        "mp4",
        "mpeg",
        "mped-1",
        "mped-2",
        "mped-4",
        "mpg",
        "mts",
        "webm",
        "wmv",
        "ogm",
        "quicktime",
        "real",
        "rm",
        "rmvb",
        "ts",
        "vob",
    ];
    pub const ARCHIVE: &[&str] = &["zip", "rar", "7z", "tar", "gz", "bz2", "iso", "dmg"];
}

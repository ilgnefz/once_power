use rexif::{ExifTag, TagValue};
use std::f64::consts::PI;

pub struct CameraInfo {
    pub make: Option<String>,
    pub model: Option<String>,
    pub capture: Option<String>,
    pub latitude: Option<f64>,
    pub longitude: Option<f64>,
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

/// 判断坐标是否在中国大陆境内
fn is_in_china(lat: f64, lon: f64) -> bool {
    // 中国大陆的粗略边界框
    lat >= 18.15 && lat <= 53.55 && lon >= 73.66 && lon <= 135.05
}

/// 将WGS84坐标转换为火星坐标(GCJ-02)
fn wgs84_to_gcj02(wgs_lat: f64, wgs_lon: f64) -> (f64, f64) {
    let a = 6378245.0;
    let ee = 0.00669342162296594323;
    
    let mut dlat = transform_lat(wgs_lon - 105.0, wgs_lat - 35.0);
    let mut dlon = transform_lon(wgs_lon - 105.0, wgs_lat - 35.0);
    
    let rad_lat = wgs_lat / 180.0 * PI;
    let magic = 1.0 - ee * rad_lat.sin() * rad_lat.sin();
    let sqrt_magic = magic.sqrt();
    
    dlat = (dlat * 180.0) / ((a * (1.0 - ee)) / (magic * sqrt_magic) * PI);
    dlon = (dlon * 180.0) / (a / sqrt_magic * rad_lat.cos() * PI);
    
    (wgs_lat + dlat, wgs_lon + dlon)
}

fn transform_lat(x: f64, y: f64) -> f64 {
    let mut ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * x.abs().sqrt();
    ret += (20.0 * (6.0 * PI * x).sin() + 20.0 * (2.0 * PI * x).sin()) * 2.0 / 3.0;
    ret += (20.0 * (PI * y).sin() + 40.0 * (PI / 3.0 * y).sin()) * 2.0 / 3.0;
    ret += (160.0 * (PI / 12.0 * y).sin() + 320.0 * (PI / 30.0 * y).sin()) * 2.0 / 3.0;
    ret
}

fn transform_lon(x: f64, y: f64) -> f64 {
    let mut ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * x.abs().sqrt();
    ret += (20.0 * (6.0 * PI * x).sin() + 20.0 * (2.0 * PI * x).sin()) * 2.0 / 3.0;
    ret += (20.0 * (PI * x).sin() + 40.0 * (PI / 3.0 * x).sin()) * 2.0 / 3.0;
    ret += (150.0 * (PI / 12.0 * x).sin() + 300.0 * (PI / 30.0 * x).sin()) * 2.0 / 3.0;
    ret
}

#[flutter_rust_bridge::frb]
pub fn get_image_meta_info(image_path: String) -> Option<CameraInfo> {
    let exif_data = match rexif::parse_file(&image_path) {
        Ok(data) => data,
        Err(_) => return None,
    };

    let mut make = None;
    let mut model = None;
    let mut capture = None;
    let mut latitude = None;
    let mut longitude = None;
    let mut lat_value = None;
    let mut lon_value = None;

    // 收集EXIF数据
    for entry in exif_data.entries {
        match entry.tag {
            ExifTag::Make => make = Some(entry.value.to_string()),
            ExifTag::Model => model = Some(entry.value.to_string()),
            ExifTag::DateTimeOriginal => capture = Some(entry.value.to_string()),
            ExifTag::GPSLatitude => lat_value = Some(entry.value),
            ExifTag::GPSLongitude => lon_value = Some(entry.value),
            _ => {},
        }
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
   
    Some(CameraInfo {
        make,
        model,
        capture,
        latitude,
        longitude,
    })
}
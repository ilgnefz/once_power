use std::f64::consts::PI;

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

/// 解析GPS坐标字符串（格式："26, 55, 2484/100"）并转换为十进制度
fn parse_gps_string(gps_str: &str, ref_str: &str) -> Result<f64, String> {
    let parts: Vec<&str> = gps_str.split(',').collect();
    if parts.len() < 3 {
        return Err("GPS坐标格式错误".to_string());
    }

    let parse_part = |s: &str| -> Result<f64, String> {
        let s = s.trim();
        if s.contains('/') {
            let frac: Vec<&str> = s.split('/').collect();
            if frac.len() == 2 {
                let numerator: f64 = frac[0].trim().parse().map_err(|_| "解析分子失败".to_string())?;
                let denominator: f64 = frac[1].trim().parse().map_err(|_| "解析分母失败".to_string())?;
                Ok(numerator / denominator.max(1.0))
            } else {
                Err("分数格式错误".to_string())
            }
        } else {
            s.parse().map_err(|_| "解析坐标失败".to_string())
        }
    };

    let degrees = parse_part(parts[0])?;
    let minutes = parse_part(parts[1])?;
    let seconds = parse_part(parts[2])?;

    let mut result = degrees + minutes / 60.0 + seconds / 3600.0;

    // 根据方向调整符号
    if ref_str.eq_ignore_ascii_case("South") || ref_str.eq_ignore_ascii_case("S") {
        result = -result;
    }
    if ref_str.eq_ignore_ascii_case("West") || ref_str.eq_ignore_ascii_case("W") {
        result = -result;
    }

    Ok(result)
}

/// 解析GPS坐标并转换为高德地图坐标(GCJ-02)
pub fn parse_and_convert_gps(lat_str: &str, lat_ref: &str, lon_str: &str, lon_ref: &str) -> Option<(f64, f64)> {
    let wgs_lat = parse_gps_string(lat_str, lat_ref).ok()?;
    let wgs_lon = parse_gps_string(lon_str, lon_ref).ok()?;

    if is_in_china(wgs_lat, wgs_lon) {
        let (gcj_lat, gcj_lon) = wgs84_to_gcj02(wgs_lat, wgs_lon);
        Some((gcj_lat, gcj_lon))
    } else {
        Some((wgs_lat, wgs_lon))
    }
}

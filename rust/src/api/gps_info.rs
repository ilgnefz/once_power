use std::f64::consts::PI;

/// 判断坐标是否在中国大陆境内
pub fn is_in_china(lat: f64, lon: f64) -> bool {
    // 中国大陆的粗略边界框
    lat >= 18.15 && lat <= 53.55 && lon >= 73.66 && lon <= 135.05
}

/// 将WGS84坐标转换为火星坐标(GCJ-02)
pub fn wgs84_to_gcj02(wgs_lat: f64, wgs_lon: f64) -> (f64, f64) {
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
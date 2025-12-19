import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/string.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/models/amap.dart';
import 'package:path/path.dart' as path;

import 'storage.dart';

// 创建全局Dio实例，避免每次请求都创建新实例
final Dio _dio = Dio();

Future<String> getTrueLocation(double? latitude, double? longitude) async {
  if (latitude == null || longitude == null) return '';
  debugPrint('经度: $longitude, 纬度: $latitude');
  String lat = latitude.toStringAsFixed(6);
  String long = longitude.toStringAsFixed(6);
  String cacheKey = '${lat}_$long';

  // 先尝试从缓存获取位置信息
  String? cachedLocation = await getCacheLocation(cacheKey);
  if (cachedLocation != null && cachedLocation.isNotEmpty) {
    debugPrint('从缓存获取位置信息: $cachedLocation');
    return cachedLocation;
  }

  // 缓存中没有，请求网络获取
  String? key = StorageUtil.getString(AppKeys.mapKey);
  if (key == null) return '';
  String uri = AppString.mapUrl;

  String location = '';
  Map<String, dynamic> queryParameters = {};
  queryParameters['key'] = key;
  queryParameters['location'] = '$lat,$long';

  try {
    Response response = await _dio.get(uri, queryParameters: queryParameters);
    AMapReverseGeo? data = AMapReverseGeo.fromJson(response.data);
    switch (data.status) {
      case '1':
        location = data.formattedAddress;
        if (location.isNotEmpty) {
          await setCacheLocation(cacheKey, location);
          debugPrint('位置信息已保存到缓存: $location');
        }
        break;
      case '0':
        String info = errInfo(data.infocode);
        showKeyErrorNotification('$info${tr(AppL10n.errLocationInfo)}');
        StorageUtil.remove(AppKeys.mapKey);
        break;
      default:
        showKeyErrorNotification(data.info);
        break;
    }
  } catch (e) {
    debugPrint('获取位置信息失败: $e');
    showKeyErrorNotification(e.toString());
  }
  return location;
}

Future<String?> getCacheLocation(String key) async {
  String folder = path.join(path.dirname(Platform.resolvedExecutable), 'cache');
  String filePath = path.join(folder, 'location.json');

  try {
    // 检查文件是否存在
    File cacheFile = File(filePath);
    if (!await cacheFile.exists()) {
      // 创建父目录（如果不存在）
      Directory(folder).createSync(recursive: true);

      // 创建空的JSON文件
      await cacheFile.writeAsString('{}', flush: true);
      debugPrint('创建位置缓存文件: $filePath');
      return null;
    }

    // 读取并解析JSON文件
    String jsonContent = await cacheFile.readAsString();
    Map<String, dynamic> cacheData = jsonDecode(jsonContent);

    // 查找指定key对应的位置信息
    if (cacheData.containsKey(key) && cacheData[key] is String) {
      return cacheData[key] as String;
    }
  } catch (e) {
    debugPrint('读取位置缓存失败: $e');
  }

  return null;
}

/// 将位置信息保存到缓存文件
Future<void> setCacheLocation(String key, String location) async {
  if (key.isEmpty || location.isEmpty) return;

  try {
    String folder =
        path.join(path.dirname(Platform.resolvedExecutable), 'cache');
    String filePath = path.join(folder, 'location.json');

    // 确保文件夹存在
    Directory(folder).createSync(recursive: true);

    // 读取现有缓存数据
    File cacheFile = File(filePath);
    Map<String, dynamic> cacheData = {};

    if (await cacheFile.exists()) {
      String jsonContent = await cacheFile.readAsString();
      cacheData = jsonDecode(jsonContent);
    }

    // 添加或更新位置信息
    cacheData[key] = location;

    // 写回文件
    await cacheFile.writeAsString(jsonEncode(cacheData), flush: true);
  } catch (e) {
    debugPrint('保存位置缓存失败: $e');
  }
}

String errInfo(String code) {
  switch (code) {
    case '10001':
      return tr(AppL10n.errKeyError1);
    case '10002':
      return tr(AppL10n.errKeyError2);
    case '10003':
      return tr(AppL10n.errKeyError3);
    case '10004':
      return tr(AppL10n.errKeyError4);
    case '10009':
      return tr(AppL10n.errKeyError5);
    case '10010':
      return tr(AppL10n.errKeyError6);
    case '10013':
      return tr(AppL10n.errKeyError7);
    default:
      return tr(AppL10n.errKeyError, namedArgs: {'code': code});
  }
}

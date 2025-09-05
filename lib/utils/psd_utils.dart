import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'dart:io';

/// PSD文件处理工具类，可复用的PSD图像加载和处理功能
class PsdUtils {
  // 静态缓存（文件路径为键）
  static final Map<String, Uint8List> _psdCache = {};

  /// 清除所有缓存
  static void clearCache() {
    _psdCache.clear();
  }

  /// 从缓存中移除特定文件
  static void removeFromCache(String filePath) {
    _psdCache.remove(filePath);
  }

  /// 加载PSD图像并返回其数据
  /// [filePath] - PSD文件路径
  /// [onUpdate] - 可选回调，在图像加载完成时调用
  /// [includeCache] - 是否使用缓存，默认为true
  static Future<Uint8List?> loadPsdImage(
    String filePath, {
    VoidCallback? onUpdate,
    bool includeCache = true,
  }) async {
    Stopwatch stopwatch = Stopwatch()..start();
    try {
      // 检查缓存
      if (includeCache && _psdCache.containsKey(filePath)) {
        final cacheResult = _psdCache[filePath];
        if (cacheResult != null) {
          onUpdate?.call();
          stopwatch.stop();
          debugPrint(
            'PSD load from cache time: ${stopwatch.elapsedMilliseconds}ms',
          );
          return cacheResult;
        }
      }

      // 读取文件
      File file = File(filePath);
      if (!await file.exists()) {
        debugPrint('PSD file not found: $filePath');
        return null;
      }

      Uint8List bytes = await file.readAsBytes();
      final pngBytes = await compute(_processPsdImage, bytes);

      if (pngBytes.isNotEmpty) {
        final result = Uint8List.fromList(pngBytes);
        // 缓存有效数据
        if (includeCache) {
          _psdCache[filePath] = result;
        }
        onUpdate?.call();

        stopwatch.stop();
        debugPrint('PSD load time: ${stopwatch.elapsedMilliseconds}ms');
        return result;
      }
    } catch (e) {
      debugPrint('Error loading PSD image: $e');
    }
    stopwatch.stop();
    debugPrint('PSD load failed time: ${stopwatch.elapsedMilliseconds}ms');
    return null;
  }

  /// 处理PSD图像数据（在隔离线程中执行）
  static List<int> _processPsdImage(Uint8List psdBytes) {
    try {
      final psdImage = img.decodePsd(psdBytes);
      if (psdImage != null) {
        // 编码为PNG，level 0表示最快（无压缩）
        Uint8List pngBytes = img.encodePng(psdImage, level: 0);
        return pngBytes;
      }
    } catch (e) {
      debugPrint('Error processing PSD image: $e');
    }
    return [];
  }

  /// 检查文件是否为PSD格式
  static bool isPsdFile(String filePath) {
    return filePath.toLowerCase().endsWith('.psd') ||
        filePath.toLowerCase().endsWith('.psb');
  }
}

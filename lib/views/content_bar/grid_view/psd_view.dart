import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/select.dart';

import 'err_image.dart';
import 'loading_image.dart';

class PsdView extends ConsumerStatefulWidget {
  const PsdView({super.key, required this.file});

  final FileInfo file;

  @override
  ConsumerState<PsdView> createState() => _PsdViewState();
}

class _PsdViewState extends ConsumerState<PsdView> {
  Uint8List? imageData;
  Resolution? resolution;
  // 添加静态缓存（文件路径为键）
  static final Map<String, (Uint8List, Resolution)> _psdCache = {};

  @override
  void initState() {
    super.initState();
    // 延迟执行加载逻辑，避免组件构建时修改Provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPsdImage();
    });
  }

  void updateInfo() {
    final provider = ref.read(fileListProvider.notifier);
    provider.updateThumbnail(widget.file.id, imageData);
    provider.updateResolution(widget.file.id, resolution);
    if (ref.watch(currentModeProvider).isAdvance) updateName(ref);
  }

  Future<void> _loadPsdImage() async {
    final stopwatch = Stopwatch()..start();
    try {
      // 优先检查缓存
      if (_psdCache.containsKey(widget.file.filePath)) {
        final cacheResult = _psdCache[widget.file.filePath];
        if (cacheResult != null) {
          imageData = cacheResult.$1;
          resolution = cacheResult.$2;
        }
        updateInfo();
        setState(() {});
        return;
      }

      final file = File(widget.file.filePath);
      final bytes = await file.readAsBytes();
      final (pngBytes, resol) = await compute(_processPsdImage, bytes);
      resolution = resol;
      if (pngBytes.isNotEmpty) {
        imageData = Uint8List.fromList(pngBytes);
        // 缓存有效数据
        _psdCache[widget.file.filePath] = (imageData!, resol);
        updateInfo();
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error loading PSD image: $e'); // 使用debugPrint
    }
    stopwatch.stop();
    debugPrint('loadPsdImage time: ${stopwatch.elapsedMilliseconds}ms');
  }

  static (List<int>, Resolution) _processPsdImage(Uint8List psdBytes) {
    final psdImage = img.decodePsd(psdBytes);
    if (psdImage != null) {
      final resolution = Resolution(psdImage.width, psdImage.height);
      // 编码为PNG
      final pngBytes = img.encodePng(psdImage, level: 0);
      return (pngBytes, resolution);
    }
    return ([], Resolution.zero);
  }

  @override
  Widget build(BuildContext context) {
    if (imageData == null) return const LoadingImage(isPreview: false);

    Widget image = Image.memory(
      imageData!,
      fit: BoxFit.contain,
      cacheWidth: AppNum.imageW.toInt(),
      errorBuilder: (context, exception, stackTrace) =>
          ErrorImage(file: widget.file.filePath),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        } else {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: frame != null ? child : const LoadingImage(isPreview: false),
          );
        }
      },
    );

    if (!widget.file.checked) image = Opacity(opacity: .5, child: image);

    return image;
  }
}

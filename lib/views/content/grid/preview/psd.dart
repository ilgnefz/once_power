import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/utils/psd_utils.dart';

import '../error.dart';
import '../loading.dart';

class PreviewPsd extends ConsumerStatefulWidget {
  const PreviewPsd({
    super.key,
    required this.id,
    required this.file,
    required this.data,
  });

  final String id;
  final FileInfo file;
  final Uint8List? data;

  @override
  ConsumerState<PreviewPsd> createState() => _PreviewPsdState();
}

class _PreviewPsdState extends ConsumerState<PreviewPsd> {
  Uint8List? _imageData;

  @override
  void initState() {
    super.initState();
    _imageData = widget.data;
    if (_imageData == null) _loadImageData();
  }

  void updateInfo() {
    if (_imageData == null) return;
    FileList provider = ref.read(fileListProvider.notifier);
    provider.updateThumbnail(widget.file.id, _imageData!);
    // if (ref.watch(currentModeProvider).isAdvance) updateName(ref);
  }

  Future<void> _loadImageData() async {
    try {
      Uint8List? result = await PsdUtils.loadPsdImage(
        widget.file.path,
        onUpdate: () => setState(() => updateInfo()),
      );
      if (result != null) {
        _imageData = result;
        updateInfo();
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error loading PSD image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_imageData == null) return const LoadingImage(isPreview: true);
    return InteractiveViewer(
      key: ValueKey(widget.id),
      maxScale: 8,
      boundaryMargin: EdgeInsets.all(double.infinity),
      child: Image.memory(
        _imageData!,
        key: ValueKey(widget.file),
        fit: BoxFit.scaleDown,
        errorBuilder: (_, _, _) =>
            ErrorImage(isPreview: true, file: widget.file.path),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) return child;
          if (frame == null) child = const LoadingImage(isPreview: true);
          return AnimatedSwitcher(duration: Duration.zero, child: child);
        },
      ),
    );
  }
}

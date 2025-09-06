import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/utils/psd_utils.dart';

import 'error.dart';
import 'loading.dart';

class PsdView extends ConsumerStatefulWidget {
  const PsdView({super.key, required this.file});

  final FileInfo file;

  @override
  ConsumerState<PsdView> createState() => _PsdViewState();
}

class _PsdViewState extends ConsumerState<PsdView> {
  Uint8List? _imageData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPsdImage();
    });
  }

  void updateInfo() {
    if (_imageData == null) return;
    FileList provider = ref.read(fileListProvider.notifier);
    provider.updateThumbnail(widget.file.id, _imageData!);
    // if (ref.watch(currentModeProvider).isAdvance) updateName(ref);
  }

  Future<void> _loadPsdImage() async {
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
    if (_imageData == null) return const LoadingImage(isPreview: false);

    Widget image = Image.memory(
      _imageData!,
      fit: BoxFit.contain,
      cacheWidth: ref.watch(viewImageWidthProvider).toInt(),
      errorBuilder: (_, _, _) => ErrorImage(file: widget.file.path),
      frameBuilder: (_, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: frame != null ? child : const LoadingImage(isPreview: false),
        );
      },
    );

    if (!widget.file.checked) image = Opacity(opacity: .5, child: image);
    return image;
  }
}

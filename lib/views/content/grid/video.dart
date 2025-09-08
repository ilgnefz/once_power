import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fvp/fvp.dart';
import 'package:image/image.dart' as img;
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/views/content/grid/error.dart';
import 'package:once_power/views/content/grid/loading.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:video_player/video_player.dart';

class VideoView extends ConsumerStatefulWidget {
  const VideoView({super.key, required this.file});

  final FileInfo file;
  @override
  ConsumerState<VideoView> createState() => _VideoViewState();
}

class _IsolateData {
  final SendPort sendPort;
  final Uint8List snapshotData;
  final int width;
  final int height;

  _IsolateData({
    required this.sendPort,
    required this.snapshotData,
    required this.width,
    required this.height,
  });
}

class _VideoViewState extends ConsumerState<VideoView> {
  Uint8List? _coverData;
  VideoPlayerController? _controller;
  bool _controllerFailed = false;

  @override
  void initState() {
    super.initState();
    _coverData = widget.file.thumbnail;
    if (_coverData != null) return;

    _getControllerAndGenerateThumbnail();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _getControllerAndGenerateThumbnail() async {
    try {
      _controller = VideoPlayerController.file(File(widget.file.path));
      await _controller!.initialize();
      await _generateThumbnail();
    } catch (e) {
      debugPrint('Error creating controller: $e');
      _controller?.dispose();
      _controller = null;
      setState(() => _controllerFailed = true);
    }
  }

  Future<void> _generateThumbnail() async {
    if (_controller == null) return;

    try {
      await _controller!.setVolume(0);
      await _controller!.play();
      await Future.delayed(const Duration(seconds: 1));
      await _controller!.pause();
      final info = _controller!.getMediaInfo()?.video?[0].codec;
      if (info == null) {
        debugPrint('No video codec info');
        return;
      }
      final int width = info.width;
      final int height = info.height;
      final Uint8List? snapshot = await _controller!.snapshot();
      if (snapshot == null || snapshot.isEmpty) {
        debugPrint('Snapshot data is empty');
        return;
      }
      // 在Isolate中处理图像生成，避免阻塞UI线程
      final Uint8List imageBytes = await _generateThumbnailInIsolate(
        snapshot.buffer.asUint8List(),
        width,
        height,
      );
      if (imageBytes.isNotEmpty) {
        setState(() => _coverData = imageBytes);
        if (mounted) {
          ref
              .read(fileListProvider.notifier)
              .updateThumbnail(widget.file.id, imageBytes);
        }
      } else {
        setState(() => _controllerFailed = true);
      }
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
      setState(() => _controllerFailed = true);
    } finally {
      _releaseController();
    }
  }

  Future<Uint8List> _generateThumbnailInIsolate(
    Uint8List snapshotData,
    int width,
    int height,
  ) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(
      _isolateGenerateThumbnail,
      _IsolateData(
        sendPort: receivePort.sendPort,
        snapshotData: snapshotData,
        width: width,
        height: height,
      ),
    );
    return await receivePort.first as Uint8List;
  }

  static void _isolateGenerateThumbnail(_IsolateData data) {
    try {
      final image = img.Image.fromBytes(
        width: data.width,
        height: data.height,
        bytes: data.snapshotData.buffer,
        numChannels: 4,
        rowStride: data.width * 4,
      );
      final Uint8List imageBytes = img.encodeJpg(image, quality: 85);
      data.sendPort.send(imageBytes);
    } catch (e) {
      data.sendPort.send(Uint8List(0));
    }
  }

  void _releaseController() {
    if (_controller != null) {
      _controller!.dispose();
      _controller = null;
    }
  }

  @override
  void dispose() {
    _releaseController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controllerFailed) return ErrorImage(file: widget.file.path);
    return _coverData != null
        ? ColoredBox(
            color: Colors.black,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Image.memory(_coverData!, fit: BoxFit.contain),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: ClickIcon(
                    icon: Icons.play_circle_fill_rounded,
                    color: Colors.white,
                    size: 28,
                    shadows: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                    onPressed: () => previewView(context, widget.file),
                  ),
                ),
              ],
            ),
          )
        : const LoadingImage(isPreview: false);
  }
}

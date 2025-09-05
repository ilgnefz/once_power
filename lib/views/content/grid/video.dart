import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/models/file.dart';
import 'package:video_player/video_player.dart';

import 'loading.dart';

class VideoView extends ConsumerStatefulWidget {
  const VideoView({super.key, required this.file});

  final FileInfo file;

  @override
  ConsumerState<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends ConsumerState<VideoView>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.file.path))
      ..initialize().then((_) {
        if (mounted) {
          _controller.pause();
          _controller.seekTo(Duration.zero);
          setState(() {});
        }
      })
      ..addListener(() {
        if (_controller.value.isCompleted) {
          _controller.pause();
          _controller.seekTo(Duration.zero);
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget child = _controller.value.isInitialized
        ? ColoredBox(
            color: Colors.black,
            child: Stack(
              children: [
                Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_circle_filled_rounded
                          : Icons.play_circle_fill_rounded,
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    onPressed: () => setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    }),
                  ),
                ),
              ],
            ),
          )
        : const Center(child: LoadingImage(isPreview: false));
    if (!widget.file.checked) return Opacity(opacity: .5, child: child);
    return child;
  }

  @override
  bool get wantKeepAlive => true;
}

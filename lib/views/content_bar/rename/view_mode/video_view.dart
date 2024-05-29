import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:once_power/model/file_info.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key, required this.file});

  final FileInfo file;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.file.filePath));
    _controller.initialize().then((_) => setState(() {
          _isLoading = false;
        }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
        ),
        if (!_isLoading)
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.play_circle_outline_rounded,
              size: 32,
              color: Colors.white,
              shadows: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.black.withOpacity(.2),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

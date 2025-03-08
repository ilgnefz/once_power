import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/views/content_bar/grid_view/play_btn.dart';
import 'package:video_player/video_player.dart';

import 'loading_image.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key, required this.file});

  final FileInfo file;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.file.filePath))
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(() {
        if (_controller.value.isCompleted) {
          _controller.pause();
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
    return FutureBuilder(
      future: _controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: ColoredBox(
              color: Colors.black,
              child: Stack(
                children: [
                  VideoPlayer(_controller),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: PlayBtn(controller: _controller),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: LoadingImage(isPreview: false));
        }
      },
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/views/content_bar/rename/view_model/loading_image.dart';
import 'package:video_player/video_player.dart';

import 'err_image.dart';

class VideoPreview extends StatefulWidget {
  const VideoPreview({super.key, required this.file});

  final String file;

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.file))
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      })
      ..addListener(() {
        if (_controller.value.isCompleted) {
          _controller.play();
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
    if (_controller.value.isInitialized) {
      if (_controller.value.hasError) {
        return Center(child: ErrorImage(isPreview: true, file: widget.file));
      } else {
        return InkWell(
          onTap: () => Navigator.pop(context),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Column(
              children: [
                Expanded(child: VideoPlayer(_controller)),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  colors: VideoProgressColors(
                    playedColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
    return Center(child: LoadingImage());
  }
}

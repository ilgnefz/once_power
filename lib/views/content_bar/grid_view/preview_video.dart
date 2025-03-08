import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/views/content_bar/grid_view/play_btn.dart';
import 'package:video_player/video_player.dart';

import 'err_image.dart';
import 'loading_image.dart';

class PreviewVideo extends StatefulWidget {
  const PreviewVideo({super.key, required this.file});

  final String file;

  @override
  State<PreviewVideo> createState() => _PreviewVideoState();
}

class _PreviewVideoState extends State<PreviewVideo> {
  late VideoPlayerController _controller;
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.file))
      ..initialize().then((_) {
        _controller.play();
        totalDuration = _controller.value.duration;
        setState(() {});
      })
      ..addListener(() {
        if (_controller.value.isCompleted) {
          _controller.pause();
        }
        currentPosition = _controller.value.position;
        // setState(() {});
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
                Row(
                  children: [
                    SizedBox(width: AppNum.largeG),
                    PlayBtn(controller: _controller),
                    Expanded(
                      child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        colors: VideoProgressColors(
                          playedColor: Theme.of(context).colorScheme.primary,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: AppNum.largeG),
                    Text(
                      formatVideoTime(totalDuration, currentPosition),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: AppNum.largeG * 2),
                  ],
                )
              ],
            ),
          ),
        );
      }
    }
    return Center(child: LoadingImage(isPreview: true));
  }
}

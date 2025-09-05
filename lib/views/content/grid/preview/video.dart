import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/utils/format.dart';
import 'package:video_player/video_player.dart';

import '../error.dart';
import '../loading.dart';
import 'video_btn.dart';
import 'video_progress.dart';

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
  String timeLine = '';

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
        timeLine = formatVideoTime(totalDuration, currentPosition);
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
      }
      return Column(
        children: [
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          ),
          Row(
            children: [
              PlayBtn(controller: _controller),
              Expanded(
                child: CustomVideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  padding: EdgeInsets.zero,
                  colors: VideoProgressColors(
                    playedColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: AppNum.spaceLarge),
              Text(timeLine, style: TextStyle(color: Colors.white)),
              SizedBox(width: AppNum.spaceLarge),
            ],
          ),
        ],
      );
    }
    return Center(child: LoadingImage(isPreview: true));
  }
}

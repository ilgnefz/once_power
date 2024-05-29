import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'err_image.dart';

class PreviewImageView extends StatefulWidget {
  const PreviewImageView(this.file, {super.key});

  final String file;

  @override
  State<PreviewImageView> createState() => _PreviewImageViewState();
}

class _PreviewImageViewState extends State<PreviewImageView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          InteractiveViewer(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.file(
                File(widget.file),
                fit: BoxFit.scaleDown,
                errorBuilder: (context, exception, stackTrace) =>
                    const ErrorImage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PreviewVideoView extends StatefulWidget {
  const PreviewVideoView(this.file, {super.key});

  final String file;

  @override
  State<PreviewVideoView> createState() => _PreviewVideoViewState();
}

class _PreviewVideoViewState extends State<PreviewVideoView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.file));
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(false);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}

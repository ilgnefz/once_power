import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      mouseCursor: SystemMouseCursors.click,
      icon: Icon(
        widget.controller.value.isPlaying
            ? Icons.pause_circle_filled_rounded
            : Icons.play_circle_fill_rounded,
        color: Colors.white,
        shadows: [
          BoxShadow(color: Colors.black54, blurRadius: 8, spreadRadius: 2),
        ],
      ),
      onPressed: () {
        setState(() {
          widget.controller.value.isPlaying
              ? widget.controller.pause()
              : widget.controller.play();
        });
      },
    );
  }
}

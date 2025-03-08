import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayBtn extends StatefulWidget {
  const PlayBtn({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  State<PlayBtn> createState() => _PlayBtnState();
}

class _PlayBtnState extends State<PlayBtn> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.controller.value.isPlaying
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

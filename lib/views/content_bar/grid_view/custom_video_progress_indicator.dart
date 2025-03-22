import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoProgressIndicator extends StatefulWidget {
  const CustomVideoProgressIndicator(
    this.controller, {
    super.key,
    this.height = 8,
    this.colors = const VideoProgressColors(),
    required this.allowScrubbing,
    this.padding = EdgeInsets.zero,
  });

  final double height;
  final VideoPlayerController controller;
  final VideoProgressColors colors;
  final bool allowScrubbing;
  final EdgeInsets padding;

  @override
  State<CustomVideoProgressIndicator> createState() =>
      _CustomVideoProgressIndicatorState();
}

class _CustomVideoProgressIndicatorState
    extends State<CustomVideoProgressIndicator> {
  _CustomVideoProgressIndicatorState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  late VoidCallback listener;

  VideoPlayerController get controller => widget.controller;

  VideoProgressColors get colors => widget.colors;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Widget progressIndicator;
    if (controller.value.isInitialized) {
      final int duration = controller.value.duration.inMilliseconds;
      final int position = controller.value.position.inMilliseconds;

      int maxBuffering = 0;
      for (final DurationRange range in controller.value.buffered) {
        final int end = range.end.inMilliseconds;
        if (end > maxBuffering) {
          maxBuffering = end;
        }
      }

      progressIndicator = Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(widget.height / 2),
            child: LinearProgressIndicator(
              value: maxBuffering / duration,
              valueColor: AlwaysStoppedAnimation<Color>(colors.bufferedColor),
              backgroundColor: colors.backgroundColor,
              minHeight: widget.height,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(widget.height / 2),
            child: LinearProgressIndicator(
              value: position / duration,
              valueColor: AlwaysStoppedAnimation<Color>(colors.playedColor),
              backgroundColor: Colors.transparent,
              minHeight: widget.height,
            ),
          ),
        ],
      );
    } else {
      progressIndicator = ClipRRect(
        borderRadius: BorderRadius.circular(widget.height / 2),
        child: LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(colors.playedColor),
          backgroundColor: colors.backgroundColor,
          minHeight: widget.height,
        ),
      );
    }
    final Widget paddedProgressIndicator = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: widget.padding,
        child: progressIndicator,
      ),
    );
    if (widget.allowScrubbing) {
      return VideoScrubber(
        controller: controller,
        child: paddedProgressIndicator,
      );
    } else {
      return paddedProgressIndicator;
    }
  }
}

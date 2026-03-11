import 'package:flutter/material.dart';

class NotificationAnimation extends StatefulWidget {
  final Widget child;
  final bool reverse;
  final AnimationController controller;

  const NotificationAnimation({
    super.key,
    required this.child,
    this.reverse = false,
    required this.controller,
  });

  @override
  NotificationAnimationState createState() => NotificationAnimationState();
}

class NotificationAnimationState extends State<NotificationAnimation>
    with SingleTickerProviderStateMixin {
  static final Tween<Offset> reverseTweenOffset = Tween<Offset>(
    begin: const Offset(0, 40),
    end: const Offset(0, 0),
  );
  static final Tween<Offset> tweenOffset = Tween<Offset>(
    begin: const Offset(0, -40),
    end: const Offset(0, 0),
  );
  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);
  late final Animation<double> animation;

  late final Animation<Offset> animationOffset;
  late final Animation<double> animationOpacity;

  @override
  void initState() {
    animation = CurvedAnimation(
      parent: widget.controller,
      curve: Curves.decelerate,
    );

    animationOffset = (widget.reverse ? reverseTweenOffset : tweenOffset)
        .animate(animation);
    animationOpacity = tweenOpacity.animate(animation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (_, child) => Transform.translate(
        offset: animationOffset.value,
        child: Opacity(opacity: animationOpacity.value, child: child),
      ),
      child: widget.child,
    );
  }
}

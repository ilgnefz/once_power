import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/widget/common/click_icon.dart';

class DynamicButton extends StatelessWidget {
  const DynamicButton({
    super.key,
    required this.isHover,
    required this.icon,
    required this.onPressed,
  });

  final bool isHover;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: isHover ? 20 : 0,
        child: AnimatedOpacity(
          opacity: isHover ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          child: ClickIcon(
            icon: icon,
            size: 20,
            iconSize: 16,
            color: Colors.grey,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}

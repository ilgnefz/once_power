import 'package:flutter/material.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class CustomScrollbar extends StatelessWidget {
  const CustomScrollbar({
    super.key,
    required this.controller,
    required this.child,
  });

  final ScrollController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return VsScrollbar(
      controller: controller,
      showTrackOnHover: true,
      style: VsScrollbarStyle(
        hoverThickness: 10.0,
        radius: const Radius.circular(10),
        color: Colors.grey.shade300,
      ),
      child: child,
    );
  }
}

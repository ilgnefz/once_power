import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'item_btn.dart';

class DynamicShowBtn extends ConsumerWidget {
  const DynamicShowBtn({
    super.key,
    required this.isHover,
    required this.icon,
    required this.onTap,
  });

  final bool isHover;
  final IconData icon;
  final void Function(WidgetRef) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RepaintBoundary(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: isHover ? 20 : 0,
        child: AnimatedOpacity(
          opacity: isHover ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          child: DirectiveItemBtn(icon: icon, onTap: onTap),
        ),
      ),
    );
  }
}

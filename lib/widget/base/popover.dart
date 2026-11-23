import 'package:flutter_anchored_overlay/flutter_anchored_overlay.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';

class const EasyPopover({
  super.key,
  required final Widget child,
  required final Widget content,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Popover(
      triggerMode: PopoverTriggerMode.hover,
      placement: PopoverPlacement.top,
      padding: .zero,
      edgePadding: 0.0,
      content: content,
      style: PopoverStyle(radius: AppNumber.radius),
      child: MouseRegion(cursor: SystemMouseCursors.click, child: child),
    );
  }
}

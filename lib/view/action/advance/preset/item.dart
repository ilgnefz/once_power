import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/action/dynamic_button.dart';
import 'package:once_power/widget/base/tooltip.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/one_line_text.dart';
import 'package:once_power/widget/common/tooltip.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class PresetItem extends StatefulWidget {
  const PresetItem({
    super.key,
    required this.label,
    required this.onTap,
    required this.onRename,
    required this.onAppend,
    required this.onRemove,
  });

  final String label;
  final void Function() onTap;
  final void Function() onRename;
  final void Function() onAppend;
  final void Function() onRemove;

  @override
  State<PresetItem> createState() => _PresetItemState();
}

class _PresetItemState extends State<PresetItem> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: EasyTooltip(
        tip: widget.label,
        waitDuration: widget.label.length > 5 ? .zero : null,
        placement: Placement.right,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (event) => setState(() => isShow = true),
          onExit: (event) => setState(() => isShow = false),
          child: InkWell(
            onTap: widget.onTap,
            mouseCursor: SystemMouseCursors.click,
            child: Container(
              padding: .symmetric(horizontal: AppNum.paddingMedium),
              width: AppNum.widgetHeight,
              height: AppNum.presetMenu,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  OneLineText(widget.label, fontSize: 12),
                  if (isShow) ...[
                    buildClickIcon(
                      icon: Icons.mode_edit_outline_rounded,
                      onPressed: widget.onRename,
                    ),
                    SizedBox(width: AppNum.spaceSmall / 2),
                    buildClickIcon(
                      icon: Icons.add_rounded,
                      onPressed: widget.onAppend,
                    ),
                    SizedBox(width: AppNum.spaceSmall / 2),
                  ],
                  buildClickIcon(
                    icon: Icons.close_rounded,
                    onPressed: widget.onRemove,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildClickIcon({
  required IconData icon,
  required VoidCallback onPressed,
}) => ClickIcon(
  size: 16,
  iconSize: 14,
  icon: icon,
  color: Colors.grey[400],
  onPressed: onPressed,
);

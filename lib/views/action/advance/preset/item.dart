import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/base/one_line_text.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class PresetItem extends StatefulWidget {
  const PresetItem(
    this.label, {
    super.key,
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
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Ink(
        child: InkWell(
          onTap: widget.onTap,
          child: MouseRegion(
            onEnter: (event) => setState(() => show = true),
            onExit: (event) => setState(() => show = false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              height: AppNum.input,
              width: AppNum.presetMenu,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OneLineText(widget.label, fontSize: 12),
                  if (show) ...[
                    ClickIcon(
                      size: 16,
                      iconSize: 12,
                      icon: Icons.mode_edit_outline_rounded,
                      color: Colors.grey[400],
                      onPressed: widget.onRename,
                    ),
                    SizedBox(width: AppNum.spaceSmall / 2),
                    ClickIcon(
                      size: 16,
                      iconSize: 14,
                      icon: Icons.add_rounded,
                      color: Colors.grey[400],
                      onPressed: widget.onAppend,
                    ),
                    SizedBox(width: AppNum.spaceSmall / 2),
                  ],
                  ClickIcon(
                    size: 16,
                    iconSize: 14,
                    icon: Icons.close_rounded,
                    color: Colors.grey[400],
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

import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:once_power/widgets/common/one_line_text.dart';

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
      color: Colors.white,
      child: Ink(
        child: InkWell(
          onTap: widget.onTap,
          child: MouseRegion(
            onEnter: (event) => setState(() => show = true),
            onExit: (event) => setState(() => show = false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              height: AppNum.presetMenuItemH,
              width: AppNum.presetMenuW,
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
                      onTap: widget.onRename,
                    ),
                    SizedBox(width: AppNum.smallG / 2),
                    ClickIcon(
                      size: 16,
                      iconSize: 14,
                      icon: Icons.add_rounded,
                      color: Colors.grey[400],
                      onTap: widget.onAppend,
                    ),
                    SizedBox(width: AppNum.smallG / 2),
                  ],
                  ClickIcon(
                    size: 16,
                    iconSize: 14,
                    icon: Icons.close_rounded,
                    color: Colors.grey[400],
                    onTap: widget.onRemove,
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

import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/one_line_text.dart';

class GroupListItem extends StatefulWidget {
  const GroupListItem({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  State<GroupListItem> createState() => _GroupListItemState();
}

class _GroupListItemState extends State<GroupListItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() => isHover = true),
      onExit: (event) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: isHover ? Theme.of(context).hoverColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OneLineText(widget.label),
            ClickIcon(
              icon: Icons.close_rounded,
              iconSize: 14,
              size: 18,
              color: Colors.black26,
              onPressed: widget.onTap,
            ),
          ],
        ),
      ),
    );
  }
}

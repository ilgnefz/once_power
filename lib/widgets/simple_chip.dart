import 'package:flutter/material.dart';

import 'my_text.dart';

const borderRadius = BorderRadius.all(Radius.circular(8));

class SimpleChip extends StatelessWidget {
  const SimpleChip({
    Key? key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.color,
  }) : super(key: key);

  final String label;
  final bool selected;
  final void Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: color != null
            ? Colors.black12
            : (selected
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(.2)),
        borderRadius: borderRadius,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_rounded,
                size: 20,
                color: color ??
                    (selected ? Colors.white : Theme.of(context).primaryColor),
              ),
              const SizedBox(width: 4),
              MyText(
                label,
                color: color ??
                    (selected ? Colors.white : Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

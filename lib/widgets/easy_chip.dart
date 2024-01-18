import 'package:flutter/material.dart';

const borderRadius = BorderRadius.all(Radius.circular(8));

class EasyChip extends StatelessWidget {
  const EasyChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.enable = true,
  });

  final String label;
  final bool selected;
  final void Function()? onTap;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: enable
            ? (selected
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(.2))
            : Colors.black12,
        borderRadius: borderRadius,
      ),
      child: InkWell(
        onTap: enable ? onTap : null,
        borderRadius: borderRadius,
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: enable
                  ? (selected ? Colors.white : Theme.of(context).primaryColor)
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

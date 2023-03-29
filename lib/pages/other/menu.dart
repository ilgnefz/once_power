import 'package:flutter/material.dart';
import 'package:once_power/provider/other.dart';
import 'package:once_power/widgets/my_text.dart';

const borderRadius = BorderRadius.all(Radius.circular(8));

class OtherMenu extends StatelessWidget {
  const OtherMenu({
    super.key,
    required this.title,
    required this.provider,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final OtherProvider provider;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor.withOpacity(.6);
    return Container(
      margin: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 48,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: selected ? color : Colors.transparent,
          ),
          child: MyText(
            title,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

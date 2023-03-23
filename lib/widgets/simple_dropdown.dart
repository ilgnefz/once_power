import 'package:flutter/material.dart';
import 'package:once_power/widgets/my_text.dart';

class SimpleDropdown extends StatelessWidget {
  const SimpleDropdown({
    Key? key,
    this.label,
    this.leading,
    this.color,
    required this.value,
    this.onChanged,
    required this.items,
  }) : super(key: key);

  final String? label;
  final dynamic value;
  final Color? color;
  final void Function(dynamic)? onChanged;
  final List<DropdownMenuItem<dynamic>> items;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (leading == null) MyText(label!, color: color) else leading!,
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 32),
          child: DropdownButton<dynamic>(
            style: const TextStyle(color: Colors.black, fontSize: 14),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 20,
            elevation: 1,
            value: value,
            underline: const SizedBox(),
            focusColor: Colors.transparent,
            onChanged: onChanged,
            items: items,
          ),
        )
      ],
    );
  }
}

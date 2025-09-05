import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

class DateDropdown extends ConsumerWidget {
  const DateDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextDropdown(
      items: DateType.values
          .map(
            (item) => DropdownMenuItem(
              key: ValueKey(item),
              value: item,
              child: Text(
                item.label,
                style: Theme.of(context).dropdownMenuTheme.textStyle,
              ),
            ),
          )
          .toList(),
      value: ref.watch(currentDateTypeProvider),
      onChanged: (value) {
        ref.read(currentDateTypeProvider.notifier).update(value!);
        updateName(ref);
      },
    );
  }
}

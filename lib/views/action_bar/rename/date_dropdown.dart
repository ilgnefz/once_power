import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/two_re_enum.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/widgets/common/easy_text_dropdown.dart';

class DateDropdown extends ConsumerWidget {
  const DateDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyTextDropdown(
      items: DateType.values
          .map((item) => DropdownMenuItem(
                key: ValueKey(item),
                value: item,
                child: Text(
                  item.label,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.labelMedium?.color,
                  ),
                ),
              ))
          .toList(),
      value: ref.watch(currentDateTypeProvider),
      onChanged: (value) {
        ref.read(currentDateTypeProvider.notifier).update(value!);
        updateName(ref);
      },
    );
  }
}

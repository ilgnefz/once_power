import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class AppendCheckbox extends ConsumerWidget {
  const AppendCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyCheckbox(
      checked: ref.watch(isAppendModeProvider),
      onChanged: (value) => ref.watch(isAppendModeProvider.notifier).update(),
      child: Text(S.of(context).appendMode),
    );
  }
}

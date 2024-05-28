import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/custom_tooltip.dart';

class SaveButton extends ConsumerWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String openSave = S.of(context).enableSaveConfig;
    final String closeSave = S.of(context).closeSaveConfig;

    bool save = ref.watch(saveConfigProvider);

    return CustomTooltip(
      content: Text(
        save ? openSave : closeSave,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      child: ClickIcon(
        size: 24,
        svg: AppIcons.save,
        color: save ? Theme.of(context).primaryColor : Colors.grey,
        onTap: ref.read(saveConfigProvider.notifier).update,
      ),
    );
  }
}

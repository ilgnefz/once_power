import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/common/click_icon.dart';

class ContentVisible extends ConsumerWidget {
  const ContentVisible({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    bool active = ref.watch(toggleChangedProvider);
    return ClickIcon(
      tip: tr(AppL10n.contentVisible),
      icon: active ? Icons.visibility_off : Icons.visibility,
      color: active ? theme.primaryColor : theme.iconTheme.color,
      onPressed: () {
        ref.read(toggleChangedProvider.notifier).update();
        ref.read(onlyChangedProvider.notifier).update(false);
        updateName(ref);
      },
      onSecondaryTap: () {
        ref.read(toggleChangedProvider.notifier).update();
        ref.read(onlyChangedProvider.notifier).update(true);
        updateName(ref);
      },
    );
  }
}

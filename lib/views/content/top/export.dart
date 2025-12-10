import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class ExportBtn extends ConsumerWidget {
  const ExportBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    return ClickIcon(
      icon: Icons.ios_share_rounded,
      color: theme.iconTheme.color,
      iconSize: 18,
      onPressed: () => showExportMenu(context),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/widget/common/click_icon.dart';

class ExportFileButton extends ConsumerWidget {
  const ExportFileButton({super.key});

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

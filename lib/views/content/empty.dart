import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/base/easy_icon.dart';

class EmptyView extends ConsumerWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color color = Theme.of(context).primaryColor;
    bool isView = ref.watch(isViewModeProvider);
    String label = isView
        ? tr(AppL10n.contentEmptyImage)
        : tr(AppL10n.contentEmpty);
    return Center(
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EasyIcon(
            icon: isView ? null : Icons.drive_folder_upload_rounded,
            svg: isView ? AppIcons.image : null,
            iconSize: 88,
            color: Theme.of(context).primaryColor,
          ),
          Text(label, style: TextStyle(fontSize: 18, color: color)),
        ],
      ),
    );
  }
}

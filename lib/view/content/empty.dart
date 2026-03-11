import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/base/text.dart';

class EmptyView extends ConsumerWidget {
  const EmptyView({super.key, required this.showImage});

  final bool showImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color color = Theme.of(context).primaryColor;
    String label = showImage
        ? tr(AppL10n.contentEmptyImage)
        : tr(AppL10n.contentEmpty);
    return Center(
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BaseIcon(
            icon: showImage ? null : Icons.drive_folder_upload_rounded,
            svg: showImage ? AppIcons.image : null,
            size: 88,
            color: color,
          ),
          BaseText(label, fontSize: 18, color: color),
        ],
      ),
    );
  }
}

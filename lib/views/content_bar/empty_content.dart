import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/easy_icon.dart';

class EmptyContent extends ConsumerWidget {
  const EmptyContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isViewMode = ref.watch(isViewModeProvider);
    FunctionMode mode = ref.watch(currentModeProvider);
    bool showImage = isViewMode && mode != FunctionMode.organize;
    String tipLabel = showImage ? S.of(context).tipImage : S.of(context).tip;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EasyIcon(
            svg: showImage ? AppIcons.image : null,
            icon: showImage ? null : Icons.drive_folder_upload_rounded,
            iconSize: 80,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            tipLabel,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryColor,
            ).useSystemChineseFont(),
          ),
        ],
      ),
    );
  }
}

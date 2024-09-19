import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/svg_icon.dart';

class EmptyView extends ConsumerWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isViewMode = ref.watch(viewModeProvider);
    FunctionMode mode = ref.watch(currentModeProvider);
    bool showImage = isViewMode && mode != FunctionMode.organize;
    String tipLabel = showImage ? S.of(context).tipImage : S.of(context).tip;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showImage
              ? SvgIcon(AppIcons.image,
                  size: 80, color: Theme.of(context).primaryColor)
              : Icon(
                  Icons.drive_folder_upload_rounded,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
          Text(
            tipLabel,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
            ).useSystemChineseFont(),
          ),
        ],
      ),
    );
  }
}

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/views/action_bar/rename_menu/apply_menu/apply_button.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/custom_tooltip.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

class UploadCSV extends ConsumerWidget {
  const UploadCSV({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String uploadCSV = S.of(context).uploadCSV;

    void upload() async {
      const xType = XTypeGroup(label: 'CSV', extensions: ['csv']);
      final XFile? file = await openFile(acceptedTypeGroups: [xType]);
      if (file != null) {
        ref.read(cSVDataProvider.notifier).update([]);
        String content = await file.readAsString();
        List<List<String>> list = content.trimRight().split('\n').map((e) {
          final list = e.trimRight().split(',');
          return [list[0], list[1]];
        }).toList();
        ref.read(cSVDataProvider.notifier).update(list);
      }
      newFeatureRename(ref);
      // updateName(ref);
    }

    return CustomTooltip(
      message: uploadCSV,
      textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
          .useSystemChineseFont(),
      placement: Placement.top,
      child: ClickIcon(
        size: 24,
        svg: AppIcons.csv,
        color: Colors.grey,
        onTap: upload,
      ),
    );
  }
}

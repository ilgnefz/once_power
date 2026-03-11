import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/update/csv.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/model/csv.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/widget/bottom/icon.dart';
import 'package:path/path.dart' as path;

class CSVButton extends ConsumerWidget {
  const CSVButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomClickIcon(
      tip: tr(AppL10n.bottomCSV),
      svg: AppIcons.csv,
      selected: ref.watch(cSVDataProvider).isNotEmpty,
      onPressed: () async {
        bool isOrganize = ref.watch(currentModeProvider).isOrganize;
        if (isOrganize || ref.watch(isDateModifyProvider)) {
          return showCSVWarningNotification();
        }
        List<String> extensions = ['csv', 'txt', 'log'];
        final XTypeGroup xType = XTypeGroup(
          label: 'CSV',
          extensions: extensions,
        );
        final XFile? file = await openFile(acceptedTypeGroups: [xType]);
        if (file == null) return;
        String extension = path.extension(file.path);
        List<CSVRenameInfo> list = [];
        if (extension == '.log') {
          list.addAll(await decodeLogData(file));
        } else {
          list.addAll(await decodeCSVData(file));
        }
        ref.read(cSVDataProvider.notifier).update(list);
        cSVUpdateName(ref);
      },
    );
  }
}

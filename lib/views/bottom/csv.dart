import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/csv.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/models/csv.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';
import 'package:path/path.dart' as path;

class CSVBtn extends ConsumerWidget {
  const CSVBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TooltipIcon(
      tip: tr(AppL10n.bottomCSV),
      svg: AppIcons.csv,
      onPressed: () async {
        bool isOrganize = ref.watch(currentModeProvider).isOrganize;
        bool isModifyDate = ref.watch(isDateModifyProvider);
        if (isOrganize || isModifyDate) return showCSVWarningNotification();
        List<String> extensions = ['csv', 'txt', 'oplog'];
        final XTypeGroup xType = XTypeGroup(
          label: 'CSV',
          extensions: extensions,
        );
        final XFile? file = await openFile(acceptedTypeGroups: [xType]);
        if (file != null && !ref.watch(currentModeProvider).isOrganize) {
          String ext = path.extension(file.path);
          List<CsvRenameInfo> list = [];
          if (ext == '.oplog') {
            list.addAll(await decodeOPLogData(file));
          } else {
            list.addAll(await decodeCSVData(file));
          }
          ref.read(cSVDataProvider.notifier).update(list);
        }
        updateName(ref);
      },
    );
  }
}

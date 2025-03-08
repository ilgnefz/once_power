import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/csv_rename.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';
import 'package:path/path.dart' as path;

class UploadCSVBtn extends ConsumerWidget {
  const UploadCSVBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void upload() async {
      List<String> extensions = ['csv', 'txt', 'oplog'];
      final xType = XTypeGroup(label: 'CSV', extensions: extensions);
      final XFile? file = await openFile(acceptedTypeGroups: [xType]);
      if (file != null && !ref.watch(currentModeProvider).isOrganize) {
        ref.read(cSVDataProvider.notifier).update([]);
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
    }

    return TooltipIcon(
      tip: S.of(context).uploadCSV,
      svg: AppIcons.csv,
      onTap: upload,
    );
  }
}

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/file.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';
import 'package:path/path.dart' as path;

class UploadCSVBtn extends ConsumerWidget {
  const UploadCSVBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String tip = S.of(context).uploadCSV;

    void upload() async {
      const xType =
          XTypeGroup(label: 'CSV', extensions: ['csv', 'txt', 'oplog']);
      final XFile? file = await openFile(acceptedTypeGroups: [xType]);
      if (file != null && !ref.watch(currentModeProvider).isOrganize) {
        ref.read(cSVDataProvider.notifier).update([]);
        String ext = path.extension(file.path);
        List<EasyRenameInfo> list = [];
        if (ext == '.oplog') {
          list.addAll(await decodeOPLogData(file));
        } else {
          list.addAll(await decodeCSVData(file));
        }
        // print(list);
        ref.read(cSVDataProvider.notifier).update(list);
      }
      cSVDataRename(ref);
      // updateName(ref);
    }

    return TooltipIcon(
      message: tip,
      icon: AppIcons.csv,
      onTap: upload,
    );
  }
}

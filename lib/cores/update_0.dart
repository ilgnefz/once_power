import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';

void updateName(WidgetRef ref) {
  print('update name');
  FunctionMode mode = ref.watch(currentModeProvider);
  bool hasCSV = ref.watch(cSVDataProvider).isNotEmpty;
  if (hasCSV) return csvDataRename(ref);
  if (mode.isAdvance) return advanceUpdateName(ref);
  if (mode.isReplace) return normalUpdateName(ref, false);
  if (mode.isReserve) return normalUpdateName(ref, true);
}

void csvDataRename(WidgetRef ref) {}

void normalUpdateName(WidgetRef ref, bool isReserve) {
  List<FileInfo> list = ref.watch(sortListProvider);
  bool dateRename = ref.watch(isDateRenameProvider);
  String prefix = ref.watch(prefixControllerProvider).text;
  bool prefixCycle = ref.watch(isCyclePrefixProvider);
  String suffix = ref.watch(suffixControllerProvider).text;
  bool suffixCycle = ref.watch(isCycleSuffixProvider);
  int index = 0;
  for (FileInfo file in list) {
    if (!file.checked) {
      // ref
      //     .read(fileListProvider.notifier)
      //     .update(file.copyWith(name: file.name));
      continue;
    }
    String name = isReserve ? '' : file.name;
    name = prefix + name + suffix;
    ref.read(fileListProvider.notifier).updateNewName(file.id, name);
    index++;
  }
}

void advanceUpdateName(WidgetRef ref) {}

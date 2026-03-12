import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/enum/rule.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/rule.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/util/storage.dart';

Future<void> advanceUpdateName(WidgetRef ref) async {}

Future<void> autoGroupFile(WidgetRef ref, List<GroupRule> list) async {
  if (list.isEmpty) return;
  List<FileInfo> files = ref.watch(sortListProvider);
  List<FileInfo> checkedFiles = files.where((e) => e.checked).toList();
  for (GroupRule item in list) {
    InfoType type = item.infoType;
    ComparisonOperator operator = item.operator;
    String value = item.value;
    String group = item.group;
    for (FileInfo file in checkedFiles) {
      String info = getRuleTypeValue(type, file);
      if (getCompareResult(operator, value, info)) {
        if (group != '') {
          List<String> list = StorageUtil.getStringList(AppKeys.groupList);
          if (!list.contains(group)) {
            list.add(group);
            await StorageUtil.setStringList(AppKeys.groupList, list);
          }
        }
        ref.read(fileListProvider.notifier).updateGroup(file.id, group);
      }
    }
  }
  advanceUpdateName(ref);
}

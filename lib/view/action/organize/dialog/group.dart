import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/widget/action/folder_input.dart';
import 'package:once_power/widget/base/dialog.dart';

class GroupList extends ConsumerStatefulWidget {
  const GroupList({super.key});

  @override
  ConsumerState<GroupList> createState() => _GroupListState();
}

class _GroupListState extends ConsumerState<GroupList> {
  List<String> list = [];
  Map<String, String> groupMap = {};

  @override
  void initState() {
    super.initState();
    list = StorageUtil.getStringList(AppKeys.groupList);
    Map<String, String>? map = StorageUtil.getStringMap(AppKeys.groupFolder);
    for (var element in list) {
      if (map?.containsKey(element) == true) {
        groupMap[element] = map![element]!;
        continue;
      }
      groupMap[element] = '';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: tr(AppL10n.organizeGroupFolder),
      content: Column(
        spacing: AppNum.spaceMedium,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(list.length, (index) {
          return Row(
            spacing: AppNum.spaceMedium,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 80),
                child: Text(
                  '${list[index]}: ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: FolderInput(
                  controller: TextEditingController(
                    text: groupMap[list[index]],
                  ),
                  onChanged: (value) =>
                      setState(() => groupMap[list[index]] = value),
                ),
              ),
            ],
          );
        }).toList(),
      ),
      onOk: () async =>
          await StorageUtil.setStringMap(AppKeys.groupFolder, groupMap),
    );
  }
}

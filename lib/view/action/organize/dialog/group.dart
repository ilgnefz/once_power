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
  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    list = StorageUtil.getStringList(AppKeys.groupList);
    Map<String, String>? map = StorageUtil.getStringMap(AppKeys.groupFolder);
    for (String element in list) {
      if (map?.containsKey(element) == true) {
        groupMap[element] = map![element]!;
      } else {
        groupMap[element] = '';
      }
      controllers[element] = TextEditingController(text: groupMap[element]);
    }
    setState(() {});
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: tr(AppL10n.organizeGroupFolder),
      content: Column(
        spacing: AppNum.spaceMedium,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(list.length, (index) {
          String key = list[index];
          return Row(
            spacing: AppNum.spaceMedium,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 80),
                child: Text(
                  '$key: ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: FolderInput(
                  controller: controllers[key]!, // 使用缓存的 controller
                  onChanged: (value) {
                    setState(() => groupMap[key] = value);
                    controllers[key]!.text = value;
                  },
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

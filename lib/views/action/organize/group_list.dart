import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/views/action/advance/dialog/common_dialog.dart';
import 'package:once_power/widgets/action/folder_input.dart';

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
    return CommonDialog(
      title: tr(AppL10n.organizeGroupFolder),
      child: Column(
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
                  value: groupMap[list[index]],
                  onChanged: (v) {
                    groupMap[list[index]] = v;
                    setState(() {});
                  },
                ),
              ),
            ],
          );
        }).toList(),
      ),
      onOk: () async {
        await StorageUtil.setStringMap(AppKeys.groupFolder, groupMap);
      },
      // onCancel: () {},
      // onModelTap: () {},
    );
  }
}

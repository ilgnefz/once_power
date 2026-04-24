import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/input_field.dart';

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
    for (String element in list) {
      if (map?.containsKey(element) == true) {
        groupMap[element] = map![element]!;
      } else {
        groupMap[element] = '';
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: tr(AppL10n.organizeGroupFolder),
      padding: .zero,
      content: ListView.separated(
        itemCount: list.length,
        shrinkWrap: true,
        padding: .symmetric(horizontal: AppNum.padding),
        itemBuilder: (BuildContext context, int index) {
          String key = list[index];
          return Row(
            spacing: AppNum.spaceMedium,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: Text('$key: ', maxLines: 1, overflow: .ellipsis),
              ),
              Expanded(
                child: InputField(
                  key: ValueKey(key),
                  text: groupMap[key] ?? '',
                  hintText: tr(AppL10n.organizeTarget),
                  onClear: () => setState(() => groupMap[key] = ''),
                  onChanged: (value) => setState(() => groupMap[key] = value),
                  action: ClickIcon(
                    icon: Icons.folder_open_rounded,
                    onPressed: () async {
                      final String? folder = await getDirectoryPath();
                      if (folder == null || folder.isEmpty) return;
                      setState(() => groupMap[key] = folder);
                    },
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (_, _) => SizedBox(height: AppNum.spaceSmall),
      ),
      onOk: () async {
        debugPrint(groupMap.toString());
        await StorageUtil.setStringMap(AppKeys.groupFolder, groupMap);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/views/action_bar/advance/dialog/common_dialog.dart';
import 'package:once_power/views/action_bar/advance/dialog/dialog_base_input.dart';
import 'package:once_power/views/content_bar/group_list_item.dart';

class EditGroup extends ConsumerStatefulWidget {
  const EditGroup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditGroupState();
}

class _EditGroupState extends ConsumerState<EditGroup> {
  String name = '';
  List<String> list = [];

  @override
  void initState() {
    super.initState();
    list = StorageUtil.getStringList(AppKeys.groupList);
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: S.of(context).editGroup,
      autoPop: false,
      child: Column(
        spacing: AppNum.mediumG,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (list.isNotEmpty)
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppNum.mediumG,
                  mainAxisSpacing: AppNum.mediumG,
                  childAspectRatio: 6,
                ),
                itemBuilder: (context, index) => GroupListItem(
                  label: list[index],
                  onTap: () async {
                    await removeGroup(ref, list[index]);
                    list.removeAt(index);
                    setState(() {});
                  },
                ),
              ),
            ),
          DialogBaseInput(
            value: name,
            autofocus: true,
            hintText: S.of(context).group,
            onChanged: (value) {
              name = value;
              setState(() {});
            },
          ),
        ],
      ),
      onOk: () async {
        if (name == '') return Navigator.pop(context);
        List<String> list = StorageUtil.getStringList(AppKeys.groupList);
        if (!list.contains(name)) {
          list.add(name);
          await StorageUtil.setStringList(AppKeys.groupList, list);
        }
        if (context.mounted) setGroup(context, ref, name);
      },
    );
  }
}

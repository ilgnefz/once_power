import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/common/dialog.dart';
import 'package:once_power/widgets/common/dialog_input.dart';

import 'group_item.dart';

class EditGroup extends ConsumerStatefulWidget {
  const EditGroup({super.key, this.isDirective = false});
  final bool isDirective;

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
      title: tr(AppL10n.dialogGroup),
      autoPop: false,
      child: Column(
        spacing: AppNum.spaceMedium,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (list.isNotEmpty)
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppNum.spaceMedium,
                  mainAxisSpacing: AppNum.spaceMedium,
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
            hintText: tr(AppL10n.dialogGroupHint),
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
        if (!widget.isDirective) {
          if (context.mounted) setGroup(context, ref, name);
        } else {
          List<AdvanceMenuModel> selectList = ref.read(
            advanceMenuSelectedListProvider,
          );
          for (var menu in selectList) {
            ref.read(advanceMenuListProvider.notifier).setGroup(menu.id, name);
          }
          updateName(ref);
          if (context.mounted) Navigator.of(context).pop();
        }
      },
    );
  }
}

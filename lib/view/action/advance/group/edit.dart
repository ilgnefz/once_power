import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/list.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/util/verify.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/common/input_field.dart';

import 'item.dart';

class EditGroup extends ConsumerStatefulWidget {
  const EditGroup({super.key, required this.isDirective, this.file});

  final bool isDirective;
  final FileInfo? file;

  @override
  ConsumerState<EditGroup> createState() => _EditGroupState();
}

class _EditGroupState extends ConsumerState<EditGroup> {
  String name = '';
  late List<String> list;

  @override
  void initState() {
    super.initState();
    list = StorageUtil.getStringList(AppKeys.groupList);
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: tr(AppL10n.dialogGroup),
      padding: .zero,
      content: Column(
        spacing: AppNum.spaceMedium,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (list.isNotEmpty)
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .6,
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  padding: .symmetric(horizontal: AppNum.padding),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: AppNum.spaceSmall,
                    mainAxisSpacing: AppNum.spaceMedium,
                    childAspectRatio: 4.8,
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
            ),
          InputField(
            text: name,
            autofocus: true,
            margin: .symmetric(horizontal: AppNum.padding),
            hintText: tr(AppL10n.dialogGroupHint),
            onChanged: (value) => setState(() => name = value.trim()),
          ),
        ],
      ),
      autoPop: false,
      onOk: () {
        if (name == '') return showGroupAddErrorNotification();
        if (isAll(name)) return Navigator.pop(context);
        if (!list.contains(name)) {
          list.add(name);
          StorageUtil.setStringList(AppKeys.groupList, list);
        }
        if (widget.isDirective) {
          List<AdvanceMenuModel> selectList = ref.read(
            advanceMenuSelectedListProvider,
          );
          for (AdvanceMenuModel menu in selectList) {
            ref.read(advanceMenuListProvider.notifier).setGroup(menu.id, name);
          }
        } else {
          ref
              .read(fileListProvider.notifier)
              .updateGroup(widget.file!.id, name);
        }
        advanceUpdateName(ref);
        Navigator.pop(context);
      },
    );
  }
}

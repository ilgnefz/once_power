import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/rename.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:once_power/widgets/simple_checkbox.dart';
import 'package:once_power/widgets/space_box.dart';
import 'package:provider/provider.dart';

class ContentBar extends StatelessWidget {
  const ContentBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RenameProvider>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 1),
        ],
      ),
      child: Column(
        children: [
          FileList(
            height: 40,
            selected: provider.selectedAll,
            onChanged: (v) => provider.toggleSelectAll(),
            color: Colors.black,
            originName:
                '${S.of(context).originalName}[${provider.selectedFilesCount}/${provider.filesCount}]',
            targetName: S.of(context).renameName,
            action: PopupMenuButton(
              icon: const Icon(Icons.filter_alt),
              iconSize: 24,
              surfaceTintColor: Colors.white,
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap: provider.deleteUnselected,
                    child: MyText(S.of(context).deleteUnselected),
                  ),
                  PopupMenuItem(
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return SimpleCheckbox(
                          title: S.of(context).showUnselected,
                          checked: provider.showUnselected,
                          onChange: (v) {
                            provider.toggleCheck('showUnselected');
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                  ...provider.fileTypeList
                      .map(
                        (e) => PopupMenuItem(
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              return SimpleCheckbox(
                                title: e.name,
                                checked: provider.popupTypeSelect(e.name),
                                onChange: (v) {
                                  provider.toggleCheck(e.name);
                                  setState(() {});
                                },
                              );
                            },
                          ),
                        ),
                      )
                      .toList(),
                ];
              },
            ),
          ),
          Expanded(
            child: ReorderableListView.builder(
              buildDefaultDragHandles: false,
              itemCount: provider.files.length,
              onReorder: (oldIndex, newIndex) =>
                  provider.reorderList(oldIndex, newIndex),
              itemBuilder: (context, index) {
                return ReorderableDragStartListener(
                  index: index,
                  key: ValueKey(provider.files[index].id),
                  child: FileList(
                    selected: provider.files[index].checked,
                    onChanged: (v) =>
                        provider.listSwitchCheck(provider.files[index].id),
                    onDoubleTap: () =>
                        provider.doubleTapAdd(provider.files[index].name),
                    originName: provider.files[index].name,
                    targetName: provider.files[index].newName,
                    action: Container(
                      width: 36,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(provider.files[index].extension),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FileList extends StatelessWidget {
  const FileList({
    super.key,
    this.height,
    required this.selected,
    required this.originName,
    required this.targetName,
    required this.action,
    this.color,
    required this.onChanged,
    this.onDoubleTap,
  });

  final double? height;
  final bool selected;
  final String originName;
  final String targetName;
  final Widget action;
  final Color? color;
  final void Function(bool?)? onChanged;
  final void Function()? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: onDoubleTap,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Checkbox(value: selected, onChanged: onChanged),
            ShowTitle(originName, color: color ?? Colors.black54),
            const SpaceBoxWidth(),
            ShowTitle(targetName),
            action,
          ],
        ),
      ),
    );
  }
}

class ShowTitle extends StatelessWidget {
  const ShowTitle(this.title, {super.key, this.color});

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyText(
        title,
        color: color ?? Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.normal,
        maxLines: 1,
      ),
    );
  }
}

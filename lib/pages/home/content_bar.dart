import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/provider/other.dart';
import 'package:once_power/provider/rename.dart';
import 'package:once_power/widgets/file_list_item.dart';
import 'package:once_power/widgets/loading.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:once_power/widgets/simple_checkbox.dart';
import 'package:provider/provider.dart';

class ContentBar extends StatelessWidget {
  const ContentBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RenameProvider>(context);
    final otherProvider = Provider.of<OtherProvider>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 1),
        ],
      ),
      child: provider.total != 0
          ? LoadingPage(
              count: provider.count,
              total: provider.total,
              tip: provider.loadingMessage,
              onPressed: provider.cancelOperate,
            )
          : Column(
              children: [
                FileListItem(
                  height: 40,
                  selected: provider.selectedAll,
                  onChanged: (v) => provider.toggleSelectAll(),
                  color: Colors.black,
                  originName:
                      '${S.of(context).originalName}[${provider.selectedFilesCount}/${provider.filesCount}]',
                  targetName: S.of(context).renameName,
                  titleAction: IconButton(
                    icon: const Icon(Icons.sort_by_alpha_rounded),
                    iconSize: 20,
                    onPressed: provider.sortFiles,
                  ),
                  action: PopupMenuButton(
                    icon: const Icon(Icons.filter_alt),
                    iconSize: 24,
                    surfaceTintColor: Colors.white,
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          onTap: provider.deleteUnselected,
                          child: MyText(
                            S.of(context).deleteUnselected,
                            color: Colors.red,
                          ),
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
                                      title: e.value,
                                      checked:
                                          provider.popupTypeSelect(e.value),
                                      onChange: (v) {
                                        provider.toggleCheck(e.value);
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
                  child: DropTarget(
                    enable: !otherProvider.currentPage,
                    onDragDone: (details) => provider.dropAdd(details),
                    child: ReorderableListView.builder(
                      buildDefaultDragHandles: false,
                      itemCount: provider.files.length,
                      onReorder: (oldIndex, newIndex) =>
                          provider.reorderList(oldIndex, newIndex),
                      itemBuilder: (context, index) {
                        return ReorderableDragStartListener(
                          index: index,
                          key: ValueKey(provider.files[index].id),
                          child: FileListItem(
                            selected: provider.files[index].checked,
                            onChanged: (v) => provider
                                .listSwitchCheck(provider.files[index].id),
                            onDoubleTap: () => provider
                                .doubleTapAdd(provider.files[index].name),
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
                ),
              ],
            ),
    );
  }
}

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/organize_file.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:once_power/widgets/space_box.dart';
import 'package:provider/provider.dart';

class OrganizeFileMenu extends StatefulWidget {
  const OrganizeFileMenu({Key? key}) : super(key: key);

  @override
  State<OrganizeFileMenu> createState() => _OrganizeFileMenuState();
}

class _OrganizeFileMenuState extends State<OrganizeFileMenu> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrganizeFileProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            '*${S.of(context).organizeTip}',
            color: Theme.of(context).primaryColor,
          ),
          const SpaceBoxHeight(),
          Expanded(
            child: DropTarget(
              onDragDone: (detail) => provider.dropFile(detail),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: provider.showFileList.isEmpty
                    ? const EmptyContent()
                    : FileList(provider),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              MyText('${S.of(context).targetFolder}: ', fontSize: 14),
              Expanded(
                child: Container(
                  height: 32,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Expanded(
                        child: MyText(
                          provider.targetFolder == ''
                              ? S.of(context).defaultFolder
                              : provider.targetFolder,
                          fontSize: 14,
                          color: provider.targetFolder == ''
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                      if (provider.targetFolder != '')
                        InkWell(
                          onTap: provider.clearTargetFolder,
                          child: const Icon(Icons.close,
                              size: 18, color: Colors.grey),
                        ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () => provider.addFolder(true),
                child: MyText(S.of(context).selectFolder, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              TextButton(
                onPressed: provider.addFolder,
                child: MyText(S.of(context).addFolder, fontSize: 14),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: provider.deleteEmptyFolder,
                child: MyText(S.of(context).deleteEmptyFolder, fontSize: 14),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: provider.startOrganize,
                child: MyText(S.of(context).startOrganizing, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EmptyContent extends StatelessWidget {
  const EmptyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.drive_folder_upload_rounded,
            size: 80,
            color: Theme.of(context).primaryColor,
          ),
          MyText(
            S.of(context).dropFile,
            fontSize: 18,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

class FileList extends StatelessWidget {
  const FileList(this.provider, {Key? key}) : super(key: key);

  final OrganizeFileProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Expanded(child: MyText(S.of(context).name)),
              InkWell(
                onTap: provider.clearAllFiles,
                child: Icon(
                  Icons.delete_rounded,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: provider.showFileList.length,
            itemBuilder: (context, index) {
              return Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(
                      provider.showFileList[index].icon,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SpaceBoxWidth(),
                    Expanded(
                        child: MyText(provider.showFileList[index].name,
                            fontSize: 14)),
                    InkWell(
                      onTap: () =>
                          provider.clearFiles(provider.showFileList[index].id),
                      child: const Icon(Icons.delete_outline_rounded,
                          size: 20, color: Colors.redAccent),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

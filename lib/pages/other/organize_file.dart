import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/organize_file.dart';
import 'package:once_power/widgets/loading.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:once_power/widgets/simple_checkbox.dart';
import 'package:once_power/widgets/simple_input.dart';
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
          Expanded(
            child: provider.total != 0
                ? LoadingPage(
                    count: provider.count,
                    total: provider.total,
                    tip: provider.loadingMessage,
                    onPressed: provider.cancelOperate,
                  )
                : DropTarget(
                    onDragDone: (detail) => provider.dropFile(detail),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: provider.showList.isEmpty
                          ? const EmptyContent()
                          : FileList(provider),
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              MyText('${S.of(context).targetFolder}: '),
              Expanded(
                child: SimpleInput(
                  controller: provider.targetController,
                  hidden: false,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  readOnly: true,
                  hintText: S.of(context).defaultFolder,
                  // textStyle: TextStyle(fontSize: 18, color: Colors.black),
                  onClear: provider.deleteTargetFolder,
                  onChanged: (v) {},
                ),
              ),
              TextButton(
                onPressed: provider.selectedTargetFolder,
                child: MyText(S.of(context).selectFolder),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              TextButton(
                onPressed: provider.addFolder,
                child: MyText(S.of(context).addFolder),
              ),
              const SizedBox(width: 16),
              SimpleCheckbox(
                title: S.of(context).log,
                checked: provider.saveLog,
                onChange: (v) => provider.toggleCheck(),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: provider.showList.isEmpty ||
                        provider.targetController.text == ''
                    ? null
                    : provider.deleteEmptyFolder,
                child: MyText(S.of(context).deleteEmptyFolder),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: provider.showList.isEmpty ||
                        provider.targetController.text == ''
                    ? null
                    : provider.organizeFile,
                child: MyText(S.of(context).startOrganizing),
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
              Expanded(
                  child: MyText(
                      '${S.of(context).name} [${provider.showList.length}]')),
              InkWell(
                onTap: provider.clearList,
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
            itemCount: provider.showList.length,
            itemBuilder: (context, index) {
              return Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(
                      provider.showList[index].icon,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SpaceBoxWidth(),
                    Expanded(
                      child: MyText(provider.showList[index].name),
                    ),
                    InkWell(
                      onTap: () =>
                          provider.clearList(provider.showList[index].id),
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

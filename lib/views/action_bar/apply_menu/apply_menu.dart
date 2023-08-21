import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/image.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/views/action_bar/apply_menu/apply_button.dart';
import 'package:once_power/widgets/click_text.dart';
import 'package:path/path.dart' as path;

class ApplyMenu extends HookConsumerWidget {
  const ApplyMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String selectFile = '选择文件';
    const String selectFolder = '选择文件夹';

    // final controller = useStreamController<RenameFile>();
    // controller.stream.listen((RenameFile file) {
    //   ref.read(fileListProvider.notifier).add(file);
    // });

    void fileFormat(String filePath) async {
      final files = ref.watch(fileListProvider);
      if (files.any((e) => e.filePath == filePath)) {
        return ref.read(totalProvider.notifier).reduce();
      }
      String id = nanoid(10);
      String name = path.basename(filePath);
      String extension = 'dir';
      DateTime createDate = File(filePath).statSync().changed;
      DateTime modifyDate = File(filePath).statSync().modified;
      if (FileSystemEntity.isFileSync(filePath)) {
        extension = path.extension(filePath);
        // 有可能文件没有扩展名
        if (extension != '') {
          name = name.split(extension).first;
          extension = extension.substring(1);
        }
        // 如果是图片就获取 exif 中的拍摄日期
        // if (image.contains(extension)) {
        //   ref.read(exifDateProvider.notifier).update(filePath);
        // }
      }

      FileClassify type = ref.read(getFileClassifyProvider(extension));
      // if (!ref.watch(classifyListProvider).contains(type)) {
      //   ref.read(classifyListProvider.notifier).add(type);
      // }
      RenameFile renameFile = RenameFile(
        id: id,
        name: name,
        newName: name,
        parent: path.dirname(filePath),
        filePath: filePath,
        extension: extension,
        createDate: createDate,
        modifyDate: modifyDate,
        exifDate: ref.watch(exifDateProvider),
        type: type,
        checked: true,
      );
      ref.read(fileListProvider.notifier).add(renameFile);
      // controller.add(renameFile);
    }

    void addFile() async {
      final List<XFile> files = await openFiles();
      if (files.isNotEmpty) {
        bool isAppend = ref.watch(appendModeProvider);
        if (!isAppend) ref.read(fileListProvider.notifier).clear();
        int total = isAppend ? ref.watch(totalProvider) : 0;
        ref.read(totalProvider.notifier).update(total + files.length);
        for (var file in files) {
          await Future.delayed(const Duration(seconds: 1)); // TODO 删除
          fileFormat(file.path);
        }
      }
    }

    void addFolder() async {
      final List<String?> folders = await getDirectoryPaths();
      if (folders.isEmpty) return;
      List<String> files = [];
      bool isAppend = ref.watch(appendModeProvider);
      if (!isAppend) ref.read(fileListProvider.notifier).clear();
      int total = isAppend ? ref.watch(totalProvider) : 0;
      int beforeCount = ref.watch(fileListProvider).length;
      ref.read(totalProvider.notifier).update(total + beforeCount);
      if (ref.watch(addFolderProvider)) {
        ref.read(totalProvider.notifier).update(total + folders.length);
        for (var folder in folders) {
          fileFormat(folder!);
        }
      } else {
        for (var folder in folders) {
          files.addAll(ref.read(getAllFileProvider(folder!)));
          ref.read(totalProvider.notifier).update(total + files.length);
        }
        for (var file in files) {
          // await Future.delayed(const Duration(seconds: 1));
          fileFormat(file);
        }
      }
    }

    return Row(
      children: [
        ClickText(selectFile, onTap: addFile),
        ClickText(selectFolder, onTap: addFolder),
        const Spacer(),
        const ApplyButton(),
      ],
    );
  }
}

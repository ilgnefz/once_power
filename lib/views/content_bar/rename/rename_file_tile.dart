import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/rename.dart';
import 'package:once_power/widgets/check_tile.dart';
import 'package:once_power/widgets/easy_tooltip.dart';
import 'package:once_power/widgets/normal_tile.dart';
import 'package:once_power/widgets/tip_text.dart';

class RenameFileTile extends ConsumerWidget {
  const RenameFileTile(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String name = '原名称';
    const String newName = '重命名';
    const String folder = '文件夹';
    const String createTime = '创建日期';
    const String modifyDate = '修改日期';
    const String exifDate = '拍摄日期';

    void autoInput() {
      ref.watch(matchControllerProvider).text = file.name;
      updateName(ref);
    }

    void toggleCheck(v) {
      ref.read(fileListProvider.notifier).check(file.id);
      updateName(ref);
      updateExtension(ref);
    }

    void delete() {
      ref.read(fileListProvider.notifier).remove(file.id);
    }

    String dot = file.extension == '' ? '' : '.';
    String newDot = file.newExtension == '' ? '' : '.';
    return EasyTooltip(
      margin: const EdgeInsets.only(left: 240),
      richMessage: WidgetSpan(
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TipText(
                  label: name,
                  content: '${file.name}$dot${file.extension}',
                ),
                TipText(
                  label: newName,
                  content: '${file.newName}$newDot${file.newExtension}',
                ),
                TipText(label: folder, content: file.parent),
                TipText(label: createTime, content: '${file.createDate}'),
                TipText(label: modifyDate, content: '${file.modifyDate}'),
                if (file.exifDate != null)
                  TipText(label: exifDate, content: '${file.exifDate}'),
              ],
            ),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        child: Ink(
          color: Colors.white,
          child: InkWell(
            hoverColor: Theme.of(context).primaryColor.withOpacity(.1),
            onDoubleTap: autoInput,
            child: Row(
              children: [
                CheckTile(
                  check: file.checked,
                  label: file.name,
                  fontSize: AppNum.tileFontSize,
                  onChanged: toggleCheck,
                  color: Colors.grey,
                ),
                NormalTile(label: file.newName, fontSize: AppNum.tileFontSize),
                SizedBox(
                  width: AppNum.extensionW,
                  child: Center(
                    child: Text(
                      file.newExtension,
                      style: const TextStyle(fontSize: AppNum.tileFontSize),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(
                  width: AppNum.deleteW,
                  child: Center(
                    child: IconButton(
                      onPressed: delete,
                      color: Colors.black26,
                      icon: const Icon(Icons.delete_rounded),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

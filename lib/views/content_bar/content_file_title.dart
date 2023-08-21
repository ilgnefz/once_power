import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/widgets/check_tile.dart';
import 'package:once_power/widgets/easy_tooltip.dart';
import 'package:once_power/widgets/normal_tile.dart';

class ContentFileTitle extends HookConsumerWidget {
  const ContentFileTitle({super.key, required this.file});

  final RenameFile file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String name = '原名称';
    const String newName = '重命名';
    const String folder = '文件夹';
    const String createTime = '创建日期';
    const String modifyDate = '修改日期';
    const String exifDate = '拍摄日期';

    const double fontSize = 12;

    final hover = useState(false);

    void delete() {
      ref.read(fileListProvider.notifier).remove(file.id);
      ref.read(totalProvider.notifier).reduce();
    }

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
                Text('$name：${file.name}.${file.extension}'),
                Text('$newName：${file.newName}.${file.extension}'),
                Text('$folder：${file.parent}'),
                Text('$createTime：${file.createDate}'),
                Text('$modifyDate：${file.modifyDate}'),
                if (file.exifDate != null) Text('$exifDate：${file.exifDate}'),
              ],
            ),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (_) => hover.value = true,
        onExit: (_) => hover.value = false,
        child: ColoredBox(
          // duration: const Duration(milliseconds: 200),
          color: hover.value
              ? Theme.of(context).colorScheme.background
              : Colors.white,
          child: Row(
            children: [
              CheckTile(
                check: file.checked,
                label: file.name,
                fontSize: fontSize,
                onChanged: (v) =>
                    ref.read(fileListProvider.notifier).check(file.id),
                color: Colors.grey,
              ),
              NormalTile(label: file.newName, fontSize: fontSize),
              SizedBox(
                width: AppNum.extensionW,
                child: Center(
                  child: Text(
                    file.extension,
                    style: const TextStyle(fontSize: fontSize),
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
                    icon: const Icon(Icons.delete_forever_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

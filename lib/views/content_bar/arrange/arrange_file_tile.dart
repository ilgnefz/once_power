import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/normal_tile.dart';

class ArrangeFileTile extends ConsumerWidget {
  const ArrangeFileTile(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Ink(
        color: Colors.white,
        child: InkWell(
          hoverColor: Theme.of(context).primaryColor.withOpacity(.1),
          onTap: () {},
          child: Row(
            children: [
              const SizedBox(width: AppNum.gapW),
              Icon(
                getFileIcon(file.extension),
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              NormalTile(
                label: file.extension == '' || file.type == FileClassify.folder
                    ? file.name
                    : '${file.name}.${file.extension}',
                fontSize: AppNum.tileFontSize,
              ),
              SizedBox(
                width: AppNum.deleteW,
                child: Center(
                  child: Text(
                    file.type.value,
                    style: const TextStyle(fontSize: AppNum.tileFontSize),
                  ),
                ),
              ),
              SizedBox(
                width: AppNum.deleteW,
                child: Center(
                  child: IconButton(
                    onPressed: () =>
                        ref.read(fileListProvider.notifier).remove(file.id),
                    color: Colors.black26,
                    icon: const Icon(Icons.delete_rounded),
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

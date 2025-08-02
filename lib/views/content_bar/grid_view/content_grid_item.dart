import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/widgets/content_bar/select_sort_card.dart';

import '../../../models/file_enum.dart';
import 'avif_view.dart';
import 'image_view.dart';
import 'psd_view.dart';
import 'svg_view.dart';
import 'video_view.dart';

class ContentGridItem extends StatelessWidget {
  const ContentGridItem({super.key, required this.file, required this.files});

  final List<FileInfo> files;
  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String newName = getNameWithExt(file.newName, file.newExtension);
    String oldName = getNameWithExt(file.name, file.extension);
    return SelectSortCard(
      index: files.indexOf(file),
      file: file,
      onDoubleTap: () => previewView(context, files, file),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 4, right: 4, top: 0, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Builder(builder: (context) {
                  if (file.type.isVideo) {
                    return VideoView(file: file, key: ValueKey(file.id));
                  } else if (file.extension == 'svg') {
                    return SvgView(file: file, key: ValueKey(file.id));
                  } else if (file.extension == 'psd') {
                    return PsdView(file: file, key: ValueKey(file.id));
                  } else if (file.extension == 'avif') {
                    return AvifView(file: file, key: ValueKey(file.id));
                  }
                  return ImageView(file: file, key: ValueKey(file.id));
                }),
              ),
              const SizedBox(height: 4),
              Text(
                newName,
                style: TextStyle(
                  fontSize: AppNum.tileFontSize,
                  color: file.checked
                      ? newName == oldName
                          ? theme.textTheme.labelMedium?.color
                          : theme.primaryColor
                      : Colors.grey,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

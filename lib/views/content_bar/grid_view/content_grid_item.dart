import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/widgets/content_bar/select_sort_card.dart';

import '../../../models/file_enum.dart';
import 'image_view.dart';
import 'preview_view.dart';
import 'video_view.dart';

class ContentGridItem extends StatelessWidget {
  const ContentGridItem({super.key, required this.file, required this.files});

  final List<FileInfo> files;
  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    void previewView() {
      showDialog(
        context: context,
        builder: (context) => PreviewView(files, file),
      );
    }

    return SelectSortCard(
      index: files.indexOf(file),
      file: file,
      onDoubleTap: previewView,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 4, right: 4, top: 0, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: file.type == FileClassify.image
                    ? ImageView(file: file, key: ValueKey(file.id))
                    : VideoView(file: file, key: ValueKey(file.id)),
              ),
              const SizedBox(height: 4),
              Text(
                getNameWithExt(file.newName, file.newExtension),
                style: TextStyle(
                  fontSize: AppNum.tileFontSize,
                  color: file.checked ? Colors.black : Colors.grey,
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

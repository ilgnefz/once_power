import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/utils/utils.dart';

import 'image_view.dart';
import 'preview_view.dart';
import 'video_view.dart';

class ViewModeTile extends StatelessWidget {
  const ViewModeTile(this.files, this.file, {super.key});

  final List<FileInfo> files;
  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    void previewView() {
      showDialog(
        context: context,
        builder: (context) => PreviewImageView(files, file),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onDoubleTap: previewView,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 4,
              right: 4,
              top: 0,
              bottom: 4,
            ),
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
                  getFileName(file.newName, file.newExtension),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/views/content_bar/rename/view_mode/image_view.dart';

import 'video_view.dart';
import 'preview_view.dart';

class ViewModeTile extends StatelessWidget {
  const ViewModeTile(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    FileClassify classify = file.type;

    void previewView() {
      showDialog(
        context: context,
        builder: (context) {
          if (classify == FileClassify.image) {
            return PreviewImageView(file.filePath);
          }
          return PreviewVideoView(file.filePath);
        },
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onDoubleTap: previewView,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: classify == FileClassify.image
                    ? ImageView(file: file, key: ValueKey(file.id))
                    : VideoView(file: file, key: ValueKey(file.id)),
              ),
              const SizedBox(height: 4),
              Text(
                fileName(file.newName, file.newExtension),
                style: TextStyle(
                  fontSize: AppNum.tileFontSize,
                  color: file.checked ? Colors.black : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

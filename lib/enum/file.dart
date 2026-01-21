import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/const/l10n.dart';

enum FileClassify { image, video, audio, doc, archive, folder, other }

extension FileClassifyExtension on FileClassify {
  String get label {
    switch (this) {
      case FileClassify.image:
        return tr(AppL10n.eTypeImage);
      case FileClassify.video:
        return tr(AppL10n.eTypeVideo);
      case FileClassify.audio:
        return tr(AppL10n.eTypeAudio);
      case FileClassify.doc:
        return tr(AppL10n.eTypeDoc);
      case FileClassify.archive:
        return tr(AppL10n.eTypeArchive);
      case FileClassify.folder:
        return tr(AppL10n.eTypeFolder);
      case FileClassify.other:
        return tr(AppL10n.eTypeOther);
    }
  }

  bool get isImage => this == FileClassify.image;
  bool get isVideo => this == FileClassify.video;
  bool get isAudio => this == FileClassify.audio;
  bool get isDoc => this == FileClassify.doc;
  bool get isArchive => this == FileClassify.archive;
  bool get isFolder => this == FileClassify.folder;
  bool get isOther => this == FileClassify.other;
}

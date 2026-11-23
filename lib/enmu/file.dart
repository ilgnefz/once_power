import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constant/l10n.dart';

enum FileType { image, video, audio, doc, archive, folder, other }

extension FileClassifyExtension on FileType {
  String get label {
    switch (this) {
      case FileType.image:
        return tr(AppL10n.image);
      case FileType.video:
        return tr(AppL10n.video);
      case FileType.audio:
        return tr(AppL10n.audio);
      case FileType.doc:
        return tr(AppL10n.doc);
      case FileType.archive:
        return tr(AppL10n.archive);
      case FileType.folder:
        return tr(AppL10n.folder);
      case FileType.other:
        return tr(AppL10n.typeOther);
    }
  }

  bool get isImage => this == FileType.image;
  bool get isVideo => this == FileType.video;
  bool get isAudio => this == FileType.audio;
  bool get isDoc => this == FileType.doc;
  bool get isArchive => this == FileType.archive;
  bool get isFolder => this == FileType.folder;
  bool get isOther => this == FileType.other;
}

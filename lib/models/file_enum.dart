import 'package:once_power/generated/l10n.dart';

enum FileClassify { image, video, doc, audio, folder, zip, other }

extension FileClassifyExtension on FileClassify {
  String get label {
    switch (this) {
      case FileClassify.image:
        return S.current.image;
      case FileClassify.video:
        return S.current.video;
      case FileClassify.doc:
        return S.current.document;
      case FileClassify.audio:
        return S.current.audio;
      case FileClassify.folder:
        return S.current.folder;
      case FileClassify.zip:
        return S.current.zip;
      case FileClassify.other:
        return S.current.other;
    }
  }

  bool get isFolder => this == FileClassify.folder;
  bool get isImage => this == FileClassify.image;
  bool get isVideo => this == FileClassify.video;
  bool get isDoc => this == FileClassify.doc;
  bool get isAudio => this == FileClassify.audio;
  bool get isZip => this == FileClassify.zip;
  bool get isOther => this == FileClassify.other;
}

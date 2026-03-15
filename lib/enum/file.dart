import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/const/l10n.dart';

enum FileType { image, video, audio, doc, archive, folder, other }

extension FileClassifyExtension on FileType {
  String get label {
    switch (this) {
      case FileType.image:
        return tr(AppL10n.eTypeImage);
      case FileType.video:
        return tr(AppL10n.eTypeVideo);
      case FileType.audio:
        return tr(AppL10n.eTypeAudio);
      case FileType.doc:
        return tr(AppL10n.eTypeDoc);
      case FileType.archive:
        return tr(AppL10n.eTypeArchive);
      case FileType.folder:
        return tr(AppL10n.eTypeFolder);
      case FileType.other:
        return tr(AppL10n.eTypeOther);
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

enum RenameCondition { available, override, blocked }

extension RenameConditionExtension on RenameCondition {
  bool get isAvailable => this == RenameCondition.available;
  bool get isOverride => this == RenameCondition.override;
  bool get isBlocked => this == RenameCondition.blocked;
}

enum MetaDataType { title, artist, album, year, make, model, location }

extension MetaDataTypeExtension on MetaDataType {
  String get label {
    switch (this) {
      case MetaDataType.title:
        return tr(AppL10n.eMetaTitle);
      case MetaDataType.artist:
        return tr(AppL10n.eMetaArtist);
      case MetaDataType.album:
        return tr(AppL10n.eMetaAlbum);
      case MetaDataType.year:
        return tr(AppL10n.eMetaYear);
      case MetaDataType.make:
        return tr(AppL10n.eMetaMake);
      case MetaDataType.model:
        return tr(AppL10n.eMetaModel);
      case MetaDataType.location:
        return tr(AppL10n.eMetaLocation);
    }
  }

  bool get isTitle => this == MetaDataType.title;
  bool get isArtist => this == MetaDataType.artist;
  bool get isAlbum => this == MetaDataType.album;
  bool get isYear => this == MetaDataType.year;
  bool get isMake => this == MetaDataType.make;
  bool get isModel => this == MetaDataType.model;
  bool get isLocation => this == MetaDataType.location;
}

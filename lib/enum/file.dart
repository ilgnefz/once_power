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

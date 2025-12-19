import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constants/l10n.dart';

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

enum DateType {
  createdDate,
  modifiedDate,
  accessedDate,
  exifDate,
  earliestDate,
  latestDate,
}

extension DateTypeExtension on DateType {
  String get label {
    switch (this) {
      case DateType.createdDate:
        return tr(AppL10n.eDateCreate);
      case DateType.modifiedDate:
        return tr(AppL10n.eDateModify);
      case DateType.accessedDate:
        return tr(AppL10n.eDateAccess);
      case DateType.exifDate:
        return tr(AppL10n.eDateCapture);
      case DateType.earliestDate:
        return tr(AppL10n.eDateEarliest);
      case DateType.latestDate:
        return tr(AppL10n.eDateLatest);
    }
  }

  bool get isCreatedDate => this == DateType.createdDate;
  bool get isModifiedDate => this == DateType.modifiedDate;
  bool get isAccessedDate => this == DateType.accessedDate;
  bool get isExifDate => this == DateType.exifDate;
  bool get isEarliestDate => this == DateType.earliestDate;
  bool get isLatestDate => this == DateType.latestDate;
}

enum FileMetaData { title, artist, album, year, make, model, location }

extension FileMetaDataExtension on FileMetaData {
  String get label {
    switch (this) {
      case FileMetaData.title:
        return tr(AppL10n.eMetaTitle);
      case FileMetaData.artist:
        return tr(AppL10n.eMetaArtist);
      case FileMetaData.album:
        return tr(AppL10n.eMetaAlbum);
      case FileMetaData.year:
        return tr(AppL10n.eMetaYear);
      case FileMetaData.make:
        return tr(AppL10n.eMetaMake);
      case FileMetaData.model:
        return tr(AppL10n.eMetaModel);
      case FileMetaData.location:
        return tr(AppL10n.eMetaLocation);
    }
  }

  bool get isTitle => this == FileMetaData.title;
  bool get isArtist => this == FileMetaData.artist;
  bool get isAlbum => this == FileMetaData.album;
  bool get isYear => this == FileMetaData.year;
  bool get isMake => this == FileMetaData.make;
  bool get isModel => this == FileMetaData.model;
  bool get isLocation => this == FileMetaData.location;
}

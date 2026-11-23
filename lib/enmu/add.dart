import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constant/l10n.dart';

enum AddMode {
  enter,
  date,
  indexes,
  meta,
  random,
  folder,
  width,
  height,
  extension,
  group,
}

extension AddModeExtension on AddMode {
  String get label {
    switch (this) {
      case AddMode.enter:
        return tr(AppL10n.advanceEnter);
      case AddMode.indexes:
        return tr(AppL10n.addIndex);
      case AddMode.random:
        return tr(AppL10n.addRandom);
      case AddMode.folder:
        return tr(AppL10n.addDirectory);
      case AddMode.width:
        return tr(AppL10n.addWidth);
      case AddMode.height:
        return tr(AppL10n.addHeight);
      case AddMode.extension:
        return tr(AppL10n.addExtension);
      case AddMode.date:
        return tr(AppL10n.addDate);
      case AddMode.group:
        return tr(AppL10n.addGroup);
      case AddMode.meta:
        return tr(AppL10n.addMeta);
    }
  }

  bool get isEnter => this == AddMode.enter;
  bool get isIndex => this == AddMode.indexes;
  bool get isFolder => this == AddMode.folder;
  bool get isExtension => this == AddMode.extension;
  bool get isDate => this == AddMode.date;
  bool get isRandom => this == AddMode.random;
  bool get isWidth => this == AddMode.width;
  bool get isHeight => this == AddMode.height;
  bool get isMeta => this == AddMode.meta;
  bool get isGroup => this == AddMode.group;
}

enum DateStyle {
  hidden,
  none,
  chinese,
  year,
  month,
  day,
  space,
  dash,
  underscore,
  dot,
}

extension DateStyleExtension on DateStyle {
  String get label {
    switch (this) {
      case DateStyle.hidden:
        return tr(AppL10n.dateSeparateHidden);
      case DateStyle.none:
        return tr(AppL10n.dateSeparateNone);
      case DateStyle.chinese:
        return '年月日';
      case DateStyle.year:
        return '年';
      case DateStyle.month:
        return '月';
      case DateStyle.day:
        return '日';
      case DateStyle.space:
        return tr(AppL10n.dateSeparateSpace);
      case DateStyle.dash:
        return '-';
      case DateStyle.dot:
        return '.';
      case DateStyle.underscore:
        return '_';
    }
  }
}

enum TimeStyle { hidden, none, chinese, english, space, dash, underscore, dot }

extension TimeStyleExtension on TimeStyle {
  String get label {
    switch (this) {
      case TimeStyle.hidden:
        return tr(AppL10n.dateSeparateHidden);
      case TimeStyle.none:
        return tr(AppL10n.dateSeparateNone);
      case TimeStyle.chinese:
        return '时分秒';
      case TimeStyle.english:
        return 'hms';
      case TimeStyle.space:
        return tr(AppL10n.dateSeparateSpace);
      case TimeStyle.dash:
        return '-';
      case TimeStyle.dot:
        return '.';
      case TimeStyle.underscore:
        return '_';
    }
  }
}

enum DateSeparate { none, space, dash, underscore, dot, custom }

extension DateSeparateTypeExtension on DateSeparate {
  String get label {
    switch (this) {
      case DateSeparate.none:
        return tr(AppL10n.dateSeparateNone);
      case DateSeparate.space:
        return tr(AppL10n.dateSeparateSpace);
      case DateSeparate.dash:
        return '-';
      case DateSeparate.dot:
        return '.';
      case DateSeparate.underscore:
        return '_';
      case DateSeparate.custom:
        return tr(AppL10n.dateSeparateCustom);
    }
  }

  String get value {
    switch (this) {
      case DateSeparate.none:
        return '';
      case DateSeparate.space:
        return ' ';
      case DateSeparate.dash:
        return '-';
      case DateSeparate.dot:
        return '.';
      case DateSeparate.underscore:
        return '_';
      case DateSeparate.custom:
        return tr(AppL10n.dateSeparateCustom);
    }
  }

  bool get isCustom => this == DateSeparate.custom;
}

enum IndexRule { none, file, extension, date, folder, group }

extension IndexRuleExtension on IndexRule {
  String get label {
    switch (this) {
      case IndexRule.none:
        return tr(AppL10n.addIndexNone);
      case IndexRule.date:
        return tr(AppL10n.addIndexDate);
      case IndexRule.folder:
        return tr(AppL10n.addIndexFolder);
      case IndexRule.file:
        return tr(AppL10n.addIndexFile);
      case IndexRule.extension:
        return tr(AppL10n.addIndexExtension);
      case IndexRule.group:
        return tr(AppL10n.addIndexGroup);
    }
  }

  bool get isDate => this == IndexRule.date;
  bool get isFolder => this == IndexRule.folder;
  bool get isFile => this == IndexRule.file;
  bool get isExtension => this == IndexRule.extension;
  bool get isGroup => this == IndexRule.group;
  bool get isNone => this == IndexRule.none;
}

enum MetaDataType { title, artist, album, year, make, model, location }

extension MetaDataTypeExtension on MetaDataType {
  String get label {
    switch (this) {
      case MetaDataType.title:
        return tr(AppL10n.metaTitle);
      case MetaDataType.artist:
        return tr(AppL10n.metaArtist);
      case MetaDataType.album:
        return tr(AppL10n.metaAlbum);
      case MetaDataType.year:
        return tr(AppL10n.metaYear);
      case MetaDataType.make:
        return tr(AppL10n.metaMake);
      case MetaDataType.model:
        return tr(AppL10n.metaModel);
      case MetaDataType.location:
        return tr(AppL10n.metaLocation);
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

enum AddPosition { behind, front, end, interval }

extension AddPositionExtension on AddPosition {
  String get label {
    switch (this) {
      case AddPosition.front:
        return tr(AppL10n.addPositionFront);
      case AddPosition.behind:
        return tr(AppL10n.addPositionBehind);
      case AddPosition.end:
        return tr(AppL10n.addPositionEnd);
      case AddPosition.interval:
        return tr(AppL10n.addPositionInterval);
    }
  }

  bool get isBefore => this == AddPosition.front;
  bool get isAfter => this == AddPosition.behind;
  bool get isEnd => this == AddPosition.end;
  bool get isInterval => this == AddPosition.interval;
}

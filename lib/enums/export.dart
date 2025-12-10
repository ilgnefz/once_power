import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constants/l10n.dart';

enum ExportType { csv, txt }

extension ExportTypeExtension on ExportType {
  String get label {
    switch (this) {
      case ExportType.csv:
        return 'CSV';
      case ExportType.txt:
        return tr(AppL10n.eAddText);
    }
  }

  String get extension {
    switch (this) {
      case ExportType.csv:
        return 'csv';
      case ExportType.txt:
        return 'txt';
    }
  }

  String get mimeType {
    switch (this) {
      case ExportType.csv:
        return 'text/csv';
      case ExportType.txt:
        return 'text/plain';
    }
  }

  bool get isCsv => this == ExportType.csv;
  bool get isTxt => this == ExportType.txt;
}

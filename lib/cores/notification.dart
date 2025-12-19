import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/notification.dart';
import 'package:once_power/models/notification.dart';
import 'package:path/path.dart' as path;

void showCopyNotification(String message) {
  NotificationInfo(
    title: tr(AppL10n.successCopy),
    time: 2,
    message: message,
  ).show();
}

void showEmptyNotification() {
  NotificationInfo(
    type: NotificationType.error,
    title: tr(AppL10n.errEmptyTitle),
    message: tr(AppL10n.errEmpty),
    time: 2,
  ).show();
}

void showSuspenseErrorNotification() {
  NotificationInfo(
    type: NotificationType.error,
    title: tr(AppL10n.errSuspense),
    message: tr(AppL10n.errTxtDecodeInfo),
    time: 3,
  ).show();
}

void showTxtDecodeNotification(String err) {
  NotificationInfo(
    type: NotificationType.error,
    title: tr(AppL10n.errTxtDecode),
    message: tr(AppL10n.errTxtDecodeInfo),
    time: 5,
  ).show();
}

void showCSVWarningNotification() {
  NotificationInfo(
    type: NotificationType.warning,
    title: tr(AppL10n.warnLabel),
    message: tr(AppL10n.warnCsv),
    time: 5,
  ).show();
}

void showCSVDecodeError1Notification(String err) {
  NotificationInfo(
    type: NotificationType.error,
    title: tr(AppL10n.errCSV1),
    message: err,
    time: 5,
  ).show();
}

void showCSVDecodeError2Notification() {
  NotificationInfo(
    type: NotificationType.error,
    title: tr(AppL10n.errCSV1),
    message: tr(AppL10n.errCSV2),
    time: 5,
  ).show();
}

void showDateModifyNotification(List<InfoDetail> errors, int total) {
  NotificationInfo info = NotificationInfo(
    title: tr(AppL10n.successModifyDate),
    message: tr(AppL10n.successModifyDateInfo, namedArgs: {"total": "$total"}),
  );
  if (errors.isNotEmpty) {
    info.type = NotificationType.error;
    info.title = tr(AppL10n.errModifyDate);
    info.message = tr(AppL10n.errModifyDateInfo);
    info.detailList = errors;
  }
  info.show();
}

void showPresetAddErrorNotification() {
  return NotificationInfo(
    type: NotificationType.error,
    title: tr(AppL10n.errPresetNameTitle),
    message: tr(AppL10n.errPresetName),
    time: 3,
  ).show();
}

void showPresetEmptyNotification() {
  return NotificationInfo(
    type: NotificationType.error,
    title: tr(AppL10n.errPresetAddTitle),
    message: tr(AppL10n.errPresetAdd),
    time: 3,
  ).show();
}

void showPresetImportNotification({int? num, String? err}) {
  if (num != null) {
    NotificationInfo(
      title: tr(AppL10n.successImport),
      message: tr(AppL10n.successImportNum, namedArgs: {"count": "$num"}),
      time: 3,
    ).show();
  }
  if (err != null) {
    NotificationInfo(
      type: NotificationType.error,
      title: tr(AppL10n.errImport),
      message: err.replaceAll('Exception:', ''),
      time: 5,
    ).show();
  }
}

void showPresetExportNotification({int? num, String? err}) {
  if (num != null) {
    NotificationInfo(
      title: tr(AppL10n.successExport),
      message: tr(AppL10n.successExportNum, namedArgs: {"count": "$num"}),
      time: 3,
    ).show();
  }
  if (err != null) {
    NotificationInfo(
      type: NotificationType.error,
      title: tr(AppL10n.errExport),
      message: err,
      time: 5,
    ).show();
  }
}

InfoDetail renameErrorNotification(Object e, String oldPath, String newPath) {
  debugPrint(e.runtimeType.toString());
  String message = '';
  if (e.runtimeType == PathNotFoundException) {
    message = ': ${tr(AppL10n.errNotExists, namedArgs: {
          'folder': path.dirname(newPath)
        })}';
  } else {
    message = tr(AppL10n.errRenameInfo, namedArgs: {'err': e.toString()});
  }
  return InfoDetail(file: path.basename(oldPath), message: message);
}

void showRenameNotification(List<InfoDetail> errors, int total) {
  NotificationInfo info = NotificationInfo(
    title: tr(AppL10n.successRename),
    message: tr(AppL10n.successRenameNum, namedArgs: {'count': '$total'}),
  );
  if (errors.isNotEmpty) {
    info.type = NotificationType.error;
    info.title = tr(AppL10n.errRename);
    info.message = tr(
      AppL10n.errRenameNum,
      namedArgs: {'total': '$total', 'count': '${errors.length}'},
    );
    info.detailList = errors;
  }
  info.show();
}

void showUndoNotification(List<InfoDetail> errors, int count) {
  NotificationInfo info = NotificationInfo(
    title: tr(AppL10n.successUndo),
    message: tr(AppL10n.successUndoNum, namedArgs: {'count': '$count'}),
  );
  if (errors.isNotEmpty) {
    info.type = NotificationType.error;
    info.title = tr(AppL10n.errUndo);
    info.message = tr(
      AppL10n.errUndoNum,
      namedArgs: {'total': '${errors.length}', 'count': '$count'},
    );
    info.detailList = errors;
  }
  info.show();
}

void showDeleteNotification(List<InfoDetail> errors, [bool isEmpty = true]) {
  NotificationInfo info = NotificationInfo(
    title: tr(AppL10n.successDelete),
    message: tr(
      isEmpty ? AppL10n.successDeleteEmpty : AppL10n.successDeleteSelected,
    ),
  );
  if (errors.isNotEmpty) {
    info.type = NotificationType.error;
    info.title = tr(AppL10n.errDelete);
    info.message = tr(AppL10n.errDeleteInfo);
    info.detailList = errors;
  }
  info.show();
}

void showOrganizeEmptyNotification() {
  NotificationInfo(
    type: NotificationType.error,
    title: tr(AppL10n.errOrganize),
    message: tr(AppL10n.errOrganizeInfo2),
  ).show();
}

void showOrganizeNullNotification(String message) {
  NotificationInfo(
    type: NotificationType.error,
    title: tr(AppL10n.errOrganize),
    message: message,
  ).show();
}

void showOrganizeNotification(List<InfoDetail> errors, int count) {
  NotificationInfo info = NotificationInfo(
    title: tr(AppL10n.successOrganize),
    message: tr(AppL10n.successOrganizeNum, namedArgs: {'count': '$count'}),
  );
  if (errors.isNotEmpty) {
    info.type = NotificationType.error;
    info.title = tr(AppL10n.errOrganize);
    info.message = tr(AppL10n.errOrganizeInfo1);
    info.detailList = errors;
  }
  info.show();
}

InfoDetail moveErrorNotification(
  Object e,
  bool sameDisk,
  String oldPath,
  String newPath,
) {
  String message = '${tr(AppL10n.errMove)}: $e';
  return InfoDetail(file: oldPath, message: message);
}

void showOpenErrorNotification(String info, [int? time]) {
  NotificationInfo(
    type: NotificationType.error,
    title: tr(AppL10n.errOpen),
    message: info,
    time: time,
  ).show();
}

void showFilterNotification(int count) {
  if (count > 0) {
    NotificationInfo(
      title: tr(AppL10n.successViewMode),
      message: tr(AppL10n.successRemove, namedArgs: {'count': '$count'}),
    ).show();
  }
}

void showKeyErrorNotification(String message) {
  NotificationInfo(
    type: NotificationType.error,
    title: tr(AppL10n.errLocation),
    message: message,
  ).show();
}

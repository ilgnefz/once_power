import 'dart:io';

import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/utils/log.dart';
import 'package:path/path.dart' as path;

void showFilterNotification(int removeCount) {
  if (removeCount > 0) {
    NotificationInfo(
      title: S.current.viewMode,
      message: S.current.removeNonImage(removeCount),
    ).show();
  }
}

void showRenameNotification(List<InfoDetail> errors, int total) {
  NotificationInfo info = NotificationInfo(
    title: S.current.successful,
    message: S.current.successfulNum(total),
  );
  if (errors.isNotEmpty) {
    info.type = NotificationType.error;
    info.title = S.current.failed;
    info.message = S.current.failedNum(errors.length, total);
    info.detailList = errors;
  }
  info.show();
}

void showUndoNotification(List<InfoDetail> errors, int total) {
  NotificationInfo info = NotificationInfo(
    title: S.current.undoSuccessful,
    message: S.current.undoSuccessfulNum(total),
  );
  if (errors.isNotEmpty) {
    info.type = NotificationType.error;
    info.title = S.current.undoFailed;
    info.message = S.current.undoFailedNum(errors.length, total);
    info.detailList = errors;
  }
  info.show();
}

void showDeleteNotification(List<InfoDetail> errors) {
  NotificationInfo info = NotificationInfo(
    title: S.current.deleteSuccessful,
    message: S.current.successDeleteInfo,
  );
  if (errors.isNotEmpty) {
    info.type = NotificationType.error;
    info.title = S.current.deleteFailed;
    info.message = S.current.failureDeleteInfo;
    info.detailList = errors;
  }
  info.show();
}

void showOrganizeEmptyNotification() {
  NotificationInfo(
    type: NotificationType.error,
    title: S.current.organizingFailed,
    message: S.current.targetFolderError,
  ).show();
}

void showOrganizeNullNotification() {
  NotificationInfo(
    type: NotificationType.error,
    title: S.current.organizingFailed,
    message: S.current.classifyFolderError,
  ).show();
}

void showOrganizeNotification(List<InfoDetail> errors, int total) {
  NotificationInfo info = NotificationInfo(
    title: S.current.organizedSuccessfully,
    message: S.current.organizedSuccessfullyInfo(total),
  );
  if (errors.isNotEmpty) {
    info.type = NotificationType.error;
    info.title = S.current.organizingFailed;
    info.message = S.current.organizingFailedInfo;
    info.detailList = errors;
  }
  info.show();
}

void showOpenErrorNotification(String info, [int? time]) {
  NotificationInfo(
    type: NotificationType.error,
    title: S.current.openError,
    message: info,
    time: time,
  ).show();
}

InfoDetail renameErrorInfo(Object e, String oldPath, String newPath) {
  Log.e(e.runtimeType.toString());
  String message = '';
  if (e.runtimeType == PathNotFoundException) {
    message = ': ${S.current.notExistsError(path.dirname(newPath))}';
  } else {
    message = S.current.failedError(e);
  }
  return InfoDetail(file: path.basename(oldPath), message: message);
}

InfoDetail moveErrorInfo(
    Object e, bool sameDisk, String oldPath, String newPath) {
  String message = '${S.current.moveFailed}: $e';
  if (sameDisk) message = '${S.current.moveError}: $e';
  return InfoDetail(file: oldPath, message: message);
}

void showEmptyNotification() {
  NotificationInfo(
    type: NotificationType.error,
    title: S.current.emptyFolderErrorTitle,
    message: S.current.emptyFolderError,
    time: 2,
  ).show();
}

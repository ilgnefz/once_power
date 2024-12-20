// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Replace`
  String get replace {
    return Intl.message(
      'Replace',
      name: 'replace',
      desc: '',
      args: [],
    );
  }

  /// `Reserve`
  String get reserve {
    return Intl.message(
      'Reserve',
      name: 'reserve',
      desc: '',
      args: [],
    );
  }

  /// `Organize`
  String get organize {
    return Intl.message(
      'Organize',
      name: 'organize',
      desc: '',
      args: [],
    );
  }

  /// `Matching content`
  String get matchHint {
    return Intl.message(
      'Matching content',
      name: 'matchHint',
      desc: '',
      args: [],
    );
  }

  /// `Input disabled`
  String get inputDisable {
    return Intl.message(
      'Input disabled',
      name: 'inputDisable',
      desc: '',
      args: [],
    );
  }

  /// `Number or length string`
  String get matchLength {
    return Intl.message(
      'Number or length string',
      name: 'matchLength',
      desc: '',
      args: [],
    );
  }

  /// `Matching`
  String get match {
    return Intl.message(
      'Matching',
      name: 'match',
      desc: '',
      args: [],
    );
  }

  /// `Before`
  String get before {
    return Intl.message(
      'Before',
      name: 'before',
      desc: '',
      args: [],
    );
  }

  /// `After`
  String get after {
    return Intl.message(
      'After',
      name: 'after',
      desc: '',
      args: [],
    );
  }

  /// `Between`
  String get between {
    return Intl.message(
      'Between',
      name: 'between',
      desc: '',
      args: [],
    );
  }

  /// `Modify to`
  String get modifyTo {
    return Intl.message(
      'Modify to',
      name: 'modifyTo',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Created`
  String get createdDate {
    return Intl.message(
      'Created',
      name: 'createdDate',
      desc: '',
      args: [],
    );
  }

  /// `Modified`
  String get modifiedDate {
    return Intl.message(
      'Modified',
      name: 'modifiedDate',
      desc: '',
      args: [],
    );
  }

  /// `ExifDate`
  String get exifDate {
    return Intl.message(
      'ExifDate',
      name: 'exifDate',
      desc: '',
      args: [],
    );
  }

  /// `Earliest`
  String get earliestDate {
    return Intl.message(
      'Earliest',
      name: 'earliestDate',
      desc: '',
      args: [],
    );
  }

  /// `Latest`
  String get latestDate {
    return Intl.message(
      'Latest',
      name: 'latestDate',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Prefix`
  String get prefix {
    return Intl.message(
      'Prefix',
      name: 'prefix',
      desc: '',
      args: [],
    );
  }

  /// `Add prefix content`
  String get prefixContent {
    return Intl.message(
      'Add prefix content',
      name: 'prefixContent',
      desc: '',
      args: [],
    );
  }

  /// `Suffix`
  String get suffix {
    return Intl.message(
      'Suffix',
      name: 'suffix',
      desc: '',
      args: [],
    );
  }

  /// `Add suffix content`
  String get suffixContent {
    return Intl.message(
      'Add suffix content',
      name: 'suffixContent',
      desc: '',
      args: [],
    );
  }

  /// `Serial`
  String get serial {
    return Intl.message(
      'Serial',
      name: 'serial',
      desc: '',
      args: [],
    );
  }

  /// `digits`
  String get digits {
    return Intl.message(
      'digits',
      name: 'digits',
      desc: '',
      args: [],
    );
  }

  /// `start`
  String get start {
    return Intl.message(
      'start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `FileExtension`
  String get fileExtension {
    return Intl.message(
      'FileExtension',
      name: 'fileExtension',
      desc: '',
      args: [],
    );
  }

  /// `New file extension`
  String get fileExtensionDesc {
    return Intl.message(
      'New file extension',
      name: 'fileExtensionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Append`
  String get appendMode {
    return Intl.message(
      'Append',
      name: 'appendMode',
      desc: '',
      args: [],
    );
  }

  /// `Add file`
  String get addFile {
    return Intl.message(
      'Add file',
      name: 'addFile',
      desc: '',
      args: [],
    );
  }

  /// `Add folder`
  String get addFolder {
    return Intl.message(
      'Add folder',
      name: 'addFolder',
      desc: '',
      args: [],
    );
  }

  /// `Select folder`
  String get selectFolder {
    return Intl.message(
      'Select folder',
      name: 'selectFolder',
      desc: '',
      args: [],
    );
  }

  /// `Target folder`
  String get selectTargetFolder {
    return Intl.message(
      'Target folder',
      name: 'selectTargetFolder',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get applyChange {
    return Intl.message(
      'Apply',
      name: 'applyChange',
      desc: '',
      args: [],
    );
  }

  /// `Input length truncation (adding a space between two numbers to truncate the middle part)`
  String get lengthDesc {
    return Intl.message(
      'Input length truncation (adding a space between two numbers to truncate the middle part)',
      name: 'lengthDesc',
      desc: '',
      args: [],
    );
  }

  /// `Case sensitive`
  String get caseDesc {
    return Intl.message(
      'Case sensitive',
      name: 'caseDesc',
      desc: '',
      args: [],
    );
  }

  /// `Named by date`
  String get dateDesc {
    return Intl.message(
      'Named by date',
      name: 'dateDesc',
      desc: '',
      args: [],
    );
  }

  /// `Circular prefix content`
  String get circularPrefixDesc {
    return Intl.message(
      'Circular prefix content',
      name: 'circularPrefixDesc',
      desc: '',
      args: [],
    );
  }

  /// `Circular suffix content`
  String get circularSuffixDesc {
    return Intl.message(
      'Circular suffix content',
      name: 'circularSuffixDesc',
      desc: '',
      args: [],
    );
  }

  /// `Swap prefixes and incremental number positions`
  String get swapPrefixDesc {
    return Intl.message(
      'Swap prefixes and incremental number positions',
      name: 'swapPrefixDesc',
      desc: '',
      args: [],
    );
  }

  /// `Swap suffixes and incremental number positions`
  String get swapSuffixDesc {
    return Intl.message(
      'Swap suffixes and incremental number positions',
      name: 'swapSuffixDesc',
      desc: '',
      args: [],
    );
  }

  /// `Modify file extensions`
  String get extensionDesc {
    return Intl.message(
      'Modify file extensions',
      name: 'extensionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Original name`
  String get originalName {
    return Intl.message(
      'Original name',
      name: 'originalName',
      desc: '',
      args: [],
    );
  }

  /// `Rename name`
  String get renameName {
    return Intl.message(
      'Rename name',
      name: 'renameName',
      desc: '',
      args: [],
    );
  }

  /// `New name`
  String get newName {
    return Intl.message(
      'New name',
      name: 'newName',
      desc: '',
      args: [],
    );
  }

  /// `Created date`
  String get createdTime {
    return Intl.message(
      'Created date',
      name: 'createdTime',
      desc: '',
      args: [],
    );
  }

  /// `Modified date`
  String get modifiedTime {
    return Intl.message(
      'Modified date',
      name: 'modifiedTime',
      desc: '',
      args: [],
    );
  }

  /// `Remove Unselected`
  String get removeUnselected {
    return Intl.message(
      'Remove Unselected',
      name: 'removeUnselected',
      desc: '',
      args: [],
    );
  }

  /// `Remove Selected`
  String get removeSelected {
    return Intl.message(
      'Remove Selected',
      name: 'removeSelected',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Document`
  String get document {
    return Intl.message(
      'Document',
      name: 'document',
      desc: '',
      args: [],
    );
  }

  /// `Audio`
  String get audio {
    return Intl.message(
      'Audio',
      name: 'audio',
      desc: '',
      args: [],
    );
  }

  /// `Folder`
  String get folder {
    return Intl.message(
      'Folder',
      name: 'folder',
      desc: '',
      args: [],
    );
  }

  /// `Zip`
  String get zip {
    return Intl.message(
      'Zip',
      name: 'zip',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get text {
    return Intl.message(
      'Text',
      name: 'text',
      desc: '',
      args: [],
    );
  }

  /// `File name`
  String get fileName {
    return Intl.message(
      'File name',
      name: 'fileName',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get extension {
    return Intl.message(
      'Type',
      name: 'extension',
      desc: '',
      args: [],
    );
  }

  /// `Target folder`
  String get targetFolder {
    return Intl.message(
      'Target folder',
      name: 'targetFolder',
      desc: '',
      args: [],
    );
  }

  /// `Save log (The default is in the logs folder under the software folder)`
  String get saveLog {
    return Intl.message(
      'Save log (The default is in the logs folder under the software folder)',
      name: 'saveLog',
      desc: '',
      args: [],
    );
  }

  /// `Delete empty`
  String get deleteEmptyFolder {
    return Intl.message(
      'Delete empty',
      name: 'deleteEmptyFolder',
      desc: '',
      args: [],
    );
  }

  /// `Delete all empty folders under the selected folder`
  String get deleteEmptyFolderDesc {
    return Intl.message(
      'Delete all empty folders under the selected folder',
      name: 'deleteEmptyFolderDesc',
      desc: '',
      args: [],
    );
  }

  /// `OrganizeMenu`
  String get organizeMenu {
    return Intl.message(
      'OrganizeMenu',
      name: 'organizeMenu',
      desc: '',
      args: [],
    );
  }

  /// `Organize`
  String get organizeBtn {
    return Intl.message(
      'Organize',
      name: 'organizeBtn',
      desc: '',
      args: [],
    );
  }

  /// `Saved Configurations`
  String get saveConfig {
    return Intl.message(
      'Saved Configurations',
      name: 'saveConfig',
      desc: '',
      args: [],
    );
  }

  /// `CurrentTask`
  String get currentTask {
    return Intl.message(
      'CurrentTask',
      name: 'currentTask',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get takeTime {
    return Intl.message(
      'Time',
      name: 'takeTime',
      desc: '',
      args: [],
    );
  }

  /// `Check Version`
  String get checkUpdate {
    return Intl.message(
      'Check Version',
      name: 'checkUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Checking`
  String get checking {
    return Intl.message(
      'Checking',
      name: 'checking',
      desc: '',
      args: [],
    );
  }

  /// `Check completed`
  String get checkCompleted {
    return Intl.message(
      'Check completed',
      name: 'checkCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Check failed`
  String get checkFailed {
    return Intl.message(
      'Check failed',
      name: 'checkFailed',
      desc: '',
      args: [],
    );
  }

  /// `New version {version} can be updated`
  String newVersionInfo(Object version) {
    return Intl.message(
      'New version $version can be updated',
      name: 'newVersionInfo',
      desc: '',
      args: [version],
    );
  }

  /// `Currently in the latest version`
  String get noNewVersionInfo {
    return Intl.message(
      'Currently in the latest version',
      name: 'noNewVersionInfo',
      desc: '',
      args: [],
    );
  }

  /// `Instructions for use`
  String get useDesc {
    return Intl.message(
      'Instructions for use',
      name: 'useDesc',
      desc: '',
      args: [],
    );
  }

  /// `Log`
  String get log {
    return Intl.message(
      'Log',
      name: 'log',
      desc: '',
      args: [],
    );
  }

  /// `The target folder is not empty and is saved in the target folder, otherwise it is saved in the logs folder of the software directory`
  String get logDesc {
    return Intl.message(
      'The target folder is not empty and is saved in the target folder, otherwise it is saved in the logs folder of the software directory',
      name: 'logDesc',
      desc: '',
      args: [],
    );
  }

  /// `Move all added files or all sub-files under a folder into the destination folder. If the destination folder is empty and you choose to use the top-level parent folder, all files will be moved to the top-level parent folder of the selected files in addition to the disk root folder`
  String get organizeFolderDesc {
    return Intl.message(
      'Move all added files or all sub-files under a folder into the destination folder. If the destination folder is empty and you choose to use the top-level parent folder, all files will be moved to the top-level parent folder of the selected files in addition to the disk root folder',
      name: 'organizeFolderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Open Folder`
  String get openFolder {
    return Intl.message(
      'Open Folder',
      name: 'openFolder',
      desc: '',
      args: [],
    );
  }

  /// `Left mouse click on the file list to quickly open the folder where the file is located`
  String get openFolderDesc {
    return Intl.message(
      'Left mouse click on the file list to quickly open the folder where the file is located',
      name: 'openFolderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Drag the File/Folder here`
  String get tip {
    return Intl.message(
      'Drag the File/Folder here',
      name: 'tip',
      desc: '',
      args: [],
    );
  }

  /// `Drag the Picture File/Folder here`
  String get tipImage {
    return Intl.message(
      'Drag the Picture File/Folder here',
      name: 'tipImage',
      desc: '',
      args: [],
    );
  }

  /// `Upload .txt file`
  String get uploadDesc {
    return Intl.message(
      'Upload .txt file',
      name: 'uploadDesc',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// ` The file renamed to {name} already exists`
  String existsError(Object name) {
    return Intl.message(
      ' The file renamed to $name already exists',
      name: 'existsError',
      desc: '',
      args: [name],
    );
  }

  /// `No longer exists in {name}`
  String notExistsError(Object name) {
    return Intl.message(
      'No longer exists in $name',
      name: 'notExistsError',
      desc: '',
      args: [name],
    );
  }

  /// ` renaming failed, Because {name}`
  String failedError(Object name) {
    return Intl.message(
      ' renaming failed, Because $name',
      name: 'failedError',
      desc: '',
      args: [name],
    );
  }

  /// `Renaming successful`
  String get successful {
    return Intl.message(
      'Renaming successful',
      name: 'successful',
      desc: '',
      args: [],
    );
  }

  /// `Renaming failed`
  String get failed {
    return Intl.message(
      'Renaming failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `All {total} selected items have been successfully renamed`
  String successfulNum(Object total) {
    return Intl.message(
      'All $total selected items have been successfully renamed',
      name: 'successfulNum',
      desc: '',
      args: [total],
    );
  }

  /// `{count} out of {total} selected renames failed`
  String failedNum(Object count, Object total) {
    return Intl.message(
      '$count out of $total selected renames failed',
      name: 'failedNum',
      desc: '',
      args: [count, total],
    );
  }

  /// `delete logs`
  String get deleteLog {
    return Intl.message(
      'delete logs',
      name: 'deleteLog',
      desc: '',
      args: [],
    );
  }

  /// `【{file}】 has been deleted`
  String deleteInfo(Object file) {
    return Intl.message(
      '【$file】 has been deleted',
      name: 'deleteInfo',
      desc: '',
      args: [file],
    );
  }

  /// `Delete failed`
  String get deleteFailed {
    return Intl.message(
      'Delete failed',
      name: 'deleteFailed',
      desc: '',
      args: [],
    );
  }

  /// `Delete successful`
  String get deleteSuccessful {
    return Intl.message(
      'Delete successful',
      name: 'deleteSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Successfully deleted all empty folders`
  String get successEmptyInfo {
    return Intl.message(
      'Successfully deleted all empty folders',
      name: 'successEmptyInfo',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete empty folder`
  String get failureEmptyInfo {
    return Intl.message(
      'Failed to delete empty folder',
      name: 'failureEmptyInfo',
      desc: '',
      args: [],
    );
  }

  /// `Successfully deleted all selected files`
  String get successDeleteInfo {
    return Intl.message(
      'Successfully deleted all selected files',
      name: 'successDeleteInfo',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete selected files`
  String get failureDeleteInfo {
    return Intl.message(
      'Failed to delete selected files',
      name: 'failureDeleteInfo',
      desc: '',
      args: [],
    );
  }

  /// `not exist`
  String get notExist {
    return Intl.message(
      'not exist',
      name: 'notExist',
      desc: '',
      args: [],
    );
  }

  /// `organize logs`
  String get organizeLogs {
    return Intl.message(
      'organize logs',
      name: 'organizeLogs',
      desc: '',
      args: [],
    );
  }

  /// `rename logs`
  String get renameLogs {
    return Intl.message(
      'rename logs',
      name: 'renameLogs',
      desc: '',
      args: [],
    );
  }

  /// `Move failed`
  String get moveFailed {
    return Intl.message(
      'Move failed',
      name: 'moveFailed',
      desc: '',
      args: [],
    );
  }

  /// `Moving error`
  String get moveError {
    return Intl.message(
      'Moving error',
      name: 'moveError',
      desc: '',
      args: [],
    );
  }

  /// `Organized successfully`
  String get organizedSuccessfully {
    return Intl.message(
      'Organized successfully',
      name: 'organizedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Organizing failed`
  String get organizingFailed {
    return Intl.message(
      'Organizing failed',
      name: 'organizingFailed',
      desc: '',
      args: [],
    );
  }

  /// `Successfully moved the selected {total} files`
  String organizedSuccessfullyInfo(Object total) {
    return Intl.message(
      'Successfully moved the selected $total files',
      name: 'organizedSuccessfullyInfo',
      desc: '',
      args: [total],
    );
  }

  /// `The following moves failed`
  String get organizingFailedInfo {
    return Intl.message(
      'The following moves failed',
      name: 'organizingFailedInfo',
      desc: '',
      args: [],
    );
  }

  /// `Restart takes effect`
  String get restartTip {
    return Intl.message(
      'Restart takes effect',
      name: 'restartTip',
      desc: '',
      args: [],
    );
  }

  /// `View mode`
  String get viewMode {
    return Intl.message(
      'View mode',
      name: 'viewMode',
      desc: '',
      args: [],
    );
  }

  /// `Selected {count}/{total}`
  String fileCount(Object count, Object total) {
    return Intl.message(
      'Selected $count/$total',
      name: 'fileCount',
      desc: '',
      args: [count, total],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Unselect`
  String get unselect {
    return Intl.message(
      'Unselect',
      name: 'unselect',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Match name`
  String get matchName {
    return Intl.message(
      'Match name',
      name: 'matchName',
      desc: '',
      args: [],
    );
  }

  /// `Modify name`
  String get modifyName {
    return Intl.message(
      'Modify name',
      name: 'modifyName',
      desc: '',
      args: [],
    );
  }

  /// `Undo`
  String get undo {
    return Intl.message(
      'Undo',
      name: 'undo',
      desc: '',
      args: [],
    );
  }

  /// `Undo Successful`
  String get undoSuccessful {
    return Intl.message(
      'Undo Successful',
      name: 'undoSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `The selected {total} operations have all been revoked`
  String undoSuccessfulNum(Object total) {
    return Intl.message(
      'The selected $total operations have all been revoked',
      name: 'undoSuccessfulNum',
      desc: '',
      args: [total],
    );
  }

  /// `Undo rename failed`
  String get undoFailed {
    return Intl.message(
      'Undo rename failed',
      name: 'undoFailed',
      desc: '',
      args: [],
    );
  }

  /// `{count} out of {total} selected undo renames failed`
  String undoFailedNum(Object count, Object total) {
    return Intl.message(
      '$count out of $total selected undo renames failed',
      name: 'undoFailedNum',
      desc: '',
      args: [count, total],
    );
  }

  /// `Upload CSV and TXT files with "," separating old and new names, or OPLOG file generated by OncePower`
  String get uploadCSV {
    return Intl.message(
      'Upload CSV and TXT files with "," separating old and new names, or OPLOG file generated by OncePower',
      name: 'uploadCSV',
      desc: '',
      args: [],
    );
  }

  /// `Get episode info`
  String get tvSeriesInfo {
    return Intl.message(
      'Get episode info',
      name: 'tvSeriesInfo',
      desc: '',
      args: [],
    );
  }

  /// `Selected original name column: `
  String get tableInfo {
    return Intl.message(
      'Selected original name column: ',
      name: 'tableInfo',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loadingImage {
    return Intl.message(
      'Loading...',
      name: 'loadingImage',
      desc: '',
      args: [],
    );
  }

  /// `Load Fail `
  String get errorImage {
    return Intl.message(
      'Load Fail ',
      name: 'errorImage',
      desc: '',
      args: [],
    );
  }

  /// `Gets the subfolder of the folder`
  String get addSubfolder {
    return Intl.message(
      'Gets the subfolder of the folder',
      name: 'addSubfolder',
      desc: '',
      args: [],
    );
  }

  /// `Classified file`
  String get classifiedFile {
    return Intl.message(
      'Classified file',
      name: 'classifiedFile',
      desc: '',
      args: [],
    );
  }

  /// `Create parent folders for files based on different types or modification times`
  String get classifiedFileDesc {
    return Intl.message(
      'Create parent folders for files based on different types or modification times',
      name: 'classifiedFileDesc',
      desc: '',
      args: [],
    );
  }

  /// `File parsing error occurred`
  String get decodeCSVError {
    return Intl.message(
      'File parsing error occurred',
      name: 'decodeCSVError',
      desc: '',
      args: [],
    );
  }

  /// `All Extension`
  String get allExtension {
    return Intl.message(
      'All Extension',
      name: 'allExtension',
      desc: '',
      args: [],
    );
  }

  /// `All File Extensions`
  String get detailTitle {
    return Intl.message(
      'All File Extensions',
      name: 'detailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reverse Selection`
  String get selectReserve {
    return Intl.message(
      'Reverse Selection',
      name: 'selectReserve',
      desc: '',
      args: [],
    );
  }

  /// `Select All Switch`
  String get selectAllSwitch {
    return Intl.message(
      'Select All Switch',
      name: 'selectAllSwitch',
      desc: '',
      args: [],
    );
  }

  /// `Exit Operation`
  String get exitOperation {
    return Intl.message(
      'Exit Operation',
      name: 'exitOperation',
      desc: '',
      args: [],
    );
  }

  /// `Removed {count} non image or video files`
  String removeNonImage(Object count) {
    return Intl.message(
      'Removed $count non image or video files',
      name: 'removeNonImage',
      desc: '',
      args: [count],
    );
  }

  /// `Open right-click shortcut menu (When the software is not running, the Windows system only allows one file path to be passed in at a time, so when the software is not running, only one folder path is allowed to be passed in. You can place all files in one folder. If multiple files are passed in at once, please place the shortcut of the software in the "Send To" folder (open File Explorer, enter "shell: sendto" in the address bar and press enter), and use "Send to" to pass in)`
  String get regeditTip {
    return Intl.message(
      'Open right-click shortcut menu (When the software is not running, the Windows system only allows one file path to be passed in at a time, so when the software is not running, only one folder path is allowed to be passed in. You can place all files in one folder. If multiple files are passed in at once, please place the shortcut of the software in the "Send To" folder (open File Explorer, enter "shell: sendto" in the address bar and press enter), and use "Send to" to pass in)',
      name: 'regeditTip',
      desc: '',
      args: [],
    );
  }

  /// `Add all subfiles to`
  String get shortcutTip1 {
    return Intl.message(
      'Add all subfiles to',
      name: 'shortcutTip1',
      desc: '',
      args: [],
    );
  }

  /// `Add to`
  String get shortcutTip2 {
    return Intl.message(
      'Add to',
      name: 'shortcutTip2',
      desc: '',
      args: [],
    );
  }

  /// `Classify using file modification time`
  String get useTimeClassification {
    return Intl.message(
      'Classify using file modification time',
      name: 'useTimeClassification',
      desc: '',
      args: [],
    );
  }

  /// `To the first`
  String get moveToFirst {
    return Intl.message(
      'To the first',
      name: 'moveToFirst',
      desc: '',
      args: [],
    );
  }

  /// `To the center`
  String get moveToCenter {
    return Intl.message(
      'To the center',
      name: 'moveToCenter',
      desc: '',
      args: [],
    );
  }

  /// `To the last`
  String get moveToLast {
    return Intl.message(
      'To the last',
      name: 'moveToLast',
      desc: '',
      args: [],
    );
  }

  /// `Delete checked`
  String get deleteChecked {
    return Intl.message(
      'Delete checked',
      name: 'deleteChecked',
      desc: '',
      args: [],
    );
  }

  /// `Tip`
  String get tipTitle {
    return Intl.message(
      'Tip',
      name: 'tipTitle',
      desc: '',
      args: [],
    );
  }

  /// `This operation will delete the file from the system and cannot be restored. To cancel please click on the area above the popup window.`
  String get tipMessage {
    return Intl.message(
      'This operation will delete the file from the system and cannot be restored. To cancel please click on the area above the popup window.',
      name: 'tipMessage',
      desc: '',
      args: [],
    );
  }

  /// `I know. No more reminders`
  String get tipButton1 {
    return Intl.message(
      'I know. No more reminders',
      name: 'tipButton1',
      desc: '',
      args: [],
    );
  }

  /// `I know`
  String get tipButton2 {
    return Intl.message(
      'I know',
      name: 'tipButton2',
      desc: '',
      args: [],
    );
  }

  /// `Top parent folder`
  String get topParentFolder {
    return Intl.message(
      'Top parent folder',
      name: 'topParentFolder',
      desc: '',
      args: [],
    );
  }

  /// `Case classify`
  String get caseClassify {
    return Intl.message(
      'Case classify',
      name: 'caseClassify',
      desc: '',
      args: [],
    );
  }

  /// `Case extension`
  String get caseExtension {
    return Intl.message(
      'Case extension',
      name: 'caseExtension',
      desc: '',
      args: [],
    );
  }

  /// `DefaultSort`
  String get defaultSort {
    return Intl.message(
      'DefaultSort',
      name: 'defaultSort',
      desc: '',
      args: [],
    );
  }

  /// `NameDescending`
  String get nameDescending {
    return Intl.message(
      'NameDescending',
      name: 'nameDescending',
      desc: '',
      args: [],
    );
  }

  /// `NameAscending`
  String get nameAscending {
    return Intl.message(
      'NameAscending',
      name: 'nameAscending',
      desc: '',
      args: [],
    );
  }

  /// `DateDescending`
  String get dateDescending {
    return Intl.message(
      'DateDescending',
      name: 'dateDescending',
      desc: '',
      args: [],
    );
  }

  /// `DateAscending`
  String get dateAscending {
    return Intl.message(
      'DateAscending',
      name: 'dateAscending',
      desc: '',
      args: [],
    );
  }

  /// `TypeDescending`
  String get typeDescending {
    return Intl.message(
      'TypeDescending',
      name: 'typeDescending',
      desc: '',
      args: [],
    );
  }

  /// `TypeAscending`
  String get typeAscending {
    return Intl.message(
      'TypeAscending',
      name: 'typeAscending',
      desc: '',
      args: [],
    );
  }

  /// `CheckDescending`
  String get checkDescending {
    return Intl.message(
      'CheckDescending',
      name: 'checkDescending',
      desc: '',
      args: [],
    );
  }

  /// `CheckAscending`
  String get checkAscending {
    return Intl.message(
      'CheckAscending',
      name: 'checkAscending',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

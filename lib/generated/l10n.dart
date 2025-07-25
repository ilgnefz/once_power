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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Replace`
  String get replace {
    return Intl.message('Replace', name: 'replace', desc: '', args: []);
  }

  /// `Reserve`
  String get reserve {
    return Intl.message('Reserve', name: 'reserve', desc: '', args: []);
  }

  /// `Organize`
  String get organize {
    return Intl.message('Organize', name: 'organize', desc: '', args: []);
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
    return Intl.message('Matching', name: 'match', desc: '', args: []);
  }

  /// `Before`
  String get before {
    return Intl.message('Before', name: 'before', desc: '', args: []);
  }

  /// `After`
  String get after {
    return Intl.message('After', name: 'after', desc: '', args: []);
  }

  /// `Between`
  String get between {
    return Intl.message('Between', name: 'between', desc: '', args: []);
  }

  /// `Modify to`
  String get modifyTo {
    return Intl.message('Modify to', name: 'modifyTo', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Created`
  String get createdDate {
    return Intl.message('Created', name: 'createdDate', desc: '', args: []);
  }

  /// `Modified`
  String get modifiedDate {
    return Intl.message('Modified', name: 'modifiedDate', desc: '', args: []);
  }

  /// `Exif Date`
  String get exifDate {
    return Intl.message('Exif Date', name: 'exifDate', desc: '', args: []);
  }

  /// `Earliest`
  String get earliestDate {
    return Intl.message('Earliest', name: 'earliestDate', desc: '', args: []);
  }

  /// `Latest`
  String get latestDate {
    return Intl.message('Latest', name: 'latestDate', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Prefix`
  String get prefix {
    return Intl.message('Prefix', name: 'prefix', desc: '', args: []);
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
    return Intl.message('Suffix', name: 'suffix', desc: '', args: []);
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
    return Intl.message('Serial', name: 'serial', desc: '', args: []);
  }

  /// `digits`
  String get digits {
    return Intl.message('digits', name: 'digits', desc: '', args: []);
  }

  /// `start`
  String get start {
    return Intl.message('start', name: 'start', desc: '', args: []);
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
    return Intl.message('Append', name: 'appendMode', desc: '', args: []);
  }

  /// `Add file`
  String get addFile {
    return Intl.message('Add file', name: 'addFile', desc: '', args: []);
  }

  /// `Add folder`
  String get addFolder {
    return Intl.message('Add folder', name: 'addFolder', desc: '', args: []);
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
    return Intl.message('Apply', name: 'applyChange', desc: '', args: []);
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
    return Intl.message('Case sensitive', name: 'caseDesc', desc: '', args: []);
  }

  /// `Named by date`
  String get dateDesc {
    return Intl.message('Named by date', name: 'dateDesc', desc: '', args: []);
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
    return Intl.message('Rename name', name: 'renameName', desc: '', args: []);
  }

  /// `New name`
  String get newName {
    return Intl.message('New name', name: 'newName', desc: '', args: []);
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

  /// `Remove unchecked`
  String get removeUnselected {
    return Intl.message(
      'Remove unchecked',
      name: 'removeUnselected',
      desc: '',
      args: [],
    );
  }

  /// `Remove checked`
  String get removeSelected {
    return Intl.message(
      'Remove checked',
      name: 'removeSelected',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message('Image', name: 'image', desc: '', args: []);
  }

  /// `Video`
  String get video {
    return Intl.message('Video', name: 'video', desc: '', args: []);
  }

  /// `Document`
  String get document {
    return Intl.message('Document', name: 'document', desc: '', args: []);
  }

  /// `Audio`
  String get audio {
    return Intl.message('Audio', name: 'audio', desc: '', args: []);
  }

  /// `Folder`
  String get folder {
    return Intl.message('Folder', name: 'folder', desc: '', args: []);
  }

  /// `Zip`
  String get zip {
    return Intl.message('Zip', name: 'zip', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `Text`
  String get text {
    return Intl.message('Text', name: 'text', desc: '', args: []);
  }

  /// `File name`
  String get fileName {
    return Intl.message('File name', name: 'fileName', desc: '', args: []);
  }

  /// `Extension`
  String get extension {
    return Intl.message('Extension', name: 'extension', desc: '', args: []);
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

  /// `Files will be deleted to the Recycle Bin`
  String get deleteFileDesc {
    return Intl.message(
      'Files will be deleted to the Recycle Bin',
      name: 'deleteFileDesc',
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

  /// `Move`
  String get organizeBtn {
    return Intl.message('Move', name: 'organizeBtn', desc: '', args: []);
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

  /// `Task`
  String get currentTask {
    return Intl.message('Task', name: 'currentTask', desc: '', args: []);
  }

  /// `Time`
  String get takeTime {
    return Intl.message('Time', name: 'takeTime', desc: '', args: []);
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
    return Intl.message('Checking', name: 'checking', desc: '', args: []);
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

  /// `Upload. txt files separated by spaces or line breaks for each name`
  String get uploadDesc {
    return Intl.message(
      'Upload. txt files separated by spaces or line breaks for each name',
      name: 'uploadDesc',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message('Download', name: 'download', desc: '', args: []);
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
    return Intl.message('Renaming failed', name: 'failed', desc: '', args: []);
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
    return Intl.message('delete logs', name: 'deleteLog', desc: '', args: []);
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

  /// `Successfully deleted all empty folders under the selected folder`
  String get successEmptyInfo {
    return Intl.message(
      'Successfully deleted all empty folders under the selected folder',
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
    return Intl.message('not exist', name: 'notExist', desc: '', args: []);
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
    return Intl.message('rename logs', name: 'renameLogs', desc: '', args: []);
  }

  /// `Move failed`
  String get moveFailed {
    return Intl.message('Move failed', name: 'moveFailed', desc: '', args: []);
  }

  /// `Moving error`
  String get moveError {
    return Intl.message('Moving error', name: 'moveError', desc: '', args: []);
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
    return Intl.message('View mode', name: 'viewMode', desc: '', args: []);
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

  /// `Check`
  String get select {
    return Intl.message('Check', name: 'select', desc: '', args: []);
  }

  /// `Uncheck`
  String get unselect {
    return Intl.message('Uncheck', name: 'unselect', desc: '', args: []);
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `Match name`
  String get matchName {
    return Intl.message('Match name', name: 'matchName', desc: '', args: []);
  }

  /// `Modify name`
  String get modifyName {
    return Intl.message('Modify name', name: 'modifyName', desc: '', args: []);
  }

  /// `Undo`
  String get undo {
    return Intl.message('Undo', name: 'undo', desc: '', args: []);
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

  /// `Original name column: `
  String get tableInfo {
    return Intl.message(
      'Original name column: ',
      name: 'tableInfo',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `Loading...`
  String get loadingImage {
    return Intl.message('Loading...', name: 'loadingImage', desc: '', args: []);
  }

  /// `Load Fail `
  String get errorImage {
    return Intl.message('Load Fail ', name: 'errorImage', desc: '', args: []);
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

  /// `File parsing error occurred`
  String get decodeCSVError {
    return Intl.message(
      'File parsing error occurred',
      name: 'decodeCSVError',
      desc: '',
      args: [],
    );
  }

  /// `Not a compliant CSV file`
  String get decodeCSVError2 {
    return Intl.message(
      'Not a compliant CSV file',
      name: 'decodeCSVError2',
      desc: '',
      args: [],
    );
  }

  /// `All extension`
  String get allExtension {
    return Intl.message(
      'All extension',
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

  /// `Invert selection`
  String get selectReserve {
    return Intl.message(
      'Invert selection',
      name: 'selectReserve',
      desc: '',
      args: [],
    );
  }

  /// `All switch`
  String get selectAllSwitch {
    return Intl.message(
      'All switch',
      name: 'selectAllSwitch',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exitOperation {
    return Intl.message('Exit', name: 'exitOperation', desc: '', args: []);
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
    return Intl.message('Add to', name: 'shortcutTip2', desc: '', args: []);
  }

  /// `Date category`
  String get dateClassification {
    return Intl.message(
      'Date category',
      name: 'dateClassification',
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
    return Intl.message('To the last', name: 'moveToLast', desc: '', args: []);
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

  /// `Select folder`
  String get selectPath {
    return Intl.message(
      'Select folder',
      name: 'selectPath',
      desc: '',
      args: [],
    );
  }

  /// `Select group`
  String get selectGroup {
    return Intl.message(
      'Select group',
      name: 'selectGroup',
      desc: '',
      args: [],
    );
  }

  /// `Top folder`
  String get topParentFolder {
    return Intl.message(
      'Top folder',
      name: 'topParentFolder',
      desc: '',
      args: [],
    );
  }

  /// `Case type`
  String get caseFile {
    return Intl.message('Case type', name: 'caseFile', desc: '', args: []);
  }

  /// `Case ext.`
  String get caseExtension {
    return Intl.message('Case ext.', name: 'caseExtension', desc: '', args: []);
  }

  /// `Default sort`
  String get defaultSort {
    return Intl.message(
      'Default sort',
      name: 'defaultSort',
      desc: '',
      args: [],
    );
  }

  /// `Name descending`
  String get nameDescending {
    return Intl.message(
      'Name descending',
      name: 'nameDescending',
      desc: '',
      args: [],
    );
  }

  /// `Name ascending`
  String get nameAscending {
    return Intl.message(
      'Name ascending',
      name: 'nameAscending',
      desc: '',
      args: [],
    );
  }

  /// `Date descending`
  String get dateDescending {
    return Intl.message(
      'Date descending',
      name: 'dateDescending',
      desc: '',
      args: [],
    );
  }

  /// `Date ascending`
  String get dateAscending {
    return Intl.message(
      'Date ascending',
      name: 'dateAscending',
      desc: '',
      args: [],
    );
  }

  /// `Type descending`
  String get typeDescending {
    return Intl.message(
      'Type descending',
      name: 'typeDescending',
      desc: '',
      args: [],
    );
  }

  /// `Type ascending`
  String get typeAscending {
    return Intl.message(
      'Type ascending',
      name: 'typeAscending',
      desc: '',
      args: [],
    );
  }

  /// `Check descending`
  String get checkDescending {
    return Intl.message(
      'Check descending',
      name: 'checkDescending',
      desc: '',
      args: [],
    );
  }

  /// `Check ascending`
  String get checkAscending {
    return Intl.message(
      'Check ascending',
      name: 'checkAscending',
      desc: '',
      args: [],
    );
  }

  /// `Folder descending`
  String get folderDescending {
    return Intl.message(
      'Folder descending',
      name: 'folderDescending',
      desc: '',
      args: [],
    );
  }

  /// `Folder ascending`
  String get folderAscending {
    return Intl.message(
      'Folder ascending',
      name: 'folderAscending',
      desc: '',
      args: [],
    );
  }

  /// `Run OncePower when the computer starts up`
  String get autoRun {
    return Intl.message(
      'Run OncePower when the computer starts up',
      name: 'autoRun',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Operation`
  String get cancelOperation {
    return Intl.message(
      'Cancel Operation',
      name: 'cancelOperation',
      desc: '',
      args: [],
    );
  }

  /// `Show Window`
  String get showWindow {
    return Intl.message('Show Window', name: 'showWindow', desc: '', args: []);
  }

  /// `Exit App`
  String get exitApp {
    return Intl.message('Exit App', name: 'exitApp', desc: '', args: []);
  }

  /// `Advance`
  String get advance {
    return Intl.message('Advance', name: 'advance', desc: '', args: []);
  }

  /// `AdvanceMenu`
  String get advanceMenu {
    return Intl.message('AdvanceMenu', name: 'advanceMenu', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Preset`
  String get preset {
    return Intl.message('Preset', name: 'preset', desc: '', args: []);
  }

  /// `Add Preset`
  String get addPreset {
    return Intl.message('Add Preset', name: 'addPreset', desc: '', args: []);
  }

  /// `First`
  String get first {
    return Intl.message('First', name: 'first', desc: '', args: []);
  }

  /// `Last`
  String get last {
    return Intl.message('Last', name: 'last', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Before`
  String get addBefore {
    return Intl.message('Before', name: 'addBefore', desc: '', args: []);
  }

  /// `After`
  String get addAfter {
    return Intl.message('After', name: 'addAfter', desc: '', args: []);
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Delete Content`
  String get deleteTitle {
    return Intl.message(
      'Delete Content',
      name: 'deleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add Content`
  String get addTitle {
    return Intl.message('Add Content', name: 'addTitle', desc: '', args: []);
  }

  /// `Replace Content`
  String get replaceTitle {
    return Intl.message(
      'Replace Content',
      name: 'replaceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Match Position`
  String get matchPosition {
    return Intl.message(
      'Match Position',
      name: 'matchPosition',
      desc: '',
      args: [],
    );
  }

  /// `Add Type`
  String get addType {
    return Intl.message('Add Type', name: 'addType', desc: '', args: []);
  }

  /// `Add Position`
  String get addPosition {
    return Intl.message(
      'Add Position',
      name: 'addPosition',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the added content`
  String get addInputHint {
    return Intl.message(
      'Please enter the added content',
      name: 'addInputHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the deleted content`
  String get deleteInputHint {
    return Intl.message(
      'Please enter the deleted content',
      name: 'deleteInputHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the matching content`
  String get replaceInputHint {
    return Intl.message(
      'Please enter the matching content',
      name: 'replaceInputHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the replacement content`
  String get replaceInputHint2 {
    return Intl.message(
      'Please enter the replacement content',
      name: 'replaceInputHint2',
      desc: '',
      args: [],
    );
  }

  /// `with`
  String get withT {
    return Intl.message('with', name: 'withT', desc: '', args: []);
  }

  /// `to`
  String get to {
    return Intl.message('to', name: 'to', desc: '', args: []);
  }

  /// `Start`
  String get startSequence {
    return Intl.message('Start', name: 'startSequence', desc: '', args: []);
  }

  /// `Preset Name`
  String get presetName {
    return Intl.message('Preset Name', name: 'presetName', desc: '', args: []);
  }

  /// `Please enter the preset name`
  String get presetNameHint {
    return Intl.message(
      'Please enter the preset name',
      name: 'presetNameHint',
      desc: '',
      args: [],
    );
  }

  /// `The preset name cannot be empty`
  String get presetNameError {
    return Intl.message(
      'The preset name cannot be empty',
      name: 'presetNameError',
      desc: '',
      args: [],
    );
  }

  /// `Preset name error`
  String get presetNameErrorTitle {
    return Intl.message(
      'Preset name error',
      name: 'presetNameErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Convert Text`
  String get convertLetters {
    return Intl.message(
      'Convert Text',
      name: 'convertLetters',
      desc: '',
      args: [],
    );
  }

  /// `Uppercase`
  String get uppercase {
    return Intl.message('Uppercase', name: 'uppercase', desc: '', args: []);
  }

  /// `Lowercase`
  String get lowercase {
    return Intl.message('Lowercase', name: 'lowercase', desc: '', args: []);
  }

  /// `Toggle`
  String get toggleCase {
    return Intl.message('Toggle', name: 'toggleCase', desc: '', args: []);
  }

  /// `No`
  String get noConversion {
    return Intl.message('No', name: 'noConversion', desc: '', args: []);
  }

  /// `Text with`
  String get letters {
    return Intl.message('Text with', name: 'letters', desc: '', args: []);
  }

  /// `No instructions have been added yet`
  String get advanceEmpty1 {
    return Intl.message(
      'No instructions have been added yet',
      name: 'advanceEmpty1',
      desc: '',
      args: [],
    );
  }

  /// `Click the`
  String get advanceEmpty2 {
    return Intl.message('Click the', name: 'advanceEmpty2', desc: '', args: []);
  }

  /// `"Delete", "Add", or "Replace"`
  String get advanceEmpty3 {
    return Intl.message(
      '"Delete", "Add", or "Replace"',
      name: 'advanceEmpty3',
      desc: '',
      args: [],
    );
  }

  /// `buttons to add them`
  String get advanceEmpty4 {
    return Intl.message(
      'buttons to add them',
      name: 'advanceEmpty4',
      desc: '',
      args: [],
    );
  }

  /// `Total {count}`
  String totalInstructions(Object count) {
    return Intl.message(
      'Total $count',
      name: 'totalInstructions',
      desc: '',
      args: [count],
    );
  }

  /// `Replace Mode`
  String get replaceMode {
    return Intl.message(
      'Replace Mode',
      name: 'replaceMode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the length of the name`
  String get formatDigit {
    return Intl.message(
      'Please enter the length of the name',
      name: 'formatDigit',
      desc: '',
      args: [],
    );
  }

  /// `Please input the completed content`
  String get completeContent {
    return Intl.message(
      'Please input the completed content',
      name: 'completeContent',
      desc: '',
      args: [],
    );
  }

  /// `Normal`
  String get normal {
    return Intl.message('Normal', name: 'normal', desc: '', args: []);
  }

  /// `Format`
  String get format {
    return Intl.message('Format', name: 'format', desc: '', args: []);
  }

  /// `Length`
  String get formatDesc1 {
    return Intl.message('Length', name: 'formatDesc1', desc: '', args: []);
  }

  /// `filled with`
  String get formatDesc2 {
    return Intl.message('filled with', name: 'formatDesc2', desc: '', args: []);
  }

  /// ``
  String get formatDesc3 {
    return Intl.message('', name: 'formatDesc3', desc: '', args: []);
  }

  /// `Delete Type`
  String get deleteType {
    return Intl.message('Delete Type', name: 'deleteType', desc: '', args: []);
  }

  /// `CapitalLetter`
  String get capitalLetter {
    return Intl.message(
      'CapitalLetter',
      name: 'capitalLetter',
      desc: '',
      args: [],
    );
  }

  /// `LowercaseLetters`
  String get lowercaseLetters {
    return Intl.message(
      'LowercaseLetters',
      name: 'lowercaseLetters',
      desc: '',
      args: [],
    );
  }

  /// `NonLetter`
  String get nonLetter {
    return Intl.message('NonLetter', name: 'nonLetter', desc: '', args: []);
  }

  /// `Digit`
  String get digit {
    return Intl.message('Digit', name: 'digit', desc: '', args: []);
  }

  /// `Punctuation`
  String get punctuation {
    return Intl.message('Punctuation', name: 'punctuation', desc: '', args: []);
  }

  /// `Space`
  String get space {
    return Intl.message('Space', name: 'space', desc: '', args: []);
  }

  /// `, `
  String get delimiter {
    return Intl.message(', ', name: 'delimiter', desc: '', args: []);
  }

  /// `Position`
  String get position {
    return Intl.message('Position', name: 'position', desc: '', args: []);
  }

  /// `end`
  String get end {
    return Intl.message('end', name: 'end', desc: '', args: []);
  }

  /// `FolderName`
  String get parentsName {
    return Intl.message('FolderName', name: 'parentsName', desc: '', args: []);
  }

  /// `Disable`
  String get disable {
    return Intl.message('Disable', name: 'disable', desc: '', args: []);
  }

  /// `Serial Classify`
  String get serialDistinguish {
    return Intl.message(
      'Serial Classify',
      name: 'serialDistinguish',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get fileType {
    return Intl.message('Type', name: 'fileType', desc: '', args: []);
  }

  /// `distinguish`
  String get distinguish {
    return Intl.message('distinguish', name: 'distinguish', desc: '', args: []);
  }

  /// `All folder`
  String get allFolder {
    return Intl.message('All folder', name: 'allFolder', desc: '', args: []);
  }

  /// `All folder path`
  String get allFolderTitle {
    return Intl.message(
      'All folder path',
      name: 'allFolderTitle',
      desc: '',
      args: [],
    );
  }

  /// `place`
  String get place {
    return Intl.message('place', name: 'place', desc: '', args: []);
  }

  /// ``
  String get di {
    return Intl.message('', name: 'di', desc: '', args: []);
  }

  /// `Fill front`
  String get fillFront {
    return Intl.message('Fill front', name: 'fillFront', desc: '', args: []);
  }

  /// `Fill back`
  String get fillBack {
    return Intl.message('Fill back', name: 'fillBack', desc: '', args: []);
  }

  /// `Random`
  String get random {
    return Intl.message('Random', name: 'random', desc: '', args: []);
  }

  /// `Please enter custom content`
  String get randomInputHint {
    return Intl.message(
      'Please enter custom content',
      name: 'randomInputHint',
      desc: '',
      args: [],
    );
  }

  /// `Match ext.`
  String get matchExtension {
    return Intl.message(
      'Match ext.',
      name: 'matchExtension',
      desc: '',
      args: [],
    );
  }

  /// `Delete Ext.`
  String get deleteExtension {
    return Intl.message(
      'Delete Ext.',
      name: 'deleteExtension',
      desc: '',
      args: [],
    );
  }

  /// `Set type folder`
  String get classifyType {
    return Intl.message(
      'Set type folder',
      name: 'classifyType',
      desc: '',
      args: [],
    );
  }

  /// `Set group folder`
  String get groupType {
    return Intl.message(
      'Set group folder',
      name: 'groupType',
      desc: '',
      args: [],
    );
  }

  /// `Type category`
  String get useRule {
    return Intl.message('Type category', name: 'useRule', desc: '', args: []);
  }

  /// `Group category`
  String get useGroup {
    return Intl.message('Group category', name: 'useGroup', desc: '', args: []);
  }

  /// `The type folder is empty!`
  String get classifyFolderError {
    return Intl.message(
      'The type folder is empty!',
      name: 'classifyFolderError',
      desc: '',
      args: [],
    );
  }

  /// `The group folder is empty!`
  String get groupFolderError {
    return Intl.message(
      'The group folder is empty!',
      name: 'groupFolderError',
      desc: '',
      args: [],
    );
  }

  /// `Open position`
  String get openPosition {
    return Intl.message(
      'Open position',
      name: 'openPosition',
      desc: '',
      args: [],
    );
  }

  /// `Open failed`
  String get openError {
    return Intl.message('Open failed', name: 'openError', desc: '', args: []);
  }

  /// `The target folder is empty!`
  String get targetFolderError {
    return Intl.message(
      'The target folder is empty!',
      name: 'targetFolderError',
      desc: '',
      args: [],
    );
  }

  /// `Move files of different types to different folders`
  String get useRuleDesc {
    return Intl.message(
      'Move files of different types to different folders',
      name: 'useRuleDesc',
      desc: '',
      args: [],
    );
  }

  /// `Create a folder named after the date of file creation in the target folder and move it to that folder`
  String get dateClassificationDesc {
    return Intl.message(
      'Create a folder named after the date of file creation in the target folder and move it to that folder',
      name: 'dateClassificationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Move the file to a top-level parent folder other than the disk root directory`
  String get topParentFolderDesc {
    return Intl.message(
      'Move the file to a top-level parent folder other than the disk root directory',
      name: 'topParentFolderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Remove folder`
  String get removeFolder {
    return Intl.message(
      'Remove folder',
      name: 'removeFolder',
      desc: '',
      args: [],
    );
  }

  /// `The target location has been changed or deleted`
  String get notExistError {
    return Intl.message(
      'The target location has been changed or deleted',
      name: 'notExistError',
      desc: '',
      args: [],
    );
  }

  /// `Fail to read file`
  String get emptyFolderErrorTitle {
    return Intl.message(
      'Fail to read file',
      name: 'emptyFolderErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `The selected folder is empty`
  String get emptyFolderError {
    return Intl.message(
      'The selected folder is empty',
      name: 'emptyFolderError',
      desc: '',
      args: [],
    );
  }

  /// `Match folder`
  String get matchParent {
    return Intl.message(
      'Match folder',
      name: 'matchParent',
      desc: '',
      args: [],
    );
  }

  /// `Resolution`
  String get resolution {
    return Intl.message('Resolution', name: 'resolution', desc: '', args: []);
  }

  /// `Size`
  String get size {
    return Intl.message('Size', name: 'size', desc: '', args: []);
  }

  /// `ResolutionWidth`
  String get width {
    return Intl.message('ResolutionWidth', name: 'width', desc: '', args: []);
  }

  /// `ResolutionHeight`
  String get height {
    return Intl.message('ResolutionHeight', name: 'height', desc: '', args: []);
  }

  /// `Word Spacing`
  String get wordSpacing {
    return Intl.message(
      'Word Spacing',
      name: 'wordSpacing',
      desc: '',
      args: [],
    );
  }

  /// `Separate words starting with capital letters`
  String get wordSpacingHint {
    return Intl.message(
      'Separate words starting with capital letters',
      name: 'wordSpacingHint',
      desc: '',
      args: [],
    );
  }

  /// `Separate Words`
  String get separate {
    return Intl.message('Separate Words', name: 'separate', desc: '', args: []);
  }

  /// `Front`
  String get front {
    return Intl.message('Front', name: 'front', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Front`
  String get frontLabel {
    return Intl.message('Front', name: 'frontLabel', desc: '', args: []);
  }

  /// `Back`
  String get backLabel {
    return Intl.message('Back', name: 'backLabel', desc: '', args: []);
  }

  /// `Setting group`
  String get settingGroup {
    return Intl.message(
      'Setting group',
      name: 'settingGroup',
      desc: '',
      args: [],
    );
  }

  /// `Edit group`
  String get editGroup {
    return Intl.message('Edit group', name: 'editGroup', desc: '', args: []);
  }

  /// `Group`
  String get group {
    return Intl.message('Group', name: 'group', desc: '', args: []);
  }

  /// `Apply Group`
  String get applyGroup {
    return Intl.message('Apply Group', name: 'applyGroup', desc: '', args: []);
  }

  /// `Add preset failed`
  String get presetAddErrorTitle {
    return Intl.message(
      'Add preset failed',
      name: 'presetAddErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `The instruction list cannot be empty!`
  String get presetAddError {
    return Intl.message(
      'The instruction list cannot be empty!',
      name: 'presetAddError',
      desc: '',
      args: [],
    );
  }

  /// `Size ascending`
  String get sizeAscending {
    return Intl.message(
      'Size ascending',
      name: 'sizeAscending',
      desc: '',
      args: [],
    );
  }

  /// `Size descending`
  String get sizeDescending {
    return Intl.message(
      'Size descending',
      name: 'sizeDescending',
      desc: '',
      args: [],
    );
  }

  /// `Group ascending`
  String get groupAscending {
    return Intl.message(
      'Group ascending',
      name: 'groupAscending',
      desc: '',
      args: [],
    );
  }

  /// `Group descending`
  String get groupDescending {
    return Intl.message(
      'Group descending',
      name: 'groupDescending',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message('None', name: 'none', desc: '', args: []);
  }

  /// `Move`
  String get move {
    return Intl.message('Move', name: 'move', desc: '', args: []);
  }

  /// `Suspense file`
  String get suspenseFile {
    return Intl.message(
      'Suspense file',
      name: 'suspenseFile',
      desc: '',
      args: [],
    );
  }

  /// `Take out`
  String get takeOut {
    return Intl.message('Take out', name: 'takeOut', desc: '', args: []);
  }

  /// `To the front`
  String get toFront {
    return Intl.message('To the front', name: 'toFront', desc: '', args: []);
  }

  /// `To the behind`
  String get toBehind {
    return Intl.message('To the behind', name: 'toBehind', desc: '', args: []);
  }

  /// `Use Regex`
  String get regexDesc {
    return Intl.message('Use Regex', name: 'regexDesc', desc: '', args: []);
  }

  /// `Match extension`
  String get matchExtDesc {
    return Intl.message(
      'Match extension',
      name: 'matchExtDesc',
      desc: '',
      args: [],
    );
  }

  /// `TraditionalCN`
  String get traditional {
    return Intl.message(
      'TraditionalCN',
      name: 'traditional',
      desc: '',
      args: [],
    );
  }

  /// `SimplifiedCN`
  String get simplified {
    return Intl.message('SimplifiedCN', name: 'simplified', desc: '', args: []);
  }

  /// `Shortcut key`
  String get shortcutKey {
    return Intl.message(
      'Shortcut key',
      name: 'shortcutKey',
      desc: '',
      args: [],
    );
  }

  /// `Selected all`
  String get selectedAll {
    return Intl.message(
      'Selected all',
      name: 'selectedAll',
      desc: '',
      args: [],
    );
  }

  /// `Toggle selected state`
  String get toggleSelected {
    return Intl.message(
      'Toggle selected state',
      name: 'toggleSelected',
      desc: '',
      args: [],
    );
  }

  /// `Take it out to the front`
  String get takeOutFront {
    return Intl.message(
      'Take it out to the front',
      name: 'takeOutFront',
      desc: '',
      args: [],
    );
  }

  /// `Take it out to the back`
  String get takeOutBehind {
    return Intl.message(
      'Take it out to the back',
      name: 'takeOutBehind',
      desc: '',
      args: [],
    );
  }

  /// `Suspense file failed`
  String get suspenseError {
    return Intl.message(
      'Suspense file failed',
      name: 'suspenseError',
      desc: '',
      args: [],
    );
  }

  /// `No bulk suspense of all files`
  String get suspenseErrorDesc {
    return Intl.message(
      'No bulk suspense of all files',
      name: 'suspenseErrorDesc',
      desc: '',
      args: [],
    );
  }

  /// `Light theme`
  String get lightTheme {
    return Intl.message('Light theme', name: 'lightTheme', desc: '', args: []);
  }

  /// `Dark theme`
  String get darkTheme {
    return Intl.message('Dark theme', name: 'darkTheme', desc: '', args: []);
  }

  /// `System`
  String get system {
    return Intl.message('System', name: 'system', desc: '', args: []);
  }

  /// `Custom image size`
  String get customImageSize {
    return Intl.message(
      'Custom image size',
      name: 'customImageSize',
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

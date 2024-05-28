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

  /// `New name`
  String get renamedName {
    return Intl.message(
      'New name',
      name: 'renamedName',
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

  /// `DeleteUnselected`
  String get deleted {
    return Intl.message(
      'DeleteUnselected',
      name: 'deleted',
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

  /// `Text`
  String get text {
    return Intl.message(
      'Text',
      name: 'text',
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

  /// `Save log`
  String get saveLog {
    return Intl.message(
      'Save log',
      name: 'saveLog',
      desc: '',
      args: [],
    );
  }

  /// `Select target folder`
  String get selectTargetFolder {
    return Intl.message(
      'Select target folder',
      name: 'selectTargetFolder',
      desc: '',
      args: [],
    );
  }

  /// `Delete folder`
  String get deleteEmptyFolder {
    return Intl.message(
      'Delete folder',
      name: 'deleteEmptyFolder',
      desc: '',
      args: [],
    );
  }

  /// `Organize folder`
  String get organizeFolder {
    return Intl.message(
      'Organize folder',
      name: 'organizeFolder',
      desc: '',
      args: [],
    );
  }

  /// `Enable file organization`
  String get organizeDesc {
    return Intl.message(
      'Enable file organization',
      name: 'organizeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Saved Configurations Enabled`
  String get enableSaveConfig {
    return Intl.message(
      'Saved Configurations Enabled',
      name: 'enableSaveConfig',
      desc: '',
      args: [],
    );
  }

  /// `Saved configurations not enabled`
  String get closeSaveConfig {
    return Intl.message(
      'Saved configurations not enabled',
      name: 'closeSaveConfig',
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

  /// `Defaults to the parent folder of the first file added to the list or the folder itself`
  String get targetFolderDesc {
    return Intl.message(
      'Defaults to the parent folder of the first file added to the list or the folder itself',
      name: 'targetFolderDesc',
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

  /// `Saved logs will be in the target folder`
  String get logDesc {
    return Intl.message(
      'Saved logs will be in the target folder',
      name: 'logDesc',
      desc: '',
      args: [],
    );
  }

  /// `Delete all empty folders under the added folder`
  String get deleteEmptyFolderDesc {
    return Intl.message(
      'Delete all empty folders under the added folder',
      name: 'deleteEmptyFolderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Move all added files or all sub-files under a folder into the destination folder`
  String get organizeFolderDesc {
    return Intl.message(
      'Move all added files or all sub-files under a folder into the destination folder',
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

  /// `Double-click on the list of files on the right to quickly open the folder where the file is located`
  String get openFolderDesc {
    return Intl.message(
      'Double-click on the list of files on the right to quickly open the folder where the file is located',
      name: 'openFolderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Drag the file (folder) here`
  String get tip {
    return Intl.message(
      'Drag the file (folder) here',
      name: 'tip',
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

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
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
  String get successInfo {
    return Intl.message(
      'Successfully deleted all empty folders',
      name: 'successInfo',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete empty folder`
  String get failureInfo {
    return Intl.message(
      'Failed to delete empty folder',
      name: 'failureInfo',
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

  /// `Successfully moved all files`
  String get organizedSuccessfullyInfo {
    return Intl.message(
      'Successfully moved all files',
      name: 'organizedSuccessfullyInfo',
      desc: '',
      args: [],
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

  /// `Image view mode`
  String get imageViewMode {
    return Intl.message(
      'Image view mode',
      name: 'imageViewMode',
      desc: '',
      args: [],
    );
  }

  /// `{total} files {count} selected`
  String fileCount(Object total, Object count) {
    return Intl.message(
      '$total files $count selected',
      name: 'fileCount',
      desc: '',
      args: [total, count],
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

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
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

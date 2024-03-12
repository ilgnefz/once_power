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
  String get inputHint {
    return Intl.message(
      'Matching content',
      name: 'inputHint',
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
  String get inputLength {
    return Intl.message(
      'Number or length string',
      name: 'inputLength',
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
  String get middle {
    return Intl.message(
      'Between',
      name: 'middle',
      desc: '',
      args: [],
    );
  }

  /// `Modify to`
  String get modify {
    return Intl.message(
      'Modify to',
      name: 'modify',
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

  /// `Create Date`
  String get createDate {
    return Intl.message(
      'Create Date',
      name: 'createDate',
      desc: '',
      args: [],
    );
  }

  /// `Modify Date`
  String get modifyDate {
    return Intl.message(
      'Modify Date',
      name: 'modifyDate',
      desc: '',
      args: [],
    );
  }

  /// `Exif Date`
  String get exifDate {
    return Intl.message(
      'Exif Date',
      name: 'exifDate',
      desc: '',
      args: [],
    );
  }

  /// `Earliest date`
  String get earliestDate {
    return Intl.message(
      'Earliest date',
      name: 'earliestDate',
      desc: '',
      args: [],
    );
  }

  /// `Latest date`
  String get latestDate {
    return Intl.message(
      'Latest date',
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

  /// `Increment`
  String get increment {
    return Intl.message(
      'Increment',
      name: 'increment',
      desc: '',
      args: [],
    );
  }

  /// `Digits`
  String get digits {
    return Intl.message(
      'Digits',
      name: 'digits',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `File extension`
  String get fileExtension {
    return Intl.message(
      'File extension',
      name: 'fileExtension',
      desc: '',
      args: [],
    );
  }

  /// `Append mode`
  String get appendMode {
    return Intl.message(
      'Append mode',
      name: 'appendMode',
      desc: '',
      args: [],
    );
  }

  /// `Add folders`
  String get addFolders {
    return Intl.message(
      'Add folders',
      name: 'addFolders',
      desc: '',
      args: [],
    );
  }

  /// `Select File`
  String get selectFile {
    return Intl.message(
      'Select File',
      name: 'selectFile',
      desc: '',
      args: [],
    );
  }

  /// `Select Folder`
  String get selectFolder {
    return Intl.message(
      'Select Folder',
      name: 'selectFolder',
      desc: '',
      args: [],
    );
  }

  /// `Apply Change`
  String get applyChange {
    return Intl.message(
      'Apply Change',
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

  /// `Modifying file extensions`
  String get extensionDesc {
    return Intl.message(
      'Modifying file extensions',
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

  /// `Delete unselected`
  String get deleted {
    return Intl.message(
      'Delete unselected',
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

  /// `Extension`
  String get extension {
    return Intl.message(
      'Extension',
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

  /// `Delete empty folder`
  String get deleteEmptyFolder {
    return Intl.message(
      'Delete empty folder',
      name: 'deleteEmptyFolder',
      desc: '',
      args: [],
    );
  }

  /// `Organize Folder`
  String get organizeFolder {
    return Intl.message(
      'Organize Folder',
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

  /// `Current task`
  String get currentTask {
    return Intl.message(
      'Current task',
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

  /// `Checking for updates`
  String get checkingUpdates {
    return Intl.message(
      'Checking for updates',
      name: 'checkingUpdates',
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

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

  /// `Match Text`
  String get matchText {
    return Intl.message(
      'Match Text',
      name: 'matchText',
      desc: '',
      args: [],
    );
  }

  /// `Enter a random length string Or *Num`
  String get lengthMatchText {
    return Intl.message(
      'Enter a random length string Or *Num',
      name: 'lengthMatchText',
      desc: '',
      args: [],
    );
  }

  /// `Case Sensitive`
  String get caseSensitive {
    return Intl.message(
      'Case Sensitive',
      name: 'caseSensitive',
      desc: '',
      args: [],
    );
  }

  /// `Default Mode`
  String get defaultMode {
    return Intl.message(
      'Default Mode',
      name: 'defaultMode',
      desc: '',
      args: [],
    );
  }

  /// `Reserved Mode`
  String get reservedMode {
    return Intl.message(
      'Reserved Mode',
      name: 'reservedMode',
      desc: '',
      args: [],
    );
  }

  /// `Length Mode`
  String get lengthMode {
    return Intl.message(
      'Length Mode',
      name: 'lengthMode',
      desc: '',
      args: [],
    );
  }

  /// `Update Text`
  String get updateText {
    return Intl.message(
      'Update Text',
      name: 'updateText',
      desc: '',
      args: [],
    );
  }

  /// `Input Disabled`
  String get inputDisabled {
    return Intl.message(
      'Input Disabled',
      name: 'inputDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Creation Date Naming`
  String get createDateRename {
    return Intl.message(
      'Creation Date Naming',
      name: 'createDateRename',
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

  /// `Suffix`
  String get suffix {
    return Intl.message(
      'Suffix',
      name: 'suffix',
      desc: '',
      args: [],
    );
  }

  /// `Loop file Content`
  String get loopFileContent {
    return Intl.message(
      'Loop file Content',
      name: 'loopFileContent',
      desc: '',
      args: [],
    );
  }

  /// `Disable`
  String get disable {
    return Intl.message(
      'Disable',
      name: 'disable',
      desc: '',
      args: [],
    );
  }

  /// `Use All`
  String get useAll {
    return Intl.message(
      'Use All',
      name: 'useAll',
      desc: '',
      args: [],
    );
  }

  /// `Only Prefix`
  String get onlyPrefix {
    return Intl.message(
      'Only Prefix',
      name: 'onlyPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Only Suffix`
  String get onlySuffix {
    return Intl.message(
      'Only Suffix',
      name: 'onlySuffix',
      desc: '',
      args: [],
    );
  }

  /// `Prefix Digit Increment`
  String get prefixDigitIncrement {
    return Intl.message(
      'Prefix Digit Increment',
      name: 'prefixDigitIncrement',
      desc: '',
      args: [],
    );
  }

  /// `Suffix Digit Increment`
  String get suffixDigitIncrement {
    return Intl.message(
      'Suffix Digit Increment',
      name: 'suffixDigitIncrement',
      desc: '',
      args: [],
    );
  }

  /// `Enter N Digits Of Characters`
  String get digitIncrementHint {
    return Intl.message(
      'Enter N Digits Of Characters',
      name: 'digitIncrementHint',
      desc: '',
      args: [],
    );
  }

  /// `Swap Incremental Digit Position`
  String get exchangeSeat {
    return Intl.message(
      'Swap Incremental Digit Position',
      name: 'exchangeSeat',
      desc: '',
      args: [],
    );
  }

  /// `Append Mode`
  String get appendMode {
    return Intl.message(
      'Append Mode',
      name: 'appendMode',
      desc: '',
      args: [],
    );
  }

  /// `Add Folder`
  String get addFolder {
    return Intl.message(
      'Add Folder',
      name: 'addFolder',
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

  /// `Original Name`
  String get originalName {
    return Intl.message(
      'Original Name',
      name: 'originalName',
      desc: '',
      args: [],
    );
  }

  /// `Rename Name`
  String get renameName {
    return Intl.message(
      'Rename Name',
      name: 'renameName',
      desc: '',
      args: [],
    );
  }

  /// `Delete Unselected`
  String get deleteUnselected {
    return Intl.message(
      'Delete Unselected',
      name: 'deleteUnselected',
      desc: '',
      args: [],
    );
  }

  /// `Show Unselected`
  String get showUnselected {
    return Intl.message(
      'Show Unselected',
      name: 'showUnselected',
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

  /// `Organize File`
  String get organizeFile {
    return Intl.message(
      'Organize File',
      name: 'organizeFile',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
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

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get lightTheme {
    return Intl.message(
      'Light Theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Follow System`
  String get followSystem {
    return Intl.message(
      'Follow System',
      name: 'followSystem',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `image`
  String get image {
    return Intl.message(
      'image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `video`
  String get video {
    return Intl.message(
      'video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `audio`
  String get audio {
    return Intl.message(
      'audio',
      name: 'audio',
      desc: '',
      args: [],
    );
  }

  /// `text`
  String get text {
    return Intl.message(
      'text',
      name: 'text',
      desc: '',
      args: [],
    );
  }

  /// `folder`
  String get folder {
    return Intl.message(
      'folder',
      name: 'folder',
      desc: '',
      args: [],
    );
  }

  /// `Rename Succeeded`
  String get renameSucceeded {
    return Intl.message(
      'Rename Succeeded',
      name: 'renameSucceeded',
      desc: '',
      args: [],
    );
  }

  /// `The selected {num} files have been renamed successfully 🎉`
  String renameSucceededText(Object num) {
    return Intl.message(
      'The selected $num files have been renamed successfully 🎉',
      name: 'renameSucceededText',
      desc: '',
      args: [num],
    );
  }

  /// `Rename failed`
  String get renameFailed {
    return Intl.message(
      'Rename failed',
      name: 'renameFailed',
      desc: '',
      args: [],
    );
  }

  /// `A file with the same name already exists in the directory. Please rename it and try again 😥`
  String get renameFailedText {
    return Intl.message(
      'A file with the same name already exists in the directory. Please rename it and try again 😥',
      name: 'renameFailedText',
      desc: '',
      args: [],
    );
  }

  /// `Input error`
  String get inputError {
    return Intl.message(
      'Input error',
      name: 'inputError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the correct number 🙄`
  String get inputErrorText {
    return Intl.message(
      'Please enter the correct number 🙄',
      name: 'inputErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Upload failed`
  String get uploadFailed {
    return Intl.message(
      'Upload failed',
      name: 'uploadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Please upload a file that uses line breaks or spaces to separate the content 🥱`
  String get uploadFailedText {
    return Intl.message(
      'Please upload a file that uses line breaks or spaces to separate the content 🥱',
      name: 'uploadFailedText',
      desc: '',
      args: [],
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

  /// `Deletion failed because there is nothing to delete...😓`
  String get deleteFailedText {
    return Intl.message(
      'Deletion failed because there is nothing to delete...😓',
      name: 'deleteFailedText',
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
      Locale.fromSubtags(languageCode: 'zh'),
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
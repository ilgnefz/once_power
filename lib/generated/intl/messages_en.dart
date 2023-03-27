// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name, num, reason) =>
      "[${name}] ${num} files failed to update because of [${reason}].";

  static String m1(num) =>
      "The selected ${num} files have been renamed successfully 🎉";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "LICENSE": MessageLookupByLibrary.simpleMessage("LICENSE"),
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "addFolder": MessageLookupByLibrary.simpleMessage("Add Folder"),
        "appendMode": MessageLookupByLibrary.simpleMessage("Append Mode"),
        "applyChange": MessageLookupByLibrary.simpleMessage("Apply Change"),
        "audio": MessageLookupByLibrary.simpleMessage("audio"),
        "caseSensitive": MessageLookupByLibrary.simpleMessage("Case Sensitive"),
        "copyErrorMessage":
            MessageLookupByLibrary.simpleMessage("Copy error message"),
        "copySucceeded": MessageLookupByLibrary.simpleMessage("Copy Succeeded"),
        "copySucceededText": MessageLookupByLibrary.simpleMessage(
            "Error content successfully copied to Clipboard 😃"),
        "createDateRename":
            MessageLookupByLibrary.simpleMessage("Creation Date Naming"),
        "currentLatest":
            MessageLookupByLibrary.simpleMessage("This is the latest version"),
        "currentVersion":
            MessageLookupByLibrary.simpleMessage("Current Version"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
        "defaultFolder": MessageLookupByLibrary.simpleMessage(
            "Default is the largest parent folder except the root directory"),
        "defaultMode": MessageLookupByLibrary.simpleMessage("Default Mode"),
        "deleteEmptyFolder":
            MessageLookupByLibrary.simpleMessage("Delete Empty Folder"),
        "deleteFailed": MessageLookupByLibrary.simpleMessage("Delete Failed"),
        "deleteFailedText": MessageLookupByLibrary.simpleMessage(
            "Deletion failed because there is nothing to delete...😓"),
        "deleteLength":
            MessageLookupByLibrary.simpleMessage("Delete Specified Length"),
        "deleteUnselected":
            MessageLookupByLibrary.simpleMessage("Delete Unselected"),
        "desc": MessageLookupByLibrary.simpleMessage(
            "🛠 A tool based on Flutter for bulk renaming files and the ability to remove useless nested folders"),
        "detectError": MessageLookupByLibrary.simpleMessage("Detection Failed"),
        "detectVersions":
            MessageLookupByLibrary.simpleMessage("Detect new versions"),
        "detecting": MessageLookupByLibrary.simpleMessage("Detecting..."),
        "digitIncrementHint": MessageLookupByLibrary.simpleMessage(
            "Enter N Digits Of Characters"),
        "disable": MessageLookupByLibrary.simpleMessage("Disable"),
        "dropFile":
            MessageLookupByLibrary.simpleMessage("Drag The Folder Here"),
        "exchangeSeat": MessageLookupByLibrary.simpleMessage(
            "Swap Incremental Digit Position"),
        "folder": MessageLookupByLibrary.simpleMessage("folder"),
        "followSystem": MessageLookupByLibrary.simpleMessage("Follow System"),
        "image": MessageLookupByLibrary.simpleMessage("image"),
        "inputDisabled": MessageLookupByLibrary.simpleMessage("Input Disabled"),
        "inputError": MessageLookupByLibrary.simpleMessage("Input Error"),
        "inputErrorText": MessageLookupByLibrary.simpleMessage(
            "Please enter the correct number 🙄"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "languageTip":
            MessageLookupByLibrary.simpleMessage("Restart to take effect"),
        "latestVersion": MessageLookupByLibrary.simpleMessage("Latest Version"),
        "lengthMatchText": MessageLookupByLibrary.simpleMessage(
            "Enter a random length string Or *Num"),
        "lengthMode": MessageLookupByLibrary.simpleMessage("Length Mode"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Light Theme"),
        "loopFileContent":
            MessageLookupByLibrary.simpleMessage("Loop file Content"),
        "matchText": MessageLookupByLibrary.simpleMessage("Match Text"),
        "multiFailedText": m0,
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "newVersion":
            MessageLookupByLibrary.simpleMessage("New version available"),
        "onlyPrefix": MessageLookupByLibrary.simpleMessage("Only Prefix"),
        "onlySuffix": MessageLookupByLibrary.simpleMessage("Only Suffix"),
        "organizeFailed":
            MessageLookupByLibrary.simpleMessage("Organize Files Failed"),
        "organizeFile": MessageLookupByLibrary.simpleMessage("Organize File"),
        "organizeSuccess":
            MessageLookupByLibrary.simpleMessage("Organize Files Successfully"),
        "organizeTip": MessageLookupByLibrary.simpleMessage(
            "NOTICE: If you want to add files from the system disk, you must select the destination folder"),
        "originalName": MessageLookupByLibrary.simpleMessage("Original Name"),
        "other": MessageLookupByLibrary.simpleMessage("Other"),
        "prefix": MessageLookupByLibrary.simpleMessage("Prefix"),
        "prefixDigitIncrement":
            MessageLookupByLibrary.simpleMessage("Prefix Digit Increment"),
        "projectUrl": MessageLookupByLibrary.simpleMessage("Project Url"),
        "renameFailed": MessageLookupByLibrary.simpleMessage("Rename failed"),
        "renameFailedExists": MessageLookupByLibrary.simpleMessage(
            "A file with the same name already exists in the directory. Please rename it and try again 😥"),
        "renameFailedUnmodified": MessageLookupByLibrary.simpleMessage(
            "The new file name is the same as the original file 😤"),
        "renameName": MessageLookupByLibrary.simpleMessage("Rename Name"),
        "renameSucceeded":
            MessageLookupByLibrary.simpleMessage("Rename Succeeded"),
        "renameSucceededText": m1,
        "reservedMode": MessageLookupByLibrary.simpleMessage("Reserved Mode"),
        "selectFile": MessageLookupByLibrary.simpleMessage("Select File"),
        "selectFolder": MessageLookupByLibrary.simpleMessage("Select Folder"),
        "setting": MessageLookupByLibrary.simpleMessage("Setting"),
        "showUnselected":
            MessageLookupByLibrary.simpleMessage("Show Unselected"),
        "startOrganizing":
            MessageLookupByLibrary.simpleMessage("Start Organizing"),
        "suffix": MessageLookupByLibrary.simpleMessage("Suffix"),
        "suffixDigitIncrement":
            MessageLookupByLibrary.simpleMessage("Suffix Digit Increment"),
        "targetFolder": MessageLookupByLibrary.simpleMessage("Target Folder"),
        "text": MessageLookupByLibrary.simpleMessage("text"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "updateText": MessageLookupByLibrary.simpleMessage("Update Text"),
        "uploadFailed": MessageLookupByLibrary.simpleMessage("Upload Failed"),
        "uploadFailedText": MessageLookupByLibrary.simpleMessage(
            "Please upload a file that uses line breaks or spaces to separate the content 🥱"),
        "useAll": MessageLookupByLibrary.simpleMessage("Use All"),
        "versionDesc":
            MessageLookupByLibrary.simpleMessage("Version Description"),
        "video": MessageLookupByLibrary.simpleMessage("video")
      };
}

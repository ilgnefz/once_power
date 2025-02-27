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

  static String m0(file) => "【${file}】 has been deleted";

  static String m1(name) => " The file renamed to ${name} already exists";

  static String m2(name) => " renaming failed, Because ${name}";

  static String m3(count, total) =>
      "${count} out of ${total} selected renames failed";

  static String m4(count, total) => "Selected ${count}/${total}";

  static String m5(version) => "New version ${version} can be updated";

  static String m6(name) => "No longer exists in ${name}";

  static String m7(total) => "Successfully moved the selected ${total} files";

  static String m8(count) => "Removed ${count} non image or video files";

  static String m9(total) =>
      "All ${total} selected items have been successfully renamed";

  static String m10(count) => "Total ${count}";

  static String m11(count, total) =>
      "${count} out of ${total} selected undo renames failed";

  static String m12(total) =>
      "The selected ${total} operations have all been revoked";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addAfter": MessageLookupByLibrary.simpleMessage("After"),
    "addBefore": MessageLookupByLibrary.simpleMessage("Before"),
    "addFile": MessageLookupByLibrary.simpleMessage("Add file"),
    "addFolder": MessageLookupByLibrary.simpleMessage("Add folder"),
    "addInputHint": MessageLookupByLibrary.simpleMessage(
      "Please enter the added content",
    ),
    "addPosition": MessageLookupByLibrary.simpleMessage("Add Position"),
    "addPreset": MessageLookupByLibrary.simpleMessage("Add Preset"),
    "addSubfolder": MessageLookupByLibrary.simpleMessage(
      "Gets the subfolder of the folder",
    ),
    "addTitle": MessageLookupByLibrary.simpleMessage("Add Content"),
    "addType": MessageLookupByLibrary.simpleMessage("Add Type"),
    "advance": MessageLookupByLibrary.simpleMessage("Advance"),
    "advanceEmpty1": MessageLookupByLibrary.simpleMessage(
      "No instructions have been added yet",
    ),
    "advanceEmpty2": MessageLookupByLibrary.simpleMessage("Click the"),
    "advanceEmpty3": MessageLookupByLibrary.simpleMessage(
      "\"Delete\", \"Add\", or \"Replace\"",
    ),
    "advanceEmpty4": MessageLookupByLibrary.simpleMessage(
      "buttons to add them",
    ),
    "advanceMenu": MessageLookupByLibrary.simpleMessage("AdvanceMenu"),
    "after": MessageLookupByLibrary.simpleMessage("After"),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "allExtension": MessageLookupByLibrary.simpleMessage("All Extension"),
    "appendMode": MessageLookupByLibrary.simpleMessage("Append"),
    "applyChange": MessageLookupByLibrary.simpleMessage("Apply"),
    "audio": MessageLookupByLibrary.simpleMessage("Audio"),
    "autoRun": MessageLookupByLibrary.simpleMessage(
      "Run OncePower when the computer starts up",
    ),
    "before": MessageLookupByLibrary.simpleMessage("Before"),
    "between": MessageLookupByLibrary.simpleMessage("Between"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelOperation": MessageLookupByLibrary.simpleMessage("Cancel Operation"),
    "capitalLetter": MessageLookupByLibrary.simpleMessage("CapitalLetter"),
    "caseClassify": MessageLookupByLibrary.simpleMessage("Case classify"),
    "caseDesc": MessageLookupByLibrary.simpleMessage("Case sensitive"),
    "caseExtension": MessageLookupByLibrary.simpleMessage("Case extension"),
    "checkAscending": MessageLookupByLibrary.simpleMessage("CheckAscending"),
    "checkCompleted": MessageLookupByLibrary.simpleMessage("Check completed"),
    "checkDescending": MessageLookupByLibrary.simpleMessage("CheckDescending"),
    "checkFailed": MessageLookupByLibrary.simpleMessage("Check failed"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Check Version"),
    "checking": MessageLookupByLibrary.simpleMessage("Checking"),
    "circularPrefixDesc": MessageLookupByLibrary.simpleMessage(
      "Circular prefix content",
    ),
    "circularSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Circular suffix content",
    ),
    "classifiedFile": MessageLookupByLibrary.simpleMessage("Classified file"),
    "classifiedFileDesc": MessageLookupByLibrary.simpleMessage(
      "Create parent folders for files based on different types or modification times",
    ),
    "completeContent": MessageLookupByLibrary.simpleMessage(
      "Please input the completed content",
    ),
    "convertLetters": MessageLookupByLibrary.simpleMessage("Convert Letters"),
    "createdDate": MessageLookupByLibrary.simpleMessage("Created"),
    "createdTime": MessageLookupByLibrary.simpleMessage("Created date"),
    "currentTask": MessageLookupByLibrary.simpleMessage("Task"),
    "date": MessageLookupByLibrary.simpleMessage("Date"),
    "dateAscending": MessageLookupByLibrary.simpleMessage("DateAscending"),
    "dateDesc": MessageLookupByLibrary.simpleMessage("Named by date"),
    "dateDescending": MessageLookupByLibrary.simpleMessage("DateDescending"),
    "decodeCSVError": MessageLookupByLibrary.simpleMessage(
      "File parsing error occurred",
    ),
    "defaultSort": MessageLookupByLibrary.simpleMessage("DefaultSort"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteChecked": MessageLookupByLibrary.simpleMessage("Delete checked"),
    "deleteEmptyFolder": MessageLookupByLibrary.simpleMessage("Delete empty"),
    "deleteEmptyFolderDesc": MessageLookupByLibrary.simpleMessage(
      "Delete all empty folders under the selected folder",
    ),
    "deleteFailed": MessageLookupByLibrary.simpleMessage("Delete failed"),
    "deleteInfo": m0,
    "deleteInputHint": MessageLookupByLibrary.simpleMessage(
      "Please enter the deleted content",
    ),
    "deleteLog": MessageLookupByLibrary.simpleMessage("delete logs"),
    "deleteSuccessful": MessageLookupByLibrary.simpleMessage(
      "Delete successful",
    ),
    "deleteTipButton1": MessageLookupByLibrary.simpleMessage(
      "I know. No more reminders",
    ),
    "deleteTipButton2": MessageLookupByLibrary.simpleMessage("I know"),
    "deleteTipMessage": MessageLookupByLibrary.simpleMessage(
      "This operation will delete the file from the system and cannot be restored. To cancel operate please click on the area above the popup window.",
    ),
    "deleteTitle": MessageLookupByLibrary.simpleMessage("Delete Content"),
    "deleteType": MessageLookupByLibrary.simpleMessage("Delete Type"),
    "delimiter": MessageLookupByLibrary.simpleMessage(", "),
    "detailTitle": MessageLookupByLibrary.simpleMessage("All File Extensions"),
    "digit": MessageLookupByLibrary.simpleMessage("Digit"),
    "digits": MessageLookupByLibrary.simpleMessage("digits"),
    "document": MessageLookupByLibrary.simpleMessage("Document"),
    "download": MessageLookupByLibrary.simpleMessage("Download"),
    "earliestDate": MessageLookupByLibrary.simpleMessage("Earliest"),
    "end": MessageLookupByLibrary.simpleMessage("end"),
    "errorImage": MessageLookupByLibrary.simpleMessage("Load Fail "),
    "exifDate": MessageLookupByLibrary.simpleMessage("ExifDate"),
    "existsError": m1,
    "exit": MessageLookupByLibrary.simpleMessage("Exit"),
    "exitApp": MessageLookupByLibrary.simpleMessage("Exit App"),
    "exitOperation": MessageLookupByLibrary.simpleMessage("Exit"),
    "extension": MessageLookupByLibrary.simpleMessage("Type"),
    "extensionDesc": MessageLookupByLibrary.simpleMessage(
      "Modify file extensions",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("Renaming failed"),
    "failedError": m2,
    "failedNum": m3,
    "failureDeleteInfo": MessageLookupByLibrary.simpleMessage(
      "Failed to delete selected files",
    ),
    "failureEmptyInfo": MessageLookupByLibrary.simpleMessage(
      "Failed to delete empty folder",
    ),
    "fileCount": m4,
    "fileExtension": MessageLookupByLibrary.simpleMessage("FileExtension"),
    "fileExtensionDesc": MessageLookupByLibrary.simpleMessage(
      "New file extension",
    ),
    "fileName": MessageLookupByLibrary.simpleMessage("File name"),
    "first": MessageLookupByLibrary.simpleMessage("First"),
    "folder": MessageLookupByLibrary.simpleMessage("Folder"),
    "format": MessageLookupByLibrary.simpleMessage("Format"),
    "formatDesc1": MessageLookupByLibrary.simpleMessage("Name length"),
    "formatDesc2": MessageLookupByLibrary.simpleMessage("is filled with"),
    "formatDesc3": MessageLookupByLibrary.simpleMessage(""),
    "formatDigit": MessageLookupByLibrary.simpleMessage(
      "Please enter the length of the name",
    ),
    "image": MessageLookupByLibrary.simpleMessage("Image"),
    "inputDisable": MessageLookupByLibrary.simpleMessage("Input disabled"),
    "last": MessageLookupByLibrary.simpleMessage("Last"),
    "latestDate": MessageLookupByLibrary.simpleMessage("Latest"),
    "lengthDesc": MessageLookupByLibrary.simpleMessage(
      "Input length truncation (adding a space between two numbers to truncate the middle part)",
    ),
    "letters": MessageLookupByLibrary.simpleMessage("Letters"),
    "loadingImage": MessageLookupByLibrary.simpleMessage("Loading..."),
    "log": MessageLookupByLibrary.simpleMessage("Log"),
    "logDesc": MessageLookupByLibrary.simpleMessage(
      "The target folder is not empty and is saved in the target folder, otherwise it is saved in the logs folder of the software directory",
    ),
    "lowercase": MessageLookupByLibrary.simpleMessage("Lowercase"),
    "lowercaseLetters": MessageLookupByLibrary.simpleMessage(
      "LowercaseLetters",
    ),
    "match": MessageLookupByLibrary.simpleMessage("Matching"),
    "matchHint": MessageLookupByLibrary.simpleMessage("Matching content"),
    "matchLength": MessageLookupByLibrary.simpleMessage(
      "Number or length string",
    ),
    "matchLocation": MessageLookupByLibrary.simpleMessage("Match Location"),
    "matchName": MessageLookupByLibrary.simpleMessage("Match name"),
    "modifiedDate": MessageLookupByLibrary.simpleMessage("Modified"),
    "modifiedTime": MessageLookupByLibrary.simpleMessage("Modified date"),
    "modifyName": MessageLookupByLibrary.simpleMessage("Modify name"),
    "modifyTo": MessageLookupByLibrary.simpleMessage("Modify to"),
    "moveError": MessageLookupByLibrary.simpleMessage("Moving error"),
    "moveFailed": MessageLookupByLibrary.simpleMessage("Move failed"),
    "moveToCenter": MessageLookupByLibrary.simpleMessage("To the center"),
    "moveToFirst": MessageLookupByLibrary.simpleMessage("To the first"),
    "moveToLast": MessageLookupByLibrary.simpleMessage("To the last"),
    "nameAscending": MessageLookupByLibrary.simpleMessage("NameAscending"),
    "nameDescending": MessageLookupByLibrary.simpleMessage("NameDescending"),
    "newName": MessageLookupByLibrary.simpleMessage("New name"),
    "newVersionInfo": m5,
    "noConversion": MessageLookupByLibrary.simpleMessage("No"),
    "noNewVersionInfo": MessageLookupByLibrary.simpleMessage(
      "Currently in the latest version",
    ),
    "nonLetter": MessageLookupByLibrary.simpleMessage("NonLetter"),
    "normal": MessageLookupByLibrary.simpleMessage("Normal"),
    "notExist": MessageLookupByLibrary.simpleMessage("not exist"),
    "notExistsError": m6,
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "openFolder": MessageLookupByLibrary.simpleMessage("Open Folder"),
    "openFolderDesc": MessageLookupByLibrary.simpleMessage(
      "Left mouse click on the file list to quickly open the folder where the file is located",
    ),
    "organize": MessageLookupByLibrary.simpleMessage("Organize"),
    "organizeBtn": MessageLookupByLibrary.simpleMessage("Organize"),
    "organizeFolderDesc": MessageLookupByLibrary.simpleMessage(
      "Move all added files or all sub-files under a folder into the destination folder. If the destination folder is empty and you choose to use the top-level parent folder, all files will be moved to the top-level parent folder of the selected files in addition to the disk root folder",
    ),
    "organizeLogs": MessageLookupByLibrary.simpleMessage("organize logs"),
    "organizeMenu": MessageLookupByLibrary.simpleMessage("OrganizeMenu"),
    "organizedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Organized successfully",
    ),
    "organizedSuccessfullyInfo": m7,
    "organizingFailed": MessageLookupByLibrary.simpleMessage(
      "Organizing failed",
    ),
    "organizingFailedInfo": MessageLookupByLibrary.simpleMessage(
      "The following moves failed",
    ),
    "originalName": MessageLookupByLibrary.simpleMessage("Original name"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "position": MessageLookupByLibrary.simpleMessage("position"),
    "prefix": MessageLookupByLibrary.simpleMessage("Prefix"),
    "prefixContent": MessageLookupByLibrary.simpleMessage("Add prefix content"),
    "preset": MessageLookupByLibrary.simpleMessage("Preset"),
    "presetName": MessageLookupByLibrary.simpleMessage("Preset Name"),
    "presetNameError": MessageLookupByLibrary.simpleMessage(
      "The preset name cannot be empty",
    ),
    "presetNameErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Preset name error",
    ),
    "presetNameHint": MessageLookupByLibrary.simpleMessage(
      "Please enter the preset name",
    ),
    "punctuation": MessageLookupByLibrary.simpleMessage("Punctuation"),
    "regeditTip": MessageLookupByLibrary.simpleMessage(
      "Open right-click shortcut menu (When the software is not running, the Windows system only allows one file path to be passed in at a time, so when the software is not running, only one folder path is allowed to be passed in. You can place all files in one folder. If multiple files are passed in at once, please place the shortcut of the software in the \"Send To\" folder (open File Explorer, enter \"shell: sendto\" in the address bar and press enter), and use \"Send to\" to pass in)",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "removeNonImage": m8,
    "removeSelected": MessageLookupByLibrary.simpleMessage("Remove Selected"),
    "removeUnselected": MessageLookupByLibrary.simpleMessage(
      "Remove Unselected",
    ),
    "renameLogs": MessageLookupByLibrary.simpleMessage("rename logs"),
    "renameName": MessageLookupByLibrary.simpleMessage("Rename name"),
    "replace": MessageLookupByLibrary.simpleMessage("Replace"),
    "replaceInputHint": MessageLookupByLibrary.simpleMessage(
      "Please enter the matching content",
    ),
    "replaceInputHint2": MessageLookupByLibrary.simpleMessage(
      "Please enter the replacement content",
    ),
    "replaceMode": MessageLookupByLibrary.simpleMessage("Replace Mode"),
    "replaceTitle": MessageLookupByLibrary.simpleMessage("Replace Content"),
    "reserve": MessageLookupByLibrary.simpleMessage("Reserve"),
    "restartTip": MessageLookupByLibrary.simpleMessage("Restart takes effect"),
    "saveConfig": MessageLookupByLibrary.simpleMessage("Saved Configurations"),
    "saveLog": MessageLookupByLibrary.simpleMessage(
      "Save log (The default is in the logs folder under the software folder)",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Select"),
    "selectAllSwitch": MessageLookupByLibrary.simpleMessage("Select Switch"),
    "selectFolder": MessageLookupByLibrary.simpleMessage("Select folder"),
    "selectReserve": MessageLookupByLibrary.simpleMessage("Reverse Selection"),
    "selectTargetFolder": MessageLookupByLibrary.simpleMessage("Target folder"),
    "serial": MessageLookupByLibrary.simpleMessage("Serial"),
    "serialNumber": MessageLookupByLibrary.simpleMessage("Serial Number"),
    "shortcutTip1": MessageLookupByLibrary.simpleMessage("Add all subfiles to"),
    "shortcutTip2": MessageLookupByLibrary.simpleMessage("Add to"),
    "showWindow": MessageLookupByLibrary.simpleMessage("Show Window"),
    "space": MessageLookupByLibrary.simpleMessage("Space"),
    "start": MessageLookupByLibrary.simpleMessage("start"),
    "startSequence": MessageLookupByLibrary.simpleMessage("start"),
    "successDeleteInfo": MessageLookupByLibrary.simpleMessage(
      "Successfully deleted all selected files",
    ),
    "successEmptyInfo": MessageLookupByLibrary.simpleMessage(
      "Successfully deleted all empty folders",
    ),
    "successful": MessageLookupByLibrary.simpleMessage("Renaming successful"),
    "successfulNum": m9,
    "suffix": MessageLookupByLibrary.simpleMessage("Suffix"),
    "suffixContent": MessageLookupByLibrary.simpleMessage("Add suffix content"),
    "swapPrefixDesc": MessageLookupByLibrary.simpleMessage(
      "Swap prefixes and incremental number positions",
    ),
    "swapSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Swap suffixes and incremental number positions",
    ),
    "tableInfo": MessageLookupByLibrary.simpleMessage(
      "Selected original name column: ",
    ),
    "takeTime": MessageLookupByLibrary.simpleMessage("Time"),
    "targetFolder": MessageLookupByLibrary.simpleMessage("Target folder"),
    "text": MessageLookupByLibrary.simpleMessage("Text"),
    "tip": MessageLookupByLibrary.simpleMessage("Drag the File/Folder here"),
    "tipImage": MessageLookupByLibrary.simpleMessage(
      "Drag the Picture File/Folder here",
    ),
    "tipTitle": MessageLookupByLibrary.simpleMessage("Tip"),
    "to": MessageLookupByLibrary.simpleMessage("to"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "toggleCase": MessageLookupByLibrary.simpleMessage("Toggle"),
    "topParentFolder": MessageLookupByLibrary.simpleMessage(
      "Top parent folder",
    ),
    "totalInstructions": m10,
    "tvSeriesInfo": MessageLookupByLibrary.simpleMessage("Get episode info"),
    "typeAscending": MessageLookupByLibrary.simpleMessage("TypeAscending"),
    "typeDescending": MessageLookupByLibrary.simpleMessage("TypeDescending"),
    "undo": MessageLookupByLibrary.simpleMessage("Undo"),
    "undoFailed": MessageLookupByLibrary.simpleMessage("Undo rename failed"),
    "undoFailedNum": m11,
    "undoSuccessful": MessageLookupByLibrary.simpleMessage("Undo Successful"),
    "undoSuccessfulNum": m12,
    "unselect": MessageLookupByLibrary.simpleMessage("Unselect"),
    "uploadCSV": MessageLookupByLibrary.simpleMessage(
      "Upload CSV and TXT files with \",\" separating old and new names, or OPLOG file generated by OncePower",
    ),
    "uploadDesc": MessageLookupByLibrary.simpleMessage("Upload .txt file"),
    "uppercase": MessageLookupByLibrary.simpleMessage("Uppercase"),
    "useDesc": MessageLookupByLibrary.simpleMessage("Instructions for use"),
    "useTimeClassification": MessageLookupByLibrary.simpleMessage(
      "Classify using file modification time",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "viewMode": MessageLookupByLibrary.simpleMessage("View mode"),
    "withT": MessageLookupByLibrary.simpleMessage("with"),
    "zip": MessageLookupByLibrary.simpleMessage("Zip"),
  };
}

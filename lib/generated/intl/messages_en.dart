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

  static String m2(count) => "Successfully exported ${count} presets";

  static String m3(name) => " renaming failed, Because ${name}";

  static String m4(count, total) =>
      "${count} out of ${total} selected renames failed";

  static String m5(count, total) => "Selected ${count}/${total}";

  static String m6(file) => "Failed to open ${file}";

  static String m7(err) => "Decryption failed: ${err}";

  static String m8(count) => "Successfully imported ${count} presets";

  static String m9(file) => "Failed to modify ${file} date";

  static String m10(total) =>
      "Successfully modified the date of ${total} files";

  static String m11(version) => "New version ${version} can be updated";

  static String m12(name) => "No longer exists in ${name}";

  static String m13(total) => "Successfully moved the selected ${total} files";

  static String m14(count) => "Removed ${count} non image or video files";

  static String m15(total) =>
      "All ${total} selected items have been successfully renamed";

  static String m16(count) => "Total ${count}";

  static String m17(count, total) =>
      "${count} out of ${total} selected undo renames failed";

  static String m18(total) =>
      "The selected ${total} operations have all been revoked";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessedDate": MessageLookupByLibrary.simpleMessage("Accessed"),
    "accessedDateTip": MessageLookupByLibrary.simpleMessage(
      "Note: Right-click to view file properties, and the accessed date will be changed to the current time",
    ),
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
      "No directive have been added yet",
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
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "allExtension": MessageLookupByLibrary.simpleMessage("All extension"),
    "allFolder": MessageLookupByLibrary.simpleMessage("All folder"),
    "allFolderTitle": MessageLookupByLibrary.simpleMessage("All folder path"),
    "appendMode": MessageLookupByLibrary.simpleMessage("Append"),
    "applyChange": MessageLookupByLibrary.simpleMessage("Apply"),
    "applyGroup": MessageLookupByLibrary.simpleMessage("Apply Group"),
    "artist": MessageLookupByLibrary.simpleMessage("Artist"),
    "audio": MessageLookupByLibrary.simpleMessage("Audio"),
    "autoRun": MessageLookupByLibrary.simpleMessage(
      "Run OncePower when the computer starts up",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "backLabel": MessageLookupByLibrary.simpleMessage("Back"),
    "before": MessageLookupByLibrary.simpleMessage("Before"),
    "between": MessageLookupByLibrary.simpleMessage("Between"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelOperation": MessageLookupByLibrary.simpleMessage("Cancel Operation"),
    "cancelSelected": MessageLookupByLibrary.simpleMessage("Cancel"),
    "capitalLetter": MessageLookupByLibrary.simpleMessage("CapitalLetter"),
    "caseDesc": MessageLookupByLibrary.simpleMessage("Case sensitive"),
    "caseExtension": MessageLookupByLibrary.simpleMessage("Case ext."),
    "caseFile": MessageLookupByLibrary.simpleMessage("Case type"),
    "checkAscending": MessageLookupByLibrary.simpleMessage("Check ascending"),
    "checkCompleted": MessageLookupByLibrary.simpleMessage("Check completed"),
    "checkDescending": MessageLookupByLibrary.simpleMessage("Check descending"),
    "checkFailed": MessageLookupByLibrary.simpleMessage("Check failed"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Check Version"),
    "checking": MessageLookupByLibrary.simpleMessage("Checking"),
    "circularPrefixDesc": MessageLookupByLibrary.simpleMessage(
      "Circular prefix content",
    ),
    "circularSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Circular suffix content",
    ),
    "classifyFolderError": MessageLookupByLibrary.simpleMessage(
      "The type folder is empty!",
    ),
    "classifyType": MessageLookupByLibrary.simpleMessage("Set type folder"),
    "completeContent": MessageLookupByLibrary.simpleMessage(
      "Please input the completed content",
    ),
    "convertLetters": MessageLookupByLibrary.simpleMessage("Convert Text"),
    "createdDate": MessageLookupByLibrary.simpleMessage("Created"),
    "createdTime": MessageLookupByLibrary.simpleMessage("Created date"),
    "currentTask": MessageLookupByLibrary.simpleMessage("Task"),
    "customImageSize": MessageLookupByLibrary.simpleMessage(
      "Custom image size",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Dark theme"),
    "date": MessageLookupByLibrary.simpleMessage("Date"),
    "dateAscending": MessageLookupByLibrary.simpleMessage("Date ascending"),
    "dateClassification": MessageLookupByLibrary.simpleMessage("Date category"),
    "dateClassificationDesc": MessageLookupByLibrary.simpleMessage(
      "Create a folder named after the date of file creation in the target folder and move it to that folder",
    ),
    "dateDesc": MessageLookupByLibrary.simpleMessage("Named by date"),
    "dateDescending": MessageLookupByLibrary.simpleMessage("Date descending"),
    "decodeCSVError": MessageLookupByLibrary.simpleMessage(
      "File parsing error occurred",
    ),
    "decodeCSVError2": MessageLookupByLibrary.simpleMessage(
      "Not a compliant CSV file",
    ),
    "defaultSort": MessageLookupByLibrary.simpleMessage("Default sort"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteChecked": MessageLookupByLibrary.simpleMessage("Delete checked"),
    "deleteEmptyFolder": MessageLookupByLibrary.simpleMessage("Delete empty"),
    "deleteEmptyFolderDesc": MessageLookupByLibrary.simpleMessage(
      "Delete all empty folders under the selected folder",
    ),
    "deleteExtension": MessageLookupByLibrary.simpleMessage("Delete Ext."),
    "deleteFailed": MessageLookupByLibrary.simpleMessage("Delete failed"),
    "deleteFileDesc": MessageLookupByLibrary.simpleMessage(
      "Files will be deleted to the Recycle Bin",
    ),
    "deleteInfo": m0,
    "deleteInputHint": MessageLookupByLibrary.simpleMessage(
      "Please enter the deleted content",
    ),
    "deleteLog": MessageLookupByLibrary.simpleMessage("delete logs"),
    "deleteSelected": MessageLookupByLibrary.simpleMessage("Delete selected"),
    "deleteSuccessful": MessageLookupByLibrary.simpleMessage(
      "Delete successful",
    ),
    "deleteTitle": MessageLookupByLibrary.simpleMessage("Delete Content"),
    "deleteType": MessageLookupByLibrary.simpleMessage("Delete Type"),
    "delimiter": MessageLookupByLibrary.simpleMessage(", "),
    "detailTitle": MessageLookupByLibrary.simpleMessage("All File Extensions"),
    "di": MessageLookupByLibrary.simpleMessage(""),
    "digit": MessageLookupByLibrary.simpleMessage("Digit"),
    "digits": MessageLookupByLibrary.simpleMessage("digits"),
    "disable": MessageLookupByLibrary.simpleMessage("Disable"),
    "distinguish": MessageLookupByLibrary.simpleMessage("distinguish"),
    "document": MessageLookupByLibrary.simpleMessage("Document"),
    "download": MessageLookupByLibrary.simpleMessage("Download"),
    "earliestDate": MessageLookupByLibrary.simpleMessage("Earliest"),
    "editGroup": MessageLookupByLibrary.simpleMessage("Edit group"),
    "emptyFolderError": MessageLookupByLibrary.simpleMessage(
      "The selected folder is empty",
    ),
    "emptyFolderErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Fail to read file",
    ),
    "end": MessageLookupByLibrary.simpleMessage("end"),
    "errorImage": MessageLookupByLibrary.simpleMessage("Load Fail "),
    "exifDate": MessageLookupByLibrary.simpleMessage("Exif Date"),
    "existsError": m1,
    "exit": MessageLookupByLibrary.simpleMessage("Exit"),
    "exitApp": MessageLookupByLibrary.simpleMessage("Exit App"),
    "exitOperation": MessageLookupByLibrary.simpleMessage("Exit"),
    "exportPreset": MessageLookupByLibrary.simpleMessage("Export"),
    "exportPresetError": MessageLookupByLibrary.simpleMessage(
      "Preset export failed",
    ),
    "exportPresetSuccess": MessageLookupByLibrary.simpleMessage(
      "Preset export success",
    ),
    "exportPresetSuccessNum": m2,
    "exportPresetTitle": MessageLookupByLibrary.simpleMessage("Export Preset"),
    "extension": MessageLookupByLibrary.simpleMessage("Extension"),
    "extensionDesc": MessageLookupByLibrary.simpleMessage(
      "Modify file extensions",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("Renaming failed"),
    "failedError": m3,
    "failedNum": m4,
    "failureDeleteInfo": MessageLookupByLibrary.simpleMessage(
      "Failed to delete selected files",
    ),
    "failureEmptyInfo": MessageLookupByLibrary.simpleMessage(
      "Failed to delete empty folder",
    ),
    "fileCount": m5,
    "fileDate": MessageLookupByLibrary.simpleMessage("File Date"),
    "fileDateSelect": MessageLookupByLibrary.simpleMessage(
      "Please select a date",
    ),
    "fileExtension": MessageLookupByLibrary.simpleMessage("FileExtension"),
    "fileExtensionDesc": MessageLookupByLibrary.simpleMessage(
      "New file extension",
    ),
    "fileName": MessageLookupByLibrary.simpleMessage("File name"),
    "fileNoExist": MessageLookupByLibrary.simpleMessage("File does not exist"),
    "fileNoOpen": m6,
    "fileType": MessageLookupByLibrary.simpleMessage("Type"),
    "fillBack": MessageLookupByLibrary.simpleMessage("Fill back"),
    "fillFront": MessageLookupByLibrary.simpleMessage("Fill front"),
    "first": MessageLookupByLibrary.simpleMessage("First"),
    "folder": MessageLookupByLibrary.simpleMessage("Folder"),
    "folderAscending": MessageLookupByLibrary.simpleMessage("Folder ascending"),
    "folderDescending": MessageLookupByLibrary.simpleMessage(
      "Folder descending",
    ),
    "format": MessageLookupByLibrary.simpleMessage("Format"),
    "formatDesc1": MessageLookupByLibrary.simpleMessage("Length"),
    "formatDesc2": MessageLookupByLibrary.simpleMessage("filled with"),
    "formatDesc3": MessageLookupByLibrary.simpleMessage(""),
    "formatDigit": MessageLookupByLibrary.simpleMessage(
      "Please enter the length of the name",
    ),
    "front": MessageLookupByLibrary.simpleMessage("Front"),
    "frontLabel": MessageLookupByLibrary.simpleMessage("Front"),
    "group": MessageLookupByLibrary.simpleMessage("Group"),
    "groupAscending": MessageLookupByLibrary.simpleMessage("Group ascending"),
    "groupDescending": MessageLookupByLibrary.simpleMessage("Group descending"),
    "groupFolderError": MessageLookupByLibrary.simpleMessage(
      "The group folder is empty!",
    ),
    "groupType": MessageLookupByLibrary.simpleMessage("Set group folder"),
    "height": MessageLookupByLibrary.simpleMessage("Height"),
    "hideAll": MessageLookupByLibrary.simpleMessage(
      "Hidden all unchanged files",
    ),
    "image": MessageLookupByLibrary.simpleMessage("Image"),
    "importPreset": MessageLookupByLibrary.simpleMessage("Import"),
    "importPresetError": MessageLookupByLibrary.simpleMessage(
      "Preset import failed",
    ),
    "importPresetErrorDesc1": MessageLookupByLibrary.simpleMessage(
      "The file is not complete, missing header or IV",
    ),
    "importPresetErrorDesc2": MessageLookupByLibrary.simpleMessage(
      "Invalid file format, header does not match",
    ),
    "importPresetErrorDesc3": m7,
    "importPresetSuccess": MessageLookupByLibrary.simpleMessage(
      "Preset import success",
    ),
    "importPresetSuccessNum": m8,
    "inputDisable": MessageLookupByLibrary.simpleMessage("Input disabled"),
    "last": MessageLookupByLibrary.simpleMessage("Last"),
    "latestDate": MessageLookupByLibrary.simpleMessage("Latest"),
    "lengthDesc": MessageLookupByLibrary.simpleMessage(
      "Input length truncation (adding a space between two numbers to truncate the middle part)",
    ),
    "letters": MessageLookupByLibrary.simpleMessage("Text with"),
    "lightTheme": MessageLookupByLibrary.simpleMessage("Light theme"),
    "loadingImage": MessageLookupByLibrary.simpleMessage("Loading..."),
    "lowercase": MessageLookupByLibrary.simpleMessage("Lowercase"),
    "lowercaseLetters": MessageLookupByLibrary.simpleMessage(
      "LowercaseLetters",
    ),
    "match": MessageLookupByLibrary.simpleMessage("Matching"),
    "matchExtDesc": MessageLookupByLibrary.simpleMessage("Match extension"),
    "matchExtension": MessageLookupByLibrary.simpleMessage("Match ext."),
    "matchHint": MessageLookupByLibrary.simpleMessage("Matching content"),
    "matchLength": MessageLookupByLibrary.simpleMessage(
      "Number or length string",
    ),
    "matchName": MessageLookupByLibrary.simpleMessage("Match name"),
    "matchParent": MessageLookupByLibrary.simpleMessage("Match folder"),
    "matchPosition": MessageLookupByLibrary.simpleMessage("Match Position"),
    "metaData": MessageLookupByLibrary.simpleMessage("MetaData"),
    "modifiedDate": MessageLookupByLibrary.simpleMessage("Modified"),
    "modifiedFileDate": MessageLookupByLibrary.simpleMessage(
      "Modify file date",
    ),
    "modifiedTime": MessageLookupByLibrary.simpleMessage("Modified date"),
    "modifyDateFailInfo": m9,
    "modifyDateFailed": MessageLookupByLibrary.simpleMessage(
      "Modify date failed",
    ),
    "modifyDateFailedInfo": MessageLookupByLibrary.simpleMessage(
      "The following files failed to modify the date:",
    ),
    "modifyDateSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Modify date successfully",
    ),
    "modifyDateSuccessfullyInfo": m10,
    "modifyName": MessageLookupByLibrary.simpleMessage("Modify name"),
    "modifyTo": MessageLookupByLibrary.simpleMessage("Modify to"),
    "move": MessageLookupByLibrary.simpleMessage("Move"),
    "moveError": MessageLookupByLibrary.simpleMessage("Moving error"),
    "moveFailed": MessageLookupByLibrary.simpleMessage("Move failed"),
    "moveToCenter": MessageLookupByLibrary.simpleMessage("To the center"),
    "moveToFirst": MessageLookupByLibrary.simpleMessage("To the first"),
    "moveToLast": MessageLookupByLibrary.simpleMessage("To the last"),
    "nameAscending": MessageLookupByLibrary.simpleMessage("Name ascending"),
    "nameDescending": MessageLookupByLibrary.simpleMessage("Name descending"),
    "newName": MessageLookupByLibrary.simpleMessage("New name"),
    "newVersionInfo": m11,
    "noConversion": MessageLookupByLibrary.simpleMessage("No"),
    "noNewVersionInfo": MessageLookupByLibrary.simpleMessage(
      "Currently in the latest version",
    ),
    "nonLetter": MessageLookupByLibrary.simpleMessage("NonLetter"),
    "none": MessageLookupByLibrary.simpleMessage("None"),
    "normal": MessageLookupByLibrary.simpleMessage("Normal"),
    "notExist": MessageLookupByLibrary.simpleMessage("not exist"),
    "notExistError": MessageLookupByLibrary.simpleMessage(
      "The target location has been changed or deleted",
    ),
    "notExistsError": m12,
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "openError": MessageLookupByLibrary.simpleMessage("Open failed"),
    "openPosition": MessageLookupByLibrary.simpleMessage("Open position"),
    "organize": MessageLookupByLibrary.simpleMessage("Organize"),
    "organizeBtn": MessageLookupByLibrary.simpleMessage("Move"),
    "organizeLogs": MessageLookupByLibrary.simpleMessage("organize logs"),
    "organizeMenu": MessageLookupByLibrary.simpleMessage("OrganizeMenu"),
    "organizedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Organized successfully",
    ),
    "organizedSuccessfullyInfo": m13,
    "organizingFailed": MessageLookupByLibrary.simpleMessage(
      "Organizing failed",
    ),
    "organizingFailedInfo": MessageLookupByLibrary.simpleMessage(
      "The following files failed to move:",
    ),
    "originalName": MessageLookupByLibrary.simpleMessage("Name"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "parentsName": MessageLookupByLibrary.simpleMessage("FolderName"),
    "place": MessageLookupByLibrary.simpleMessage("place"),
    "position": MessageLookupByLibrary.simpleMessage("Position"),
    "prefix": MessageLookupByLibrary.simpleMessage("Prefix"),
    "prefixContent": MessageLookupByLibrary.simpleMessage("Add prefix content"),
    "preset": MessageLookupByLibrary.simpleMessage("Preset"),
    "presetAddError": MessageLookupByLibrary.simpleMessage(
      "The instruction list cannot be empty!",
    ),
    "presetAddErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Add preset failed",
    ),
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
    "random": MessageLookupByLibrary.simpleMessage("Random"),
    "randomInputHint": MessageLookupByLibrary.simpleMessage(
      "Please enter custom content",
    ),
    "regeditTip": MessageLookupByLibrary.simpleMessage(
      "Open right-click shortcut menu (When the software is not running, the Windows system only allows one file path to be passed in at a time, so when the software is not running, only one folder path is allowed to be passed in. You can place all files in one folder. If multiple files are passed in at once, please place the shortcut of the software in the \"Send To\" folder (open File Explorer, enter \"shell: sendto\" in the address bar and press enter), and use \"Send to\" to pass in)",
    ),
    "regexDesc": MessageLookupByLibrary.simpleMessage("Use Regex"),
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "removeFolder": MessageLookupByLibrary.simpleMessage("Remove folder"),
    "removeNonImage": m14,
    "removeSelected": MessageLookupByLibrary.simpleMessage("Remove checked"),
    "removeUnselected": MessageLookupByLibrary.simpleMessage(
      "Remove unchecked",
    ),
    "renameLogs": MessageLookupByLibrary.simpleMessage("rename logs"),
    "renameName": MessageLookupByLibrary.simpleMessage("New name"),
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
    "resolution": MessageLookupByLibrary.simpleMessage("Resolution"),
    "restartTip": MessageLookupByLibrary.simpleMessage("Restart takes effect"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveConfig": MessageLookupByLibrary.simpleMessage("Saved Configurations"),
    "saveLog": MessageLookupByLibrary.simpleMessage(
      "Save log (The default is in the logs folder under the software folder)",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Check"),
    "selectAllSwitch": MessageLookupByLibrary.simpleMessage("All switch"),
    "selectFolder": MessageLookupByLibrary.simpleMessage("Select folder"),
    "selectGroup": MessageLookupByLibrary.simpleMessage("Select group"),
    "selectPath": MessageLookupByLibrary.simpleMessage("Select folder"),
    "selectReserve": MessageLookupByLibrary.simpleMessage("Invert selection"),
    "selectTargetFolder": MessageLookupByLibrary.simpleMessage("Target folder"),
    "selectedAll": MessageLookupByLibrary.simpleMessage("Selected all"),
    "separate": MessageLookupByLibrary.simpleMessage("Separate Words"),
    "serial": MessageLookupByLibrary.simpleMessage("Serial"),
    "serialDistinguish": MessageLookupByLibrary.simpleMessage(
      "Serial Classify",
    ),
    "settingGroup": MessageLookupByLibrary.simpleMessage("Setting group"),
    "shortcutKey": MessageLookupByLibrary.simpleMessage("Shortcut key"),
    "shortcutTip1": MessageLookupByLibrary.simpleMessage("Add all subfiles to"),
    "shortcutTip2": MessageLookupByLibrary.simpleMessage("Add to"),
    "showWindow": MessageLookupByLibrary.simpleMessage("Show Window"),
    "simplified": MessageLookupByLibrary.simpleMessage("SimplifiedCN"),
    "size": MessageLookupByLibrary.simpleMessage("Size"),
    "sizeAscending": MessageLookupByLibrary.simpleMessage("Size ascending"),
    "sizeDescending": MessageLookupByLibrary.simpleMessage("Size descending"),
    "space": MessageLookupByLibrary.simpleMessage("Space"),
    "start": MessageLookupByLibrary.simpleMessage("start"),
    "startSequence": MessageLookupByLibrary.simpleMessage("Start"),
    "successDeleteInfo": MessageLookupByLibrary.simpleMessage(
      "Successfully deleted all selected files",
    ),
    "successEmptyInfo": MessageLookupByLibrary.simpleMessage(
      "Successfully deleted all empty folders under the selected folder",
    ),
    "successful": MessageLookupByLibrary.simpleMessage("Renaming successful"),
    "successfulNum": m15,
    "suffix": MessageLookupByLibrary.simpleMessage("Suffix"),
    "suffixContent": MessageLookupByLibrary.simpleMessage("Add suffix content"),
    "suspenseError": MessageLookupByLibrary.simpleMessage(
      "Suspense file failed",
    ),
    "suspenseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "No bulk suspense of all files",
    ),
    "suspenseFile": MessageLookupByLibrary.simpleMessage("Suspense file"),
    "swapPrefixDesc": MessageLookupByLibrary.simpleMessage(
      "Swap prefixes and incremental number positions",
    ),
    "swapSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Swap suffixes and incremental number positions",
    ),
    "system": MessageLookupByLibrary.simpleMessage("System"),
    "tableInfo": MessageLookupByLibrary.simpleMessage("Original name column: "),
    "takeOut": MessageLookupByLibrary.simpleMessage("Take out"),
    "takeOutBehind": MessageLookupByLibrary.simpleMessage(
      "Take it out to the back",
    ),
    "takeOutFront": MessageLookupByLibrary.simpleMessage(
      "Take it out to the front",
    ),
    "takeTime": MessageLookupByLibrary.simpleMessage("Time"),
    "targetFolder": MessageLookupByLibrary.simpleMessage("Target folder"),
    "targetFolderError": MessageLookupByLibrary.simpleMessage(
      "The target folder is empty!",
    ),
    "text": MessageLookupByLibrary.simpleMessage("Text"),
    "tip": MessageLookupByLibrary.simpleMessage("Drag the File/Folder here"),
    "tipImage": MessageLookupByLibrary.simpleMessage(
      "Drag the Picture File/Folder here",
    ),
    "title": MessageLookupByLibrary.simpleMessage("Title"),
    "to": MessageLookupByLibrary.simpleMessage("to"),
    "toBehind": MessageLookupByLibrary.simpleMessage("To the behind"),
    "toFront": MessageLookupByLibrary.simpleMessage("To the front"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "toggleCase": MessageLookupByLibrary.simpleMessage("Toggle"),
    "toggleSelected": MessageLookupByLibrary.simpleMessage(
      "Toggle selected state",
    ),
    "toggleStatus": MessageLookupByLibrary.simpleMessage("Toggle status"),
    "topParentFolder": MessageLookupByLibrary.simpleMessage("Top folder"),
    "topParentFolderDesc": MessageLookupByLibrary.simpleMessage(
      "Move the file to a top-level parent folder other than the disk root directory",
    ),
    "totalDirectives": m16,
    "traditional": MessageLookupByLibrary.simpleMessage("TraditionalCN"),
    "tvSeriesInfo": MessageLookupByLibrary.simpleMessage("Get episode info"),
    "txtDecodeFailed": MessageLookupByLibrary.simpleMessage(
      "File decode failed",
    ),
    "txtDecodeFailedDesc": MessageLookupByLibrary.simpleMessage(
      "Please check the file encoding. Currently, only files encoded in UTF-8 and GBK are supported",
    ),
    "typeAscending": MessageLookupByLibrary.simpleMessage("Type ascending"),
    "typeDescending": MessageLookupByLibrary.simpleMessage("Type descending"),
    "undo": MessageLookupByLibrary.simpleMessage("Undo"),
    "undoFailed": MessageLookupByLibrary.simpleMessage("Undo rename failed"),
    "undoFailedNum": m17,
    "undoSuccessful": MessageLookupByLibrary.simpleMessage("Undo Successful"),
    "undoSuccessfulNum": m18,
    "unselect": MessageLookupByLibrary.simpleMessage("Uncheck"),
    "uploadCSV": MessageLookupByLibrary.simpleMessage(
      "Upload CSV and TXT files with \",\" separating old and new names, or OPLOG file generated by OncePower",
    ),
    "uploadDesc": MessageLookupByLibrary.simpleMessage(
      "Upload. txt files separated by spaces or line breaks for each name",
    ),
    "uppercase": MessageLookupByLibrary.simpleMessage("Uppercase"),
    "useDesc": MessageLookupByLibrary.simpleMessage("Instructions for use"),
    "useGroup": MessageLookupByLibrary.simpleMessage("Group category"),
    "useRule": MessageLookupByLibrary.simpleMessage("Type category"),
    "useRuleDesc": MessageLookupByLibrary.simpleMessage(
      "Move files of different types to different folders",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "viewMode": MessageLookupByLibrary.simpleMessage("View mode"),
    "warning": MessageLookupByLibrary.simpleMessage("Warning"),
    "warningCSVDesc": MessageLookupByLibrary.simpleMessage(
      "The function to upload CSV files has been disabled in the Organize Mode and Modify file date function",
    ),
    "width": MessageLookupByLibrary.simpleMessage("Width"),
    "withT": MessageLookupByLibrary.simpleMessage("with"),
    "wordSpacing": MessageLookupByLibrary.simpleMessage("Word Spacing"),
    "wordSpacingHint": MessageLookupByLibrary.simpleMessage(
      "Separate words starting with capital letters",
    ),
    "year": MessageLookupByLibrary.simpleMessage("Year"),
    "zip": MessageLookupByLibrary.simpleMessage("Zip"),
  };
}

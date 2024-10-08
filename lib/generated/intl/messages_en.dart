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

  static String m4(total, count) => "${total} files ${count} selected";

  static String m5(version) => "New version ${version} can be updated";

  static String m6(name) => "No longer exists in ${name}";

  static String m7(count) => "Removed ${count} non-image files";

  static String m8(total) =>
      "All ${total} selected items have been successfully renamed";

  static String m9(count, total) =>
      "${count} out of ${total} selected undo renames failed";

  static String m10(total) =>
      "All ${total} selected items have been successfully undone";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addFile": MessageLookupByLibrary.simpleMessage("Add file"),
        "addFolder": MessageLookupByLibrary.simpleMessage("Add folder"),
        "addSubfolder": MessageLookupByLibrary.simpleMessage(
            "Gets the subfolder of the folder"),
        "after": MessageLookupByLibrary.simpleMessage("After"),
        "allExtension": MessageLookupByLibrary.simpleMessage("All Extension"),
        "appendMode": MessageLookupByLibrary.simpleMessage("Append"),
        "applyChange": MessageLookupByLibrary.simpleMessage("Apply"),
        "audio": MessageLookupByLibrary.simpleMessage("Audio"),
        "before": MessageLookupByLibrary.simpleMessage("Before"),
        "between": MessageLookupByLibrary.simpleMessage("Between"),
        "caseDesc": MessageLookupByLibrary.simpleMessage("Case sensitive"),
        "checkCompleted":
            MessageLookupByLibrary.simpleMessage("Check completed"),
        "checkFailed": MessageLookupByLibrary.simpleMessage("Check failed"),
        "checkUpdate": MessageLookupByLibrary.simpleMessage("Check Version"),
        "checking": MessageLookupByLibrary.simpleMessage("Checking"),
        "circularPrefixDesc":
            MessageLookupByLibrary.simpleMessage("Circular prefix content"),
        "circularSuffixDesc":
            MessageLookupByLibrary.simpleMessage("Circular suffix content"),
        "classifiedFile":
            MessageLookupByLibrary.simpleMessage("Classified file"),
        "classifiedFileDesc": MessageLookupByLibrary.simpleMessage(
            "Create folders for different types of files"),
        "createdDate": MessageLookupByLibrary.simpleMessage("Created"),
        "createdTime": MessageLookupByLibrary.simpleMessage("Created date"),
        "currentTask": MessageLookupByLibrary.simpleMessage("CurrentTask"),
        "date": MessageLookupByLibrary.simpleMessage("Date"),
        "dateDesc": MessageLookupByLibrary.simpleMessage("Named by date"),
        "decodeCSVError":
            MessageLookupByLibrary.simpleMessage("File parsing error occurred"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteEmptyFolder":
            MessageLookupByLibrary.simpleMessage("Delete folder"),
        "deleteEmptyFolderDesc": MessageLookupByLibrary.simpleMessage(
            "Delete all empty folders under the added folder"),
        "deleteFailed": MessageLookupByLibrary.simpleMessage("Delete failed"),
        "deleteInfo": m0,
        "deleteLog": MessageLookupByLibrary.simpleMessage("delete logs"),
        "deleteSuccessful":
            MessageLookupByLibrary.simpleMessage("Delete successful"),
        "deleteUnselected":
            MessageLookupByLibrary.simpleMessage("Delete Unselected"),
        "detailTitle":
            MessageLookupByLibrary.simpleMessage("All File Extensions"),
        "digits": MessageLookupByLibrary.simpleMessage("digits"),
        "document": MessageLookupByLibrary.simpleMessage("Document"),
        "download": MessageLookupByLibrary.simpleMessage("Download"),
        "earliestDate": MessageLookupByLibrary.simpleMessage("Earliest"),
        "errorImage": MessageLookupByLibrary.simpleMessage("Load Fail "),
        "exifDate": MessageLookupByLibrary.simpleMessage("ExifDate"),
        "existsError": m1,
        "exit": MessageLookupByLibrary.simpleMessage("Exit"),
        "exitOperation": MessageLookupByLibrary.simpleMessage("Exit Operation"),
        "extension": MessageLookupByLibrary.simpleMessage("Type"),
        "extensionDesc":
            MessageLookupByLibrary.simpleMessage("Modify file extensions"),
        "failed": MessageLookupByLibrary.simpleMessage("Renaming failed"),
        "failedError": m2,
        "failedNum": m3,
        "failureInfo": MessageLookupByLibrary.simpleMessage(
            "Failed to delete empty folder"),
        "fileCount": m4,
        "fileExtension": MessageLookupByLibrary.simpleMessage("FileExtension"),
        "fileExtensionDesc":
            MessageLookupByLibrary.simpleMessage("New file extension"),
        "fileName": MessageLookupByLibrary.simpleMessage("File name"),
        "folder": MessageLookupByLibrary.simpleMessage("Folder"),
        "image": MessageLookupByLibrary.simpleMessage("Image"),
        "inputDisable": MessageLookupByLibrary.simpleMessage("Input disabled"),
        "latestDate": MessageLookupByLibrary.simpleMessage("Latest"),
        "lengthDesc": MessageLookupByLibrary.simpleMessage(
            "Input length truncation (adding a space between two numbers to truncate the middle part)"),
        "loadingImage": MessageLookupByLibrary.simpleMessage("Loading..."),
        "log": MessageLookupByLibrary.simpleMessage("Log"),
        "logDesc": MessageLookupByLibrary.simpleMessage(
            "Organize Mode saved in the Target Folder, Rename Mode saved in the Documents Folder of drive C"),
        "match": MessageLookupByLibrary.simpleMessage("Matching"),
        "matchHint": MessageLookupByLibrary.simpleMessage("Matching content"),
        "matchLength":
            MessageLookupByLibrary.simpleMessage("Number or length string"),
        "matchName": MessageLookupByLibrary.simpleMessage("Match name"),
        "modifiedDate": MessageLookupByLibrary.simpleMessage("Modified"),
        "modifiedTime": MessageLookupByLibrary.simpleMessage("Modified date"),
        "modifyName": MessageLookupByLibrary.simpleMessage("Modify name"),
        "modifyTo": MessageLookupByLibrary.simpleMessage("Modify to"),
        "moveError": MessageLookupByLibrary.simpleMessage("Moving error"),
        "moveFailed": MessageLookupByLibrary.simpleMessage("Move failed"),
        "newName": MessageLookupByLibrary.simpleMessage("New name"),
        "newVersionInfo": m5,
        "noNewVersionInfo": MessageLookupByLibrary.simpleMessage(
            "Currently in the latest version"),
        "notExist": MessageLookupByLibrary.simpleMessage("not exist"),
        "notExistsError": m6,
        "openFolder": MessageLookupByLibrary.simpleMessage("Open Folder"),
        "openFolderDesc": MessageLookupByLibrary.simpleMessage(
            "Double-click on the list of files on the right to quickly open the folder where the file is located"),
        "organize": MessageLookupByLibrary.simpleMessage("Organize"),
        "organizeDesc":
            MessageLookupByLibrary.simpleMessage("Enable file organization"),
        "organizeFolderDesc": MessageLookupByLibrary.simpleMessage(
            "Move all added files or all sub-files under a folder into the destination folder"),
        "organizeLogs": MessageLookupByLibrary.simpleMessage("organize logs"),
        "organizeMenu": MessageLookupByLibrary.simpleMessage("Organize menu"),
        "organizedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Organized successfully"),
        "organizedSuccessfullyInfo": MessageLookupByLibrary.simpleMessage(
            "Successfully moved all files"),
        "organizingFailed":
            MessageLookupByLibrary.simpleMessage("Organizing failed"),
        "organizingFailedInfo":
            MessageLookupByLibrary.simpleMessage("The following moves failed"),
        "originalName": MessageLookupByLibrary.simpleMessage("Original name"),
        "other": MessageLookupByLibrary.simpleMessage("Other"),
        "prefix": MessageLookupByLibrary.simpleMessage("Prefix"),
        "prefixContent":
            MessageLookupByLibrary.simpleMessage("Add prefix content"),
        "removeNonImage": m7,
        "renameLogs": MessageLookupByLibrary.simpleMessage("rename logs"),
        "renameName": MessageLookupByLibrary.simpleMessage("Rename name"),
        "replace": MessageLookupByLibrary.simpleMessage("Replace"),
        "reserve": MessageLookupByLibrary.simpleMessage("Reserve"),
        "restartTip":
            MessageLookupByLibrary.simpleMessage("Restart takes effect"),
        "saveConfig":
            MessageLookupByLibrary.simpleMessage("Saved Configurations"),
        "saveLog": MessageLookupByLibrary.simpleMessage(
            "Save log (In the User Documents folder on the C drive)"),
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "selectAllSwitch":
            MessageLookupByLibrary.simpleMessage("Select All Switch"),
        "selectFolder": MessageLookupByLibrary.simpleMessage("Select folder"),
        "selectTargetFolder":
            MessageLookupByLibrary.simpleMessage("Select target folder"),
        "serial": MessageLookupByLibrary.simpleMessage("Serial"),
        "start": MessageLookupByLibrary.simpleMessage("start"),
        "successInfo": MessageLookupByLibrary.simpleMessage(
            "Successfully deleted all empty folders"),
        "successful":
            MessageLookupByLibrary.simpleMessage("Renaming successful"),
        "successfulNum": m8,
        "suffix": MessageLookupByLibrary.simpleMessage("Suffix"),
        "suffixContent":
            MessageLookupByLibrary.simpleMessage("Add suffix content"),
        "swapPrefixDesc": MessageLookupByLibrary.simpleMessage(
            "Swap prefixes and incremental number positions"),
        "swapSuffixDesc": MessageLookupByLibrary.simpleMessage(
            "Swap suffixes and incremental number positions"),
        "tableInfo": MessageLookupByLibrary.simpleMessage(
            "Selected original name column: "),
        "takeTime": MessageLookupByLibrary.simpleMessage("Time"),
        "targetFolder": MessageLookupByLibrary.simpleMessage("Target folder"),
        "targetFolderDesc": MessageLookupByLibrary.simpleMessage(
            "Defaults to the parent folder of the first file added to the list or the folder itself"),
        "text": MessageLookupByLibrary.simpleMessage("Text"),
        "tip":
            MessageLookupByLibrary.simpleMessage("Drag the File/Folder here"),
        "tipImage": MessageLookupByLibrary.simpleMessage(
            "Drag the Picture File/Folder here"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "tvSeriesInfo":
            MessageLookupByLibrary.simpleMessage("Get episode info"),
        "undo": MessageLookupByLibrary.simpleMessage("Undo"),
        "undoFailed":
            MessageLookupByLibrary.simpleMessage("Undo rename failed"),
        "undoFailedNum": m9,
        "undoSuccessful":
            MessageLookupByLibrary.simpleMessage("Undo Successful"),
        "undoSuccessfulNum": m10,
        "unselect": MessageLookupByLibrary.simpleMessage("Unselect"),
        "uploadCSV": MessageLookupByLibrary.simpleMessage(
            "Upload CSV and TXT files with \",\" separating old and new names, or OPLOG file generated by OncePower"),
        "uploadDesc": MessageLookupByLibrary.simpleMessage("Upload .txt file"),
        "useDesc": MessageLookupByLibrary.simpleMessage("Instructions for use"),
        "video": MessageLookupByLibrary.simpleMessage("Video"),
        "viewMode": MessageLookupByLibrary.simpleMessage("View mode"),
        "zip": MessageLookupByLibrary.simpleMessage("Zip")
      };
}

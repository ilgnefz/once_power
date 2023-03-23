import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:once_power/model/my_file.dart';
import 'package:once_power/model/my_type.dart';
import 'package:once_power/utils/format.dart';
import 'package:nanoid/nanoid.dart';
import 'package:path/path.dart' as path;

class ActionProvider extends ChangeNotifier {
  bool _caseSensitive = false;
  bool get caseSensitive => _caseSensitive;
  bool _reservedMode = false;
  bool get reservedMode => _reservedMode;
  bool _createDateRename = false;
  bool get createDateRename => _createDateRename;
  bool _useLoop = false;
  bool get useLoop => _useLoop;
  bool _numAddBefore = false;
  bool get numAddBefore => _numAddBefore;
  bool _numAddAfter = false;
  bool get numAddAfter => _numAddAfter;
  bool _addPrefixNum = false;
  bool get addPrefixNum => _addPrefixNum;
  bool _addSuffixNum = false;
  bool get addSuffixNum => _addSuffixNum;
  // bool _appendMode = false;
  // bool get appendMode => _appendMode;
  bool _appendMode = false;
  bool get appendMode => _appendMode;
  bool _folderMode = false;
  bool get folderMode => _folderMode;
  bool _openUseType = false;
  bool get openUseType => _openUseType;

  switchUse(String value) {
    if (value == 'caseSensitive') {
      _caseSensitive = !_caseSensitive;
      updateName();
    }
    if (value == 'reservedMode') _reservedMode = !_reservedMode;
    if (value == 'createDateRename') {
      _createDateRename = !_createDateRename;
      updateName();
    }
    if (value == 'useLoop') _useLoop = !_useLoop;
    if (value == 'numAddBefore') _numAddBefore = !_numAddBefore;
    if (value == 'numAddAfter') _numAddAfter = !_numAddAfter;
    if (value == 'addPrefixNum') _addPrefixNum = !_addPrefixNum;
    if (value == 'addSuffixNum') _addSuffixNum = !_addSuffixNum;
    if (value == 'appendMode') _appendMode = !_appendMode;
    if (value == 'folderMode') _folderMode = !_folderMode;
    if (value == 'openUseType') _openUseType = !_openUseType;
    notifyListeners();
  }

  ModeType _modeType = ModeType.general;
  ModeType get modeType => _modeType;
  toggleModeType(ModeType value) {
    _modeType = value;
    notifyListeners();
  }

  UseType _useType = UseType.no;
  UseType get useType => _useType;
  toggleUseType(UseType value) {
    _useType = value;
    notifyListeners();
  }

  final List<MyFile> _files = [];
  List<MyFile> get files => _files;

  getDir() async {
    if (!appendMode) _files.clear();
    String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir != null) getAllFile(dir);
    notifyListeners();
  }

  getFile() async {
    if (!appendMode) _files.clear();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result != null) {
      var files = result.files;
      for (var value in files) {
        addFile(value);
      }
      notifyListeners();
    }
  }

  getAllFile(dir, [String? newPath]) {
    Directory directory = Directory(dir);
    List<FileSystemEntity> allFile = directory.listSync();
    if (allFile.isNotEmpty) {
      if (newPath != null) return allFile.any((e) => e.path == newPath);
      for (var value in allFile) {
        if (value.statSync().type == FileSystemEntityType.directory) {
          getAllFile(value.path);
        } else {
          addFile(value);
        }
      }
    }
  }

  addFile(value) {
    String name = path.basename(value.path).split('.').first;
    if (_files.any((e) => e.name == name)) return;
    var id = nanoid(10);
    String extension = path.extension(value.path).replaceFirst('.', '');
    _files.add(
      MyFile(
        id: id,
        name: name,
        newName: name,
        parent: path.dirname(value.path),
        extension: extension,
        createDate: File(value.path).statSync().changed,
        type: getFileType(extension),
        checked: true,
      ),
    );
  }

  clearFiles() {
    _files.clear();
    notifyListeners();
  }

  getFileType(String extension) {
    final image = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    final video = ['mp4', 'avi', 'mov', 'wmv', 'flv'];
    final text = ['txt', 'doc', 'docx', 'pdf', 'xlsx', 'md', 'ppt'];
    if (image.contains(extension)) return CustomFileType.image;
    if (video.contains(extension)) return CustomFileType.video;
    if (text.contains(extension)) return CustomFileType.text;
    return CustomFileType.other;
  }

  final TextEditingController matchText = TextEditingController();
  final TextEditingController targetText = TextEditingController();
  final TextEditingController prefixText = TextEditingController();
  final TextEditingController suffixText = TextEditingController();
  final TextEditingController prefixNumText = TextEditingController();
  final TextEditingController suffixNumText = TextEditingController();

  bool _originNull = true;
  bool get originNull => _originNull;
  bool _targetNull = true;
  bool get targetNull => _targetNull;
  bool _prefixNull = true;
  bool get prefixNull => _prefixNull;
  bool _suffixNull = true;
  bool get suffixNull => _suffixNull;
  bool _prefixNumNull = true;
  bool get prefixNumNull => _prefixNumNull;
  bool _suffixNumNull = true;
  bool get suffixNumNull => _suffixNumNull;

  ActionProvider() {
    matchText.addListener(() {
      _originNull = !matchText.text.isNotEmpty;
      notifyListeners();
    });
    targetText.addListener(() {
      _targetNull = !targetText.text.isNotEmpty;
      notifyListeners();
    });
    prefixText.addListener(() {
      _prefixNull = !prefixText.text.isNotEmpty;
      _openUseType = prefixText.text.isNotEmpty;
      notifyListeners();
    });
    suffixText.addListener(() {
      _suffixNull = !suffixText.text.isNotEmpty;
      _openUseType = suffixText.text.isNotEmpty;
      notifyListeners();
    });
    prefixNumText.addListener(() {
      _prefixNumNull = !prefixNumText.text.isNotEmpty;
      notifyListeners();
    });
    suffixNumText.addListener(() {
      _suffixNumNull = !suffixNumText.text.isNotEmpty;
      notifyListeners();
    });
  }

  doubleTapAdd(String value) {
    matchText.text = value;
    notifyListeners();
  }

  inputChange(value) {
    updateName();
  }

  clearInput(TextEditingController controller, [UploadType? type]) {
    controller.clear();
    if (type == UploadType.prefix) _uploadPrefixText.clear();
    if (type == UploadType.suffix) _uploadSuffixText.clear();
    updateName();
    notifyListeners();
  }

  final List<String> _uploadPrefixText = [];
  bool get uploadPrefixText => _uploadPrefixText.isNotEmpty;
  final List<String> _uploadSuffixText = [];
  bool get uploadSuffixText => _uploadSuffixText.isNotEmpty;

  uploadText(TextEditingController controller, UploadType type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      controller.text = path.basename(file.path);
      var content = file.readAsStringSync();
      if (type == UploadType.prefix) uploadTextAdd(_uploadPrefixText, content);
      if (type == UploadType.suffix) uploadTextAdd(_uploadSuffixText, content);
      notifyListeners();
    }
  }

  uploadTextAdd(List<String> list, String content) {
    list.clear();
    if (content.contains('\n')) {
      list.addAll(content.split('\r\n'));
    } else {
      list.addAll(content.split(' '));
    }
  }

  switchCheck(String id) {
    for (var file in _files) {
      if (file.id == id) file.checked = !file.checked;
    }
    updateName();
    notifyListeners();
  }

  bool get _selectedAll => _files.every((element) => element.checked == true);
  bool get selectedAll => _selectedAll;
  switchSelectedAll() {
    if (_selectedAll) {
      for (var file in _files) {
        file.checked = false;
      }
    } else {
      for (var file in _files) {
        file.checked = true;
      }
    }
    notifyListeners();
  }

  reorderList(oldIndex, newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = files.removeAt(oldIndex);
    files.insert(newIndex, item);
    updateName();
    notifyListeners();
  }

  updateName() {
    var index = 0;
    for (var file in _files) {
      if (file.checked) {
        index++;
        if (modeType == ModeType.general) generalMode(file, index);
        if (modeType == ModeType.reserved) {}
        if (modeType == ModeType.length) {}
      } else {
        file.newName = file.name;
      }
    }
    notifyListeners();
  }

  generalMode(MyFile file, int index) {
    file.newName = formatNumber(index, prefixNumText.text.length) +
        prefixText.text +
        file.name +
        suffixText.text +
        formatNumber(index, suffixNumText.text.length);
    if (matchText.text.isNotEmpty) {
      var index = caseSensitive
          ? file.newName.indexOf(matchText.text)
          : file.newName.toLowerCase().indexOf(matchText.text.toLowerCase());
      if (index != -1) {
        var splitString = caseSensitive
            ? matchText.text
            : file.newName.substring(index, index + matchText.text.length);
        var arr = file.newName.split(splitString);
        var createText = createDateRename
            ? formatDateTime(file.createDate)
            : targetText.text;
        arr.insert(1, createText);
        file.newName = arr.join('');
      }
    }
    notifyListeners();
  }

  applyChange() {
    for (var file in _files) {
      if (file.checked) {
        var oldPath = path.join(file.parent, '${file.name}.${file.extension}');
        var newPath =
            path.join(file.parent, '${file.newName.trim()}.${file.extension}');
        debugPrint(oldPath);
        debugPrint(newPath);
        try {
          if (getAllFile(file.parent, newPath)) {
            print('更名失败，目录下已存在同名文件');
            return;
          }
          File(oldPath).renameSync(newPath);
          print('文件名更改成功');
        } catch (e) {
          print('文件名更改失败');
        }
        file.name = path.basename(newPath).split('.').first;
      }
    }
    notifyListeners();
  }
}

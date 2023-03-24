import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:once_power/model/my_file.dart';
import 'package:once_power/model/my_type.dart';
import 'package:once_power/pages/setting.dart';
import 'package:once_power/utils/format.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/utils/toast.dart';
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
  bool _appendMode = false;
  bool get appendMode => _appendMode;
  bool _changePosition = false;
  bool get changePosition => _changePosition;
  bool _folderMode = false;
  bool get folderMode => _folderMode;
  bool _openUseType = false;
  bool get openUseType => _openUseType;
  bool _showUnselected = true;
  bool get showUnselected => _showUnselected;

  bool get _selectedImage =>
      _files.any((e) => e.type == CustomFileType.image && e.checked);
  bool get _selectedAudio =>
      _files.any((e) => e.type == CustomFileType.audio && e.checked);
  bool get _selectedText =>
      _files.any((e) => e.type == CustomFileType.text && e.checked);
  bool get _selectedVideo =>
      _files.any((e) => e.type == CustomFileType.video && e.checked);
  bool get _selectedFolder =>
      _files.any((e) => e.type == CustomFileType.folder && e.checked);
  bool get _selectedOther =>
      _files.any((e) => e.type == CustomFileType.other && e.checked);

  adaptSelect(value) {
    if (value == '图片') return _selectedImage;
    if (value == '音频') return _selectedAudio;
    if (value == '文档') return _selectedText;
    if (value == '视频') return _selectedVideo;
    if (value == '文件夹') return _selectedFolder;
    if (value == '其他') return _selectedOther;
    return false;
  }

  popupCheckbox(String value, String name, CustomFileType type, bool checked) {
    if (value == name) {
      // 点击时判断当前是true还是false
      // 如果是true，判断子元素是不是全部是true，全部是true就全变成false，全部不是就变成true
      // 如果是是false，就全变成true
      var typeList = _files.where((e) => e.type == type).toList();
      if (checked) {
        if (typeList.every((e) => e.checked)) {
          for (var e in _files) {
            if (e.type == type) e.checked = false;
          }
        } else {
          for (var e in _files) {
            if (e.type == type) e.checked = true;
          }
        }
      } else {
        for (var e in _files) {
          if (e.type == type) e.checked = true;
        }
      }
    }
  }

  switchUse(String value) {
    popupCheckbox(value, '图片', CustomFileType.image, _selectedImage);
    popupCheckbox(value, '音频', CustomFileType.audio, _selectedAudio);
    popupCheckbox(value, '文档', CustomFileType.text, _selectedText);
    popupCheckbox(value, '视频', CustomFileType.video, _selectedVideo);
    popupCheckbox(value, '文件夹', CustomFileType.folder, _selectedFolder);
    popupCheckbox(value, '其他', CustomFileType.other, _selectedOther);
    if (value == 'caseSensitive') _caseSensitive = !_caseSensitive;
    if (value == 'reservedMode') _reservedMode = !_reservedMode;
    if (value == 'createDateRename') _createDateRename = !_createDateRename;
    if (value == 'changePosition') _changePosition = !_changePosition;

    updateName();

    if (value == 'useLoop') _useLoop = !_useLoop;
    if (value == 'numAddBefore') _numAddBefore = !_numAddBefore;
    if (value == 'numAddAfter') _numAddAfter = !_numAddAfter;
    if (value == 'addPrefixNum') _addPrefixNum = !_addPrefixNum;
    if (value == 'addSuffixNum') _addSuffixNum = !_addSuffixNum;
    if (value == 'appendMode') _appendMode = !_appendMode;
    if (value == 'folderMode') _folderMode = !_folderMode;
    if (value == 'openUseType') _openUseType = !_openUseType;
    if (value == 'showUnselected') {
      _showUnselected = !_showUnselected;
      if (!_showUnselected) {
        _oldFolders.addAll(_files);
        _files.removeWhere((value) => value.checked == false);
      } else {
        _files.clear();
        _files.addAll(_oldFolders);
        _oldFolders.clear();
      }
    }
    notifyListeners();
  }

  ModeType _modeType = ModeType.general;
  ModeType get modeType => _modeType;
  toggleModeType(ModeType value) {
    _modeType = value;
    updateName();
    notifyListeners();
  }

  UseType _useType = UseType.no;
  UseType get useType => _useType;
  toggleUseType(UseType value) {
    _useType = value;
    updateName();
    notifyListeners();
  }

  final List<MyFile> _folders = [];
  List<MyFile> get folders => _folders;
  final List<MyFile> _oldFolders = [];
  final List<MyFile> _files = [];
  List<MyFile> get files => _files;

  int get filesCount => _files.length;
  int get selectedFilesCount => _files.where((e) => e.checked == true).length;
  int get unselectedFilesCount =>
      _files.where((e) => e.checked == false).length;

  Set<CustomFileType> get fileTypeList => {
        if (_files.any((e) => image.contains(e.extension)))
          CustomFileType.image,
        if (_files.any((e) => video.contains(e.extension)))
          CustomFileType.video,
        if (_files.any((e) => text.contains(e.extension))) CustomFileType.text,
        if (_files.any((e) => audio.contains(e.extension)))
          CustomFileType.audio,
        if (_files.any((e) => folder.contains(e.extension)))
          CustomFileType.folder,
        if (_files.isNotEmpty &&
            !_files.any((e) => [
                  ...image,
                  ...video,
                  ...text,
                  ...audio,
                  ...folder
                ].contains(e.extension)))
          CustomFileType.other,
      };

  removeUnselected() {
    if (unselectedFilesCount != 0) {
      _files.removeWhere((value) => value.checked == false);
    } else {
      Toast.show('删除失败，因为没有可以删除的内容...', MessageType.failure);
    }
    notifyListeners();
  }

  getDir() async {
    if (!appendMode) _files.clear();
    String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir != null) getAllFile(dir);
    updateName();
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
        verifyExtension(value);
      }
      updateName();
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
          if (folderMode) addFolder(value);
          getAllFile(value.path);
        } else {
          verifyExtension(value);
        }
      }
    }
  }

  verifyExtension(value) {
    String extension = path.extension(value.path).replaceFirst('.', '');
    if (!filter.contains(extension) && !folderMode) {
      addFile(value, extension);
    }
  }

  addFolder(FileSystemEntity value) {
    String name = path.basename(value.path);
    if (_files.any((e) => e.name == name)) return;
    var id = nanoid(10);
    _files.add(
      MyFile(
        id: id,
        name: name,
        newName: name,
        parent: path.dirname(value.path),
        extension: 'dir',
        createDate: value.statSync().changed,
        type: CustomFileType.folder,
        checked: true,
      ),
    );
  }

  addFile(value, extension) {
    String name = path.basename(value.path).split('.').first;
    if (_files.any((e) => e.name == name)) return;
    var id = nanoid(10);
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
    _oldFolders.clear();
    notifyListeners();
  }

  getFileType(String? extension) {
    if (image.contains(extension)) return CustomFileType.image;
    if (video.contains(extension)) return CustomFileType.video;
    if (text.contains(extension)) return CustomFileType.text;
    if (audio.contains(extension)) return CustomFileType.audio;
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
    updateName();
    notifyListeners();
  }

  inputChange(value) => updateName();

  clearInput(TextEditingController controller, [UploadType? type]) {
    controller.clear();
    if (type == UploadType.prefix) _prefixUploadContent.clear();
    if (type == UploadType.suffix) _suffixUploadContent.clear();
    updateName();
    notifyListeners();
  }

  final List<String> _prefixUploadContent = [];
  final List<String> _suffixUploadContent = [];
  uploadText(TextEditingController controller, UploadType type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      controller.text = path.basename(file.path);
      var content = file.readAsStringSync();
      if (type == UploadType.prefix) {
        uploadTextAdd(_prefixUploadContent, content);
      }
      if (type == UploadType.suffix) {
        uploadTextAdd(_suffixUploadContent, content);
      }
      updateName();
      notifyListeners();
    }
  }

  uploadTextAdd(List<String> list, String content) {
    list.clear();
    if (content.contains('\n')) {
      list.addAll(content.split('\r\n'));
    } else if (content.contains(' ')) {
      list.addAll(content.split(' '));
    } else {
      Toast.show('请使用换行或空格进行分隔', MessageType.failure);
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
    updateName();
    notifyListeners();
  }

  reorderList(oldIndex, newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = files.removeAt(oldIndex);
    files.insert(newIndex, item);
    updateName();
    notifyListeners();
  }

  updateFileContent(List<String> list, UseType type, int index) {
    var value = list.first;
    if (list.length > 1) {
      if (_useType == UseType.no || _useType == type) {
        value = index < list.length ? list[index] : '';
      } else {
        value = list[index % list.length];
      }
    }
    return value;
  }

  updateName() {
    var index = 0;
    for (var file in _files) {
      if (file.checked) {
        index++;
        var fileName = file.name;
        if (modeType == ModeType.general) fileName = generalMode(file);
        if (modeType == ModeType.reserved) fileName = useReservedMode(file);
        if (modeType == ModeType.length) fileName = lengthMode(file);
        List<String> prefixContent = _prefixUploadContent.isNotEmpty
            ? _prefixUploadContent
            : [prefixText.text];
        List<String> suffixContent = _suffixUploadContent.isNotEmpty
            ? _suffixUploadContent
            : [suffixText.text];
        String prefix = updateFileContent(prefixContent, UseType.suffix, index);
        String suffix = updateFileContent(suffixContent, UseType.prefix, index);
        String prefixNum = formatNumber(index, prefixNumText.text.length);
        String suffixNum = formatNumber(index, suffixNumText.text.length);
        if (changePosition) {
          file.newName = prefix + prefixNum + fileName + suffixNum + suffix;
        } else {
          file.newName = prefixNum + prefix + fileName + suffix + suffixNum;
        }
      } else {
        file.newName = file.name;
      }
    }
    notifyListeners();
  }

  String generalMode(MyFile file) {
    var fileName = file.name;
    if (matchText.text.isNotEmpty) {
      var index = caseSensitive
          ? file.name.indexOf(matchText.text)
          : file.name.toLowerCase().indexOf(matchText.text.toLowerCase());
      if (index != -1) {
        var splitString = caseSensitive
            ? matchText.text
            : file.name.substring(index, index + matchText.text.length);
        var arr = file.name.split(splitString);
        var createText = createDateRename
            ? formatDateTime(file.createDate)
            : targetText.text;
        arr.insert(1, createText);
        fileName = arr.join('');
      }
    }
    return fileName;
  }

  String useReservedMode(MyFile file) {
    var fileName = '';
    if (matchText.text.isNotEmpty) {
      var index = caseSensitive
          ? file.name.indexOf(matchText.text)
          : file.name.toLowerCase().indexOf(matchText.text.toLowerCase());
      if (index != -1) {
        var splitString = caseSensitive
            ? matchText.text
            : file.name.substring(index, index + matchText.text.length);
        fileName = splitString;
      }
    }
    if (createDateRename) fileName = formatDateTime(file.createDate);
    return fileName;
  }

  String lengthMode(MyFile file) {
    var fileName = file.name;
    if (matchText.text.isNotEmpty) {
      int num = file.name.length;
      if (matchText.text.startsWith('*')) {
        var value = matchText.text.substring(1);
        if (value.isNotEmpty) {
          if (int.tryParse(value) != null) {
            num = int.parse(value);
          } else if (double.tryParse(value) != null) {
            num = double.parse(value).toInt();
          } else {
            Toast.show('请输入正确的数字', MessageType.failure);
          }
        }
      } else {
        num = matchText.text.length;
      }
      fileName =
          file.name.substring(0, num > fileName.length ? fileName.length : num);
    }
    return fileName;
  }

  applyChange() {
    for (var file in _files) {
      if (file.checked) {
        if (file.name == file.newName) return;
        var extension = file.extension == 'dir' ? '' : '.${file.extension}';
        var oldPath = path.join(file.parent, '${file.name}$extension');
        var newPath =
            path.join(file.parent, '${file.newName.trim()}$extension');
        try {
          if (getAllFile(file.parent, newPath)) {
            Toast.show('目录下已存在同名文件，请重新更名后再试', MessageType.failure);
            return;
          }
          if (file.extension == 'dir') {
            Directory(oldPath).renameSync(newPath);
          } else {
            File(oldPath).renameSync(newPath);
          }
          Toast.show('所选文件已更名成功', MessageType.success);
          file.name = path.basename(newPath).split('.').first;
        } catch (e) {
          Toast.show('更名失败！报错信息：$e', MessageType.failure);
        }
      }
    }
    notifyListeners();
  }

  toSetting(BuildContext context) {
    showDialog(context: context, builder: (context) => const SettingPage());
  }
}

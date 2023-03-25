import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/pages/other/other.dart';
import 'package:once_power/utils/format.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/utils/toast.dart';
import 'package:path/path.dart' as path;

class RenameProvider extends ChangeNotifier {
  bool _caseSensitive = false;
  bool get caseSensitive => _caseSensitive;
  bool _createDateRename = false;
  bool get createDateRename => _createDateRename;
  bool _useLoop = false;
  bool get useLoop => _useLoop;
  bool _numAddBefore = false;
  bool get numAddBefore => _numAddBefore;
  bool _numAddAfter = false;
  bool get numAddAfter => _numAddAfter;
  bool _appendMode = false;
  bool get appendMode => _appendMode;
  bool _exchangeSeat = false;
  bool get exchangeSeat => _exchangeSeat;
  bool _folderMode = false;
  bool get folderMode => _folderMode;
  bool _openLoopType = false;
  bool get openLoopType => _openLoopType;
  bool _popupShowUnselected = true;
  bool get showUnselected => _popupShowUnselected;

  bool get _popupSelectedImage =>
      _files.any((e) => e.type == FileClassify.image && e.checked);
  bool get _popupSelectedAudio =>
      _files.any((e) => e.type == FileClassify.audio && e.checked);
  bool get _popupSelectedText =>
      _files.any((e) => e.type == FileClassify.text && e.checked);
  bool get _popupSelectedVideo =>
      _files.any((e) => e.type == FileClassify.video && e.checked);
  bool get _popupSelectedFolder =>
      _files.any((e) => e.type == FileClassify.folder && e.checked);
  bool get _popupSelectedOther =>
      _files.any((e) => e.type == FileClassify.other && e.checked);

  bool popupTypeSelect(value) {
    if (value == S.current.image) return _popupSelectedImage;
    if (value == S.current.audio) return _popupSelectedAudio;
    if (value == S.current.text) return _popupSelectedText;
    if (value == S.current.video) return _popupSelectedVideo;
    if (value == S.current.folder) return _popupSelectedFolder;
    if (value == S.current.other) return _popupSelectedOther;
    return false;
  }

  void popupSwitchCheck(
      String key, String name, FileClassify type, bool checked) {
    if (key == name) {
      // 点击时判断当前是true还是false
      // 如果是true，判断子元素是不是全部是true，全部是true就全变成false，全部不是就变成true
      // 如果是是false，就全变成true
      var typeList = _files.where((e) => e.type == type).toList();
      if (checked) {
        if (typeList.every((e) => e.checked)) {
          for (RenameFile file in _files) {
            if (file.type == type) file.checked = false;
          }
        } else {
          for (RenameFile file in _files) {
            if (file.type == type) file.checked = true;
          }
        }
      } else {
        for (RenameFile file in _files) {
          if (file.type == type) file.checked = true;
        }
      }
    }
  }

  void toggleCheck(String key) {
    popupSwitchCheck(
        key, S.current.image, FileClassify.image, _popupSelectedImage);
    popupSwitchCheck(
        key, S.current.audio, FileClassify.audio, _popupSelectedAudio);
    popupSwitchCheck(
        key, S.current.text, FileClassify.text, _popupSelectedText);
    popupSwitchCheck(
        key, S.current.video, FileClassify.video, _popupSelectedVideo);
    popupSwitchCheck(
        key, S.current.folder, FileClassify.folder, _popupSelectedFolder);
    popupSwitchCheck(
        key, S.current.other, FileClassify.other, _popupSelectedOther);
    if (key == 'caseSensitive') _caseSensitive = !_caseSensitive;
    if (key == 'createDateRename') _createDateRename = !_createDateRename;
    if (key == 'changePosition') _exchangeSeat = !_exchangeSeat;

    updateName();

    if (key == 'useLoop') _useLoop = !_useLoop;
    if (key == 'numAddBefore') _numAddBefore = !_numAddBefore;
    if (key == 'numAddAfter') _numAddAfter = !_numAddAfter;
    if (key == 'appendMode') _appendMode = !_appendMode;
    if (key == 'folderMode') _folderMode = !_folderMode;
    if (key == 'openUseType') _openLoopType = !_openLoopType;
    if (key == 'showUnselected') {
      _popupShowUnselected = !_popupShowUnselected;
      if (!_popupShowUnselected) {
        _tempFiles.addAll(_files);
        _files.removeWhere((e) => e.checked == false);
      } else {
        _files.clear();
        _files.addAll(_tempFiles);
        _tempFiles.clear();
      }
    }
    notifyListeners();
  }

  ModeType _modeType = ModeType.general;
  ModeType get modeType => _modeType;
  void switchModeType(ModeType type) {
    _modeType = type;
    updateTextController.clear();
    updateName();
  }

  LoopType _loopType = LoopType.disable;
  LoopType get loopType => _loopType;
  void toggleLoopType(LoopType type) {
    _loopType = type;
    updateName();
  }

  final List<RenameFile> _folders = [];
  List<RenameFile> get folders => _folders;
  final List<RenameFile> _tempFiles = [];
  final List<RenameFile> _files = [];
  List<RenameFile> get files => _files;

  int get filesCount => _files.length;
  int get selectedFilesCount => _files.where((e) => e.checked == true).length;
  int get unselectedFilesCount => selectedFilesCount - filesCount;

  Set<FileClassify> get fileTypeList => {
        if (_files.any((e) => image.contains(e.extension))) FileClassify.image,
        if (_files.any((e) => video.contains(e.extension))) FileClassify.video,
        if (_files.any((e) => text.contains(e.extension))) FileClassify.text,
        if (_files.any((e) => audio.contains(e.extension))) FileClassify.audio,
        if (_files.any((e) => folder.contains(e.extension)))
          FileClassify.folder,
        if (_files.isNotEmpty &&
            !_files.any((e) => [
                  ...image,
                  ...video,
                  ...text,
                  ...audio,
                  ...folder
                ].contains(e.extension)))
          FileClassify.other,
      };

  void deleteUnselected() {
    if (unselectedFilesCount != 0) {
      _files.removeWhere((e) => e.checked == false);
      notifyListeners();
    } else {
      Toast.show(S.current.deleteFailed, S.current.deleteFailedText,
          MessageType.failure);
    }
  }

  void getDir() async {
    if (!appendMode) _files.clear();
    String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir != null) getAllFile(dir);
    updateName();
  }

  void getFile() async {
    if (!appendMode) _files.clear();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result != null) {
      List<PlatformFile> files = result.files;
      for (PlatformFile file in files) {
        verifyExtension(file);
      }
      updateName();
    }
  }

  getAllFile(dir, [String? newPath]) {
    Directory directory = Directory(dir);
    List<FileSystemEntity> files = directory.listSync();
    if (files.isNotEmpty) {
      if (newPath != null) return files.any((e) => e.path == newPath);
      for (FileSystemEntity file in files) {
        if (file.statSync().type == FileSystemEntityType.directory) {
          if (folderMode) addToFiles(file, 'dir', FileClassify.folder);
          getAllFile(file.path);
        } else {
          verifyExtension(file);
        }
      }
    }
  }

  void verifyExtension(file) {
    String extension = path.extension(file.path).replaceFirst('.', '');
    if (!filter.contains(extension) && !folderMode) {
      addToFiles(file, extension, getFileClassify(extension));
    }
  }

  void addToFiles(dynamic file, String extension, FileClassify type) {
    String name = type == FileClassify.folder
        ? path.basename(file.path)
        : path.basename(file.path).split('.').first;
    if (_files.any((e) => e.name == name)) return;
    String id = nanoid(10);
    DateTime createDateTime = type == FileClassify.folder
        ? file.statSync().changed
        : File(file.path).statSync().changed;
    _files.add(
      RenameFile(
        id: id,
        name: name,
        newName: name,
        parent: path.dirname(file.path),
        extension: extension,
        createDate: createDateTime,
        type: type,
        checked: true,
      ),
    );
  }

  void clearFiles() {
    _files.clear();
    _tempFiles.clear();
    notifyListeners();
  }

  FileClassify getFileClassify(String extension) {
    if (image.contains(extension)) return FileClassify.image;
    if (video.contains(extension)) return FileClassify.video;
    if (text.contains(extension)) return FileClassify.text;
    if (audio.contains(extension)) return FileClassify.audio;
    return FileClassify.other;
  }

  final TextEditingController matchTextController = TextEditingController();
  final TextEditingController updateTextController = TextEditingController();
  final TextEditingController prefixTextController = TextEditingController();
  final TextEditingController suffixTextController = TextEditingController();
  final TextEditingController prefixNumController = TextEditingController();
  final TextEditingController suffixNumController = TextEditingController();

  bool _matchEmpty = true;
  bool get matchEmpty => _matchEmpty;
  bool _updateEmpty = true;
  bool get updateEmpty => _updateEmpty;
  bool _prefixEmpty = true;
  bool get prefixEmpty => _prefixEmpty;
  bool _suffixEmpty = true;
  bool get suffixEmpty => _suffixEmpty;
  bool _prefixNumEmpty = true;
  bool get prefixNumEmpty => _prefixNumEmpty;
  bool _suffixNumEmpty = true;
  bool get suffixNumEmpty => _suffixNumEmpty;

  RenameProvider() {
    matchTextController.addListener(() {
      _matchEmpty = !matchTextController.text.isNotEmpty;
      notifyListeners();
    });
    updateTextController.addListener(() {
      _updateEmpty = !updateTextController.text.isNotEmpty;
      notifyListeners();
    });
    prefixTextController.addListener(() {
      _prefixEmpty = !prefixTextController.text.isNotEmpty;
      _openLoopType = prefixTextController.text.isNotEmpty;
      notifyListeners();
    });
    suffixTextController.addListener(() {
      _suffixEmpty = !suffixTextController.text.isNotEmpty;
      _openLoopType = suffixTextController.text.isNotEmpty;
      notifyListeners();
    });
    prefixNumController.addListener(() {
      _prefixNumEmpty = !prefixNumController.text.isNotEmpty;
      notifyListeners();
    });
    suffixNumController.addListener(() {
      _suffixNumEmpty = !suffixNumController.text.isNotEmpty;
      notifyListeners();
    });
  }

  void doubleTapAdd(String value) {
    matchTextController.text = value;
    updateName();
  }

  void clearInput(TextEditingController controller, [UploadType? type]) {
    controller.clear();
    if (type == UploadType.prefix) _prefixUploadContent.clear();
    if (type == UploadType.suffix) _suffixUploadContent.clear();
    updateName();
  }

  final List<String> _prefixUploadContent = [];
  String _prefixFileName = '';
  final List<String> _suffixUploadContent = [];
  String _suffixFileName = '';

  void uploadContent(TextEditingController controller, UploadType type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      var content = file.readAsStringSync();
      if (type == UploadType.prefix) {
        uploadContentAdd(_prefixUploadContent, content);
      }
      if (type == UploadType.suffix) {
        uploadContentAdd(_suffixUploadContent, content);
      }
      if (_prefixUploadContent.isNotEmpty || _suffixUploadContent.isNotEmpty) {
        String fileName = path.basename(file.path);
        controller.text = fileName;
        _prefixFileName = _prefixUploadContent.isNotEmpty ? fileName : '';
        _suffixFileName = _suffixUploadContent.isNotEmpty ? fileName : '';
      }
      updateName();
    }
  }

  void uploadContentAdd(List<String> list, String content) {
    list.clear();
    if (content.contains('\n')) {
      list.addAll(content.split('\r\n'));
    } else if (content.contains(' ')) {
      list.addAll(content.split(' '));
    } else {
      Toast.show(S.current.uploadFailed, S.current.uploadFailedText,
          MessageType.warning);
    }
  }

  void listSwitchCheck(String id) {
    for (RenameFile file in _files) {
      if (file.id == id) file.checked = !file.checked;
      updateName();
    }
  }

  bool get _selectAll => _files.every((element) => element.checked == true);
  bool get selectedAll => _selectAll;
  void toggleSelectAll() {
    if (_selectAll) {
      for (RenameFile file in _files) {
        file.checked = false;
      }
    } else {
      for (RenameFile file in _files) {
        file.checked = true;
      }
    }
    updateName();
  }

  void reorderList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    RenameFile item = _files.removeAt(oldIndex);
    _files.insert(newIndex, item);
    updateName();
  }

  String updateExtraName(List<String> list, LoopType type, int index) {
    String value = list.first;
    if (list.length > 1) {
      if (_loopType == LoopType.disable || _loopType == type) {
        value = index < list.length ? list[index] : '';
      } else {
        value = list[index % list.length];
      }
    }
    return value;
  }

  void updateName() {
    if (_files.isNotEmpty) {
      int index = 0;
      for (RenameFile file in _files) {
        if (file.checked) {
          String fileName = file.name;
          if (modeType == ModeType.general) fileName = generalMode(file);
          if (modeType == ModeType.reserved) fileName = reservedMode(file);
          if (modeType == ModeType.length) fileName = lengthMode(file);
          List<String> prefixContent = _prefixUploadContent.isNotEmpty
              ? _prefixUploadContent
              : [prefixTextController.text];
          List<String> suffixContent = _suffixUploadContent.isNotEmpty
              ? _suffixUploadContent
              : [suffixTextController.text];
          String prefix =
              updateExtraName(prefixContent, LoopType.suffix, index);
          String suffix =
              updateExtraName(suffixContent, LoopType.prefix, index);
          String prefixNum =
              formatNumber(index, prefixNumController.text.length);
          String suffixNum =
              formatNumber(index, suffixNumController.text.length);
          if (_prefixUploadContent.isNotEmpty) {
            List<String> extraMark =
                prefixTextController.text.split(_prefixFileName);
            extraMark.insert(1, prefix);
            prefix = extraMark.join('');
          }
          if (_suffixUploadContent.isNotEmpty) {
            List<String> extraMark =
                suffixTextController.text.split(_suffixFileName);
            extraMark.insert(1, suffix);
            suffix = extraMark.join('');
          }
          if (exchangeSeat) {
            file.newName = prefix + prefixNum + fileName + suffixNum + suffix;
          } else {
            file.newName = prefixNum + prefix + fileName + suffix + suffixNum;
          }
          index++;
        } else {
          file.newName = file.name;
        }
      }
    }
    notifyListeners();
  }

  String generalMode(RenameFile file) {
    String fileName = file.name;
    if (matchTextController.text.isNotEmpty) {
      int index = getMatchPosition(file);
      if (index != -1) {
        String splitString = getSplitString(index, file);
        List<String> arr = file.name.split(splitString);
        String createText = createDateRename
            ? formatDateTime(file.createDate)
            : updateTextController.text;
        arr.insert(1, createText);
        fileName = arr.join('');
      }
    }
    return fileName;
  }

  String reservedMode(RenameFile file) {
    String fileName = '';
    if (matchTextController.text.isNotEmpty) {
      int index = getMatchPosition(file);
      if (index != -1) {
        String splitString = getSplitString(index, file);
        fileName = splitString;
      }
    }
    if (createDateRename) fileName = formatDateTime(file.createDate);
    return fileName;
  }

  String lengthMode(RenameFile file) {
    var fileName = file.name;
    if (matchTextController.text.isNotEmpty) {
      int num = file.name.length;
      if (matchTextController.text.startsWith('*')) {
        String value = matchTextController.text.substring(1);
        if (value.isNotEmpty) {
          if (int.tryParse(value) != null) {
            num = int.parse(value);
          } else if (double.tryParse(value) != null) {
            num = double.parse(value).toInt();
          } else {
            Toast.show(S.current.inputError, S.current.inputErrorText,
                MessageType.warning);
          }
        }
      } else {
        num = matchTextController.text.length;
      }
      fileName =
          file.name.substring(0, num > fileName.length ? fileName.length : num);
    }
    return fileName;
  }

  int getMatchPosition(RenameFile file) {
    return caseSensitive
        ? file.name.indexOf(matchTextController.text)
        : file.name
            .toLowerCase()
            .indexOf(matchTextController.text.toLowerCase());
  }

  String getSplitString(int index, RenameFile file) {
    return caseSensitive
        ? matchTextController.text
        : file.name.substring(index, index + matchTextController.text.length);
  }

  void applyChange() {
    for (RenameFile file in _files) {
      if (file.checked) {
        if (file.name == file.newName) return;
        var extension = file.extension == 'dir' ? '' : '.${file.extension}';
        var oldPath = path.join(file.parent, '${file.name}$extension');
        var newPath =
            path.join(file.parent, '${file.newName.trim()}$extension');
        try {
          if (getAllFile(file.parent, newPath)) {
            Toast.show(S.current.renameFailed, S.current.renameFailedText,
                MessageType.failure);
            return;
          }
          if (file.extension == 'dir') {
            Directory(oldPath).renameSync(newPath);
          } else {
            File(oldPath).renameSync(newPath);
          }
          Toast.show(
              S.current.renameSucceeded,
              S.current.renameSucceededText(selectedFilesCount),
              MessageType.success);
          file.name = path.basename(newPath).split('.').first;
        } catch (e) {
          Toast.show(S.current.renameFailed, '$e', MessageType.failure);
        }
      }
    }
    notifyListeners();
  }

  void toOther(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const OtherPage()),
    );
  }
}

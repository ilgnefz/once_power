import 'dart:async';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:exif/exif.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/error_message.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/pages/other/other.dart';
import 'package:once_power/utils/format.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/utils/notification.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:path/path.dart' as path;

class RenameProvider extends ChangeNotifier {
  // 定义进度条相关数据
  int _total = 0;
  int get total => _total;
  int _count = 0;
  int get count => _count;
  // 控制添加进度
  final StreamController<String> _addStream =
      StreamController<String>.broadcast();
  StreamSubscription<String>? _addSubscription;
  final StreamController<RenameFile> _renameStream =
      StreamController<RenameFile>.broadcast();
  StreamSubscription<RenameFile>? _renameSubscription;
  // 加载界面的提示信息
  String _loadingMessage = S.current.adding;
  String get loadingMessage => _loadingMessage;
  // 输入框的控制器
  final TextEditingController matchTextController = TextEditingController();
  final TextEditingController updateTextController = TextEditingController();
  final TextEditingController prefixTextController = TextEditingController();
  final TextEditingController suffixTextController = TextEditingController();
  final TextEditingController prefixNumController = TextEditingController();
  final TextEditingController suffixNumController = TextEditingController();
  // 监听输入
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
  // 退出时销毁控制器
  @override
  void dispose() {
    matchTextController.dispose();
    updateTextController.dispose();
    prefixTextController.dispose();
    suffixTextController.dispose();
    prefixNumController.dispose();
    suffixNumController.dispose();
    _addSubscription?.cancel();
    _renameSubscription?.cancel();
    super.dispose();
  }

  // 订阅监听添加流
  void subscriptionAddStream() {
    _addSubscription = _addStream.stream.listen((String filePath) async {
      if (_files.any((e) => e.filePath == filePath)) return;
      FileSystemEntity file = File(filePath);
      // 如果是文件就获取文件扩展名，否则扩展名为'dir'
      String extension = 'dir';
      String name = path.basename(filePath);
      DateTime? exifDate;
      if (FileSystemEntity.isFileSync(filePath)) {
        extension = path.extension(filePath);
        if (extension != '') {
          extension = extension.replaceFirst('.', '');
          int extensionIndex = name.lastIndexOf('.');
          name = name.substring(0, extensionIndex);
        }
      }
      // 如果文件不是过滤文件里的
      if (!filter.contains(extension)) {
        String id = nanoid(10);
        FileClassify type = getFileClassify(extension);
        DateTime createDate = file.statSync().changed;
        DateTime modifyDate = file.statSync().modified;
        // 获取图片拍摄日期
        if (image.contains(extension)) exifDate = await imageExifInfo(filePath);
        _files.add(
          RenameFile(
            id: id,
            name: name,
            newName: name,
            parent: path.dirname(filePath),
            filePath: filePath,
            extension: extension,
            createDate: createDate,
            modifyDate: modifyDate,
            exifDate: exifDate,
            type: type,
            checked: true,
          ),
        );
        notifyListeners();
      }
    });
  }

  Future<DateTime?> imageExifInfo(String imagePath) async {
    final fileBytes = File(imagePath).readAsBytesSync();
    final data = await readExifFromBytes(fileBytes);
    if (!data.containsKey('Image DateTime')) return null;
    String? dateTime = data['Image DateTime'].toString();
    if (dateTime == '') return null;
    return exifDateFormat(dateTime);
  }

  int _doneCount = 0;
  // 订阅重命名流
  void subscriptionRenameStream() {
    _renameSubscription = _renameStream.stream.listen((file) {
      if (file.name == file.newName) {
        return _errorList.add(
          ErrorMessage(
            fileName: file.name,
            reason: S.current.renameFailedUnmodified,
            time: DateTime.now(),
          ),
        );
      }
      var extension = file.extension == 'dir' ? '' : '.${file.extension}';
      var oldPath = path.join(file.parent, '${file.name}$extension');
      var newPath = path.join(file.parent, '${file.newName.trim()}$extension');
      try {
        if (File(newPath).existsSync()) {
          return _errorList.add(ErrorMessage(
            fileName: file.name,
            reason: S.current.renameFailedExists,
            time: DateTime.now(),
          ));
        }
        if (file.extension == 'dir') Directory(oldPath).renameSync(newPath);
        if (file.extension != 'dir') File(oldPath).renameSync(newPath);
        _doneCount++;
        file.name = path.basename(newPath).split('.').first;
        notifyListeners();
      } catch (e) {
        _errorList.add(ErrorMessage(
            fileName: file.name, reason: '$e', time: DateTime.now()));
      }
    });
  }

  // 取消监听
  void cancelOperate() async {
    if (loadingMessage == S.current.adding) {
      await _addSubscription?.cancel().then((value) => _addSubscription = null);
    } else {
      await _renameSubscription
          ?.cancel()
          .then((value) => _renameSubscription = null);
    }
    _total = 0;
    _count = 0;
    updateName();
    // notifyListeners();
  }

  // 控制是否选中
  bool _caseSensitive = false;
  bool get caseSensitive => _caseSensitive;
  bool _deleteLength = false;
  bool get deleteLength => _deleteLength;
  bool _dateRename = false;
  bool get dateRename => _dateRename;
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

  // 弹窗切换选中逻辑
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
    if (key == 'deleteLength') _deleteLength = !_deleteLength;
    if (key == 'dateRename') _dateRename = !_dateRename;
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

  // 切换使用模式
  ModeType _modeType = ModeType.general;
  ModeType get modeType => _modeType;
  void switchModeType(ModeType type) {
    _modeType = type;
    updateTextController.clear();
    updateName();
  }

  // 切换使用模式
  DateType _dateType = DateType.createDate;
  DateType get dateType => _dateType;
  void switchDateType(DateType type) {
    _dateType = type;
    updateTextController.clear();
    updateName();
  }

  // 循环模式
  LoopType _loopType = LoopType.disable;
  LoopType get loopType => _loopType;
  void toggleLoopType(LoopType type) {
    _loopType = type;
    updateName();
  }

  // 存储上传内容的数组
  final List<RenameFile> _folders = [];
  List<RenameFile> get folders => _folders;
  final List<RenameFile> _tempFiles = [];
  final List<RenameFile> _files = [];
  List<RenameFile> get files => _files;

  int get filesCount => _files.length;
  int get selectedFilesCount => _files.where((e) => e.checked == true).length;
  int get unselectedFilesCount => selectedFilesCount - filesCount;

  // 设置文件的类型
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

  // 删除未选中项
  void deleteUnselected() {
    if (unselectedFilesCount != 0) {
      _files.removeWhere((e) => e.checked == false);
      notifyListeners();
    } else {
      NotificationMessage.show(S.current.deleteFailed,
          S.current.deleteFailedText, MessageType.failure);
    }
  }

  void initAdd() {
    _loadingMessage = S.current.adding;
    if (!appendMode) _files.clear();
    if (_addSubscription == null) subscriptionAddStream();
  }

  // 通过“选择文件”按钮添加文件
  void getFile() async {
    initAdd();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result != null) addFile(result.files);
  }

  // 通过“选择文件夹”按钮添加文件
  void getDir() async {
    initAdd();
    String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir != null) addFile([Directory(dir)]);
  }

  // 通过拖动添加文件
  void dropFiles(DropDoneDetails detail) async {
    initAdd();
    final List<XFile> files = detail.files;
    addFile(files);
  }

  void addFile(List<dynamic> fileList) {
    final List<String> filePathList = [];
    for (var file in fileList) {
      if (folderMode) {
        filePathList.add(file.path);
      } else {
        if (FileSystemEntity.isDirectorySync(file.path)) {
          List<String> children = getAllFile(file.path);
          filePathList.addAll(children);
        } else {
          filePathList.add(file.path);
        }
      }
    }
    _total = filePathList.length;
    for (String filePath in filePathList) {
      _count++;
      _addStream.add(filePath);
    }
    _total = 0;
    _count = 0;
    updateName();
  }

  // 获取文件夹下的所有子文件
  List<String> getAllFile(dir) {
    Directory directory = Directory(dir);
    List<FileSystemEntity> files = directory.listSync(recursive: true);
    List<String> list = [];
    // 获取文件夹下的所有子文件夹
    if (files.isNotEmpty) {
      for (FileSystemEntity file in files) {
        if (FileSystemEntity.isFileSync(file.path)) {
          String extension = path.extension(file.path).replaceFirst('.', '');
          if (!filter.contains(extension)) list.add(file.path);
        }
      }
    }
    return list;
  }

  // 清除所有文件
  void clearFiles() {
    _files.clear();
    _tempFiles.clear();
    notifyListeners();
  }

  // 获取文件类型
  FileClassify getFileClassify(String extension) {
    if (image.contains(extension)) return FileClassify.image;
    if (video.contains(extension)) return FileClassify.video;
    if (text.contains(extension)) return FileClassify.text;
    if (audio.contains(extension)) return FileClassify.audio;
    return FileClassify.other;
  }

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

  // 双击添加
  void doubleTapAdd(String value) {
    matchTextController.text = value;
    updateName();
  }

  // 清除输入
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

  // 上传文件读取内容
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

  // 将读取的内容添加进来
  void uploadContentAdd(List<String> list, String content) {
    list.clear();
    if (content.contains('\n')) {
      list.addAll(content.split('\r\n'));
    } else if (content.contains(' ')) {
      list.addAll(content.split(' '));
    } else {
      NotificationMessage.show(S.current.uploadFailed,
          S.current.uploadFailedText, MessageType.warning);
    }
  }

  // 是否选中文件
  void listSwitchCheck(String id) {
    for (RenameFile file in _files) {
      if (file.id == id) file.checked = !file.checked;
      updateName();
    }
  }

  // 全选
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

  // 更换添加的文件位置
  void reorderList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    RenameFile item = _files.removeAt(oldIndex);
    _files.insert(newIndex, item);
    updateName();
  }

  // 更新扩展名
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

  String getFileDate(RenameFile file) {
    List<DateTime> list = [file.createDate, file.modifyDate];
    if (file.exifDate != null) list.add(file.exifDate!);
    list.sort();
    if (dateType == DateType.modifyDate) {
      return formatDateTime(file.modifyDate);
    }
    if (dateType == DateType.exifDate) {
      DateTime dateTime = file.exifDate ?? list.first;
      return formatDateTime(dateTime);
    }
    if (dateType == DateType.earliestDate) {
      return formatDateTime(list.first);
    }
    if (dateType == DateType.latestDate) {
      return formatDateTime(list.last);
    }
    return formatDateTime(file.createDate);
  }

  // 默认模式
  String generalMode(RenameFile file) {
    String fileName = file.name;
    if (matchTextController.text.isNotEmpty) {
      // 获取匹配的内容是不是在选中的文件名中
      int index = getMatchPosition(file);
      if (index != -1) {
        String splitString = getSplitString(index, file);
        int splitIndex = file.name.indexOf(splitString);
        List<String> arr = [
          file.name.substring(0, splitIndex),
          file.name.substring(splitIndex + splitString.length),
        ];
        String dateText =
            dateRename ? getFileDate(file) : updateTextController.text;
        arr.insert(1, dateText);
        fileName = arr.join('');
      }
    }
    return fileName;
  }

  // 保留模式
  String reservedMode(RenameFile file) {
    String fileName = '';
    if (matchTextController.text.isNotEmpty) {
      int index = getMatchPosition(file);
      if (index != -1) {
        String splitString = getSplitString(index, file);
        fileName = splitString;
      }
    }
    if (dateRename) fileName = getFileDate(file);
    return fileName;
  }

  // 长度模式
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
            NotificationMessage.show(S.current.inputError,
                S.current.inputErrorText, MessageType.warning);
          }
        }
      } else {
        num = matchTextController.text.length;
      }
      if (_deleteLength) {
        fileName =
            file.name.substring(num > fileName.length ? fileName.length : num);
      } else {
        fileName = file.name
            .substring(0, num > fileName.length ? fileName.length : num);
      }
    }
    return fileName;
  }

  // 获取匹配的位置
  int getMatchPosition(RenameFile file) {
    return caseSensitive
        ? file.name.indexOf(matchTextController.text)
        : file.name
            .toLowerCase()
            .indexOf(matchTextController.text.toLowerCase());
  }

  // 获取分割的字符
  String getSplitString(int index, RenameFile file) {
    return caseSensitive
        ? matchTextController.text
        : file.name.substring(index, index + matchTextController.text.length);
  }

  final List<ErrorMessage> _errorList = [];
  List<ErrorMessage> get errorList => _errorList;

  String _errorMessage = '';

  // 更新名称
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

  // 应用改变
  void applyChange() {
    _loadingMessage = S.current.processing;
    if (_renameSubscription == null) subscriptionRenameStream();
    _total = _files.where((e) => e.checked == true).toList().length;
    for (RenameFile file in _files) {
      if (file.checked) {
        _count++;
        _renameStream.add(file);
        notifyListeners();
      }
    }
    if (_errorList.isNotEmpty) {
      showError();
    } else {
      NotificationMessage.show(
        S.current.renameSucceeded,
        S.current.renameSucceededText(selectedFilesCount, _doneCount),
        MessageType.success,
      );
    }
    _total = 0;
    _count = 0;
    _doneCount = 0;
    notifyListeners();
  }

  void showError() {
    if (_errorList.length == 1) {
      NotificationMessage.show(S.current.renameFailed, _errorList.single.reason,
          MessageType.failure);
    } else {
      Map<String, List<String>> errorGroup = {};
      for (ErrorMessage error in _errorList) {
        if (!errorGroup.containsKey(error.reason)) {
          errorGroup[error.reason] = [];
        }
        errorGroup[error.reason]?.add(error.fileName);
      }
      int index = 1;
      for (var key in errorGroup.keys) {
        List<String>? value = errorGroup[key];
        _errorMessage += S.current.multiFailedText(
            value?.join('、') as Object, value?.length as Object, key);
        index++;
        if (index < errorGroup.length) _errorMessage += '\n';
      }
      NotificationMessage.show(S.current.renameFailed, _errorMessage,
          MessageType.failure, copyError);
      _errorList.clear();
      _errorMessage = '';
    }
  }

  // 复制错误内容
  void copyError() {
    Pasteboard.writeText(_errorMessage);
    _errorMessage = '';
    NotificationMessage.show(S.current.copySucceeded,
        S.current.copySucceededText, MessageType.success);
    notifyListeners();
  }

  void toOther(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const OtherPage()),
    );
  }
}

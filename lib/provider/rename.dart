import 'dart:async';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:exif/exif.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/global.dart';
import 'package:once_power/model/error_message.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/model/values.dart';
import 'package:once_power/pages/other/other.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/notification.dart';
import 'package:once_power/utils/storage.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:path/path.dart' as path;

class RenameProvider extends ChangeNotifier {
  // 定义进度条相关数据
  int _total = 0;
  int get total => _total;
  int _count = 0;
  int get count => _count;

  // 加载界面的提示信息
  String _loadingMessage = S.current.adding;
  String get loadingMessage => _loadingMessage;
  // 输入框的控制器
  final TextEditingController matchTextController = TextEditingController();
  final TextEditingController updateTextController = TextEditingController();
  final TextEditingController dateDigitsController =
      TextEditingController(text: Global.dateLength ?? '14');
  final TextEditingController prefixTextController = TextEditingController();
  final TextEditingController suffixTextController = TextEditingController();
  final TextEditingController prefixNumController =
      TextEditingController(text: Global.prefixNum);
  final TextEditingController suffixNumController =
      TextEditingController(text: Global.suffixNum);
  final TextEditingController startNumController =
      TextEditingController(text: Global.startNum);
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
    dateDigitsController.addListener(() {
      StorageUtil().setString(AppValue.dateLength, dateDigitsController.text);
      updateName();
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
      StorageUtil().setString(AppValue.prefixNum, prefixNumController.text);
      notifyListeners();
    });
    suffixNumController.addListener(() {
      _suffixNumEmpty = !suffixNumController.text.isNotEmpty;
      StorageUtil().setString(AppValue.suffixNum, suffixNumController.text);
      notifyListeners();
    });
    startNumController.addListener(() {
      _startNumEmpty = !startNumController.text.isNotEmpty;
      StorageUtil().setString(AppValue.startNum, startNumController.text);
      notifyListeners();
    });
  }
  // 退出时销毁控制器
  @override
  void dispose() {
    matchTextController.dispose();
    updateTextController.dispose();
    dateDigitsController.dispose();
    prefixTextController.dispose();
    suffixTextController.dispose();
    prefixNumController.dispose();
    suffixNumController.dispose();
    startNumController.dispose();
    super.dispose();
  }

  // 获取图片的exif信息
  Future<DateTime?> imageExifInfo(String imagePath) async {
    final fileBytes = File(imagePath).readAsBytesSync();
    final data = await readExifFromBytes(fileBytes);
    if (!data.containsKey('Image DateTime')) return null;
    String? dateTime = data['Image DateTime'].toString();
    if (dateTime == '') return null;
    debugPrint('$imagePath拍摄日期: ${exifDateFormat(dateTime)}');
    return exifDateFormat(dateTime);
  }

  void cancelOperate() async {
    _total = 0;
    _count = 0;
    updateName();
  }

  // 控制是否选中
  bool _caseSensitive = Global.caseSensitive ?? false;
  bool get caseSensitive => _caseSensitive;
  bool _deleteLength = Global.deleteLength ?? false;
  bool get deleteLength => _deleteLength;
  bool _dateRename = Global.dateRename ?? false;
  bool get dateRename => _dateRename;
  bool _useLoop = false;
  bool get useLoop => _useLoop;
  // bool _numAddBefore = false;
  // bool get numAddBefore => _numAddBefore;
  // bool _numAddAfter = false;
  // bool get numAddAfter => _numAddAfter;
  bool _appendMode = Global.appendMode ?? false;
  bool get appendMode => _appendMode;
  bool _exchangeSeat = Global.exchangeSeat ?? false;
  bool get exchangeSeat => _exchangeSeat;
  bool _addFolder = Global.addFolder ?? false;
  bool get addFolder => _addFolder;
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

  // 列表右上角弹出菜单选项
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
      // 点击时判断当前是 true 还是 false
      // 如果是 true，判断子元素是不是全部是 true，全部是 true 就全变成 false，全部不是就变成 true
      // 如果全是 false，就全变成 true
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
    if (key == 'caseSensitive') {
      _caseSensitive = !_caseSensitive;
      StorageUtil().setBool(AppValue.caseSensitive, _caseSensitive);
    }
    if (key == 'deleteLength') {
      _deleteLength = !_deleteLength;
      StorageUtil().setBool(AppValue.deleteLength, _deleteLength);
    }
    if (key == 'dateRename') {
      _dateRename = !_dateRename;
      StorageUtil().setBool(AppValue.dateRename, _dateRename);
    }
    if (key == 'changePosition') {
      _exchangeSeat = !_exchangeSeat;
      StorageUtil().setBool(AppValue.exchangeSeat, _exchangeSeat);
    }
    updateName();
    if (key == 'useLoop') _useLoop = !_useLoop;
    // if (key == 'numAddBefore') _numAddBefore = !_numAddBefore;
    // if (key == 'numAddAfter') _numAddAfter = !_numAddAfter;
    if (key == 'appendMode') {
      _appendMode = !_appendMode;
      StorageUtil().setBool(AppValue.appendMode, _appendMode);
    }
    if (key == 'addFolder') {
      _addFolder = !_addFolder;
      StorageUtil().setBool(AppValue.addFolder, _addFolder);
    }
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
  ModeType _modeType = Global.modeType ?? ModeType.general;
  ModeType get modeType => _modeType;
  void switchModeType(ModeType type) async {
    _modeType = type;
    await StorageUtil().setInt(AppValue.modeType, _modeType.index);
    updateTextController.clear();
    updateName();
  }

  // 保留精准模式
  final List<ReservedType> _reservedTypeList = [];
  List<ReservedType> get reservedTypeList => _reservedTypeList;
  void toggleReservedType(ReservedType type) {
    if (_reservedTypeList.contains(type)) {
      _reservedTypeList.remove(type);
    } else {
      _reservedTypeList.add(type);
    }
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

  // 临时文件数组，用来存储数据来实现显示和隐藏效果
  final List<RenameFile> _tempFiles = [];
  // 所有上传的文件或文件夹
  final List<RenameFile> _files = [];
  List<RenameFile> get files => _files;

  // 统计文件数量
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

  // 添加前初始化内容
  void initAdd() {
    _loadingMessage = S.current.adding;
    if (!appendMode) _files.clear();
  }

  // 选择文件添加
  void selectFileAdd() async {
    initAdd();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result != null) addFile(result.files);
    // updateName();
  }

  // 选择文件夹添加
  void selectFolderAdd() async {
    initAdd();
    String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir != null) addFile([Directory(dir)]);
    // updateName();
  }

  // 拖动文件添加
  void dropAdd(DropDoneDetails details) {
    initAdd();
    List<XFile> xFileList = details.files;
    addFile(xFileList);
  }

  // 处理所有文件
  void addFile(List<dynamic> files) async {
    List<String> filePathList = [];
    for (var file in files) {
      if (!addFolder) {
        // 没有选择添加文件夹时，根据是不是文件夹来处理不同逻辑
        FileSystemEntity.isDirectorySync(file.path)
            ? filePathList.addAll(getAllFile(file.path))
            : filePathList.add(file.path);
      } else {
        // 选择了添加文件夹直接处理
        filePathList.add(file.path);
      }
    }
    for (String filePath in filePathList) {
      try {
        await fileToList(filePath);
      } catch (e) {
        _errorList.add(
          ErrorMessage(
            fileName: filePath,
            reason: S.current.renameFailedUnmodified,
            time: DateTime.now(),
          ),
        );
      }
    }
    updateName();
  }

  // 获取所有子文件
  List<String> getAllFile(String filePath) {
    Directory directory = Directory(filePath);
    List<String> children = [];
    // recursive 可以直接获取所有子文件和文件夹，不用循环
    List<FileSystemEntity> files = directory.listSync(recursive: true);
    if (files.isNotEmpty) {
      for (FileSystemEntity file in files) {
        // 过滤文件（过滤的文件类型定义在 model/types 中）
        // 不过滤会造成修改时报错【无权限】
        if (FileSystemEntity.isFileSync(file.path)) {
          String extension = path.extension(file.path);
          extension = extension == '' ? extension : extension.substring(1);
          if (!filter.contains(extension)) children.add(file.path);
        }
      }
    }
    return children;
  }

  fileToList(String filePath) async {
    // 如果推荐的文件已经存在列表就返回
    if (_files.any((e) => e.filePath == filePath)) return;
    _order = true;
    String id = nanoid(10);
    String name = path.basename(filePath);
    // 默认设置为 dir（文件夹）
    String extension = 'dir';
    DateTime createDate = File(filePath).statSync().changed;
    DateTime modifyDate = File(filePath).statSync().modified;
    // 图片类型以为的默认设置为 null
    DateTime? exifDate;
    // 如果是文件就获取扩展名
    if (FileSystemEntity.isFileSync(filePath)) {
      extension = path.extension(filePath);
      // 有可能文件没有扩展名
      if (extension != '') {
        name = name.split(extension).first;
        extension = extension.substring(1);
      }
      // 如果是图片就获取 exif 中的拍摄日期
      if (image.contains(extension)) {
        exifDate = await imageExifInfo(filePath);
      }
    }
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
        type: getFileClassify(extension),
        checked: true,
      ),
    );
    // notifyListeners();
  }

  // 清除所有文件
  void clearFiles() {
    _files.clear();
    _tempFiles.clear();
    notifyListeners();
  }

  // 排序
  bool _order = true;
  bool get order => _order;
  void sortFiles() {
    if (_order) {
      _files.sort((a, b) => a.name.compareTo(b.name));
    } else {
      _files.sort((a, b) => b.name.compareTo(a.name));
    }
    _order = !_order;
    updateName();
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
  bool _startNumEmpty = true;
  bool get startNumEmpty => _startNumEmpty;

  // 双击将名称添加到匹配内容输入框
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

  // 前缀和后缀上传的文件读取其内容
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
    // 如果内容包含换行就以换行进行分割，否则使用空格分割
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

  // 全选切换
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

  // 拖动更换添加的文件排序位置
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

  // 获取文件用日期命名时需要的日期
  String getFileDate(RenameFile file) {
    // 因为 exifDate 可能为空，所以这里暂时只排序其他两个
    List<DateTime> list = [file.createDate, file.modifyDate];
    if (file.exifDate != null) list.add(file.exifDate!);
    list.sort();
    late String date;
    late int dateDigit;
    if (dateDigitsController.text == '' ||
        int.parse(dateDigitsController.text) < 0 ||
        int.parse(dateDigitsController.text) > 14) {
      dateDigit = 14;
    } else {
      dateDigit = int.parse(dateDigitsController.text);
    }
    if (dateType == DateType.modifyDate) {
      date = formatDateTime(file.modifyDate);
    }
    if (dateType == DateType.exifDate) {
      DateTime dateTime = file.exifDate ?? list.first;
      date = formatDateTime(dateTime);
    }
    if (dateType == DateType.earliestDate) {
      date = formatDateTime(list.first);
    }
    if (dateType == DateType.latestDate) {
      date = formatDateTime(list.last);
    }
    if (dateType == DateType.createDate) {
      date = formatDateTime(file.createDate);
    }
    // notifyListeners();
    return date.substring(0, dateDigit);
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
        // 使用第一个匹配的内容分割文件名
        List<String> arr = [
          file.name.substring(0, splitIndex),
          file.name.substring(splitIndex + splitString.length),
        ];
        // 如果选了以日期命名就用日期代替匹配的内容
        String addText =
            dateRename ? getFileDate(file) : updateTextController.text;
        arr.insert(1, addText);
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
    } else {
      bool lowercase = _reservedTypeList.contains(ReservedType.lowercaseLetter);
      bool capital = _reservedTypeList.contains(ReservedType.capitalLetter);
      bool digit = _reservedTypeList.contains(ReservedType.digit);
      bool nonLetter = _reservedTypeList.contains(ReservedType.nonLetter);
      bool punctuation = _reservedTypeList.contains(ReservedType.punctuation);
      String pattern = "";
      if (!lowercase) pattern += "a-z";
      if (!capital) pattern += "A-Z";
      if (!digit) pattern += "0-9";
      if (!nonLetter) {
        // 中文、日文、朝鲜文、藏文
        pattern +=
            r"\u4e00-\u9fff\u3040-\u309f\u30a0-\u30ff\uac00-\ud7af\u0f00-\u0fff";
      }
      if (!punctuation) {
        pattern += r"()\~!@#\$%\^&,'\.;_\[\]`\{\}\-=+！，。？：、‘’“”【】{}<>《》「」";
      }
      RegExp reg = RegExp("[$pattern]");
      fileName = file.name.replaceAll(reg, "");
    }
    if (dateRename) fileName = getFileDate(file);
    return fileName;
  }

  // 长度模式
  String lengthMode(RenameFile file) {
    var fileName = file.name;
    if (matchTextController.text.isNotEmpty) {
      int startNum = 0;
      int endNum = file.name.length;
      // 如果输入的内容以 * 开头
      if (matchTextController.text.startsWith('*')) {
        String value = matchTextController.text.substring(1);
        if (value.isNotEmpty) {
          // 判断是否还有 *
          int index = value.indexOf('*');
          if (index == -1) {
            // 判断输入的是不是 int 和 double 类型
            endNum = verifyNum(value) ?? 0;
          } else {
            List<String> arr = value.split('*');
            if (arr.length > 2) arr.sublist(0, 2);
            startNum = verifyNum(arr[0]) - 1 ?? 0;
            endNum = verifyNum(arr[1]) ?? endNum;
            if (startNum > endNum) endNum = startNum + 1;
          }
        }
      } else {
        // 不是 * 开头就直接使用输入文本的长度
        endNum = matchTextController.text.length;
      }
      // 删除指定长度，如果 startNum 大于数组长度，就等于数组长度
      startNum =
          startNum > fileName.length - 1 ? fileName.length - 1 : startNum;
      endNum = endNum > fileName.length ? fileName.length : endNum;
      if (_deleteLength) {
        // 如果是删除就截取两边的值
        String startStr = file.name.substring(0, startNum);
        String endStr = file.name.substring(endNum);
        String addText =
            dateRename ? getFileDate(file) : updateTextController.text;
        fileName = startStr + addText + endStr;
      } else {
        fileName = file.name.substring(startNum, endNum);
      }
    }
    return fileName;
  }

  // 判断 * 后输入的是否是数字
  dynamic verifyNum(String value) {
    if (int.tryParse(value) != null) {
      return int.parse(value);
    } else if (double.tryParse(value) != null) {
      return double.parse(value).toInt();
    } else {
      if (value != '') {
        NotificationMessage.show(S.current.inputError, S.current.inputErrorText,
            MessageType.warning);
      }
      return null;
    }
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

  // 存储错误信息
  final List<ErrorMessage> _errorList = [];
  List<ErrorMessage> get errorList => _errorList;

  String _errorMessage = '';

  // 更新名称
  void updateName() {
    if (_files.isNotEmpty) {
      // 重命名前后显示的序列
      int index = startNumController.text == ''
          ? 1
          : int.parse(startNumController.text);
      for (RenameFile file in _files) {
        // 只重命名选中的文件
        if (file.checked) {
          String fileName = file.name;
          // 根据不同的模式获取文件名
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
          // 将上传的文件内容放进文件名中
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
          // 交换前缀（后缀）和前缀（后缀）数字系列的位置
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

  int _doneCount = 0;
  // 应用改变
  void applyChange() {
    _loadingMessage = S.current.processing;
    // 统计所以的选择内容
    _total = _files.where((e) => e.checked == true).toList().length;
    for (RenameFile file in _files) {
      if (file.checked) {
        _count++;
        // 如果文件名没有更改
        if (file.name == file.newName) {
          _errorList.add(
            ErrorMessage(
              fileName: file.name,
              reason: S.current.renameFailedUnmodified,
              time: DateTime.now(),
            ),
          );
          continue;
        }
        var extension = file.extension == 'dir' ? '' : '.${file.extension}';
        var oldPath = path.join(file.parent, '${file.name}$extension');
        var newPath =
            path.join(file.parent, '${file.newName.trim()}$extension');
        try {
          // 如果新文件名已经存在就跳过
          if (File(newPath).existsSync()) {
            _errorList.add(ErrorMessage(
              fileName: file.name,
              reason: S.current.renameFailedExists,
              time: DateTime.now(),
            ));
            continue;
          }
          // 文件和文件夹重命名需要不同的方法
          if (file.extension == 'dir') Directory(oldPath).renameSync(newPath);
          if (file.extension != 'dir') File(oldPath).renameSync(newPath);
          _doneCount++;
          file.name = path.basename(newPath).split('.').first;
        } catch (e) {
          _errorList.add(ErrorMessage(
              fileName: file.name, reason: '$e', time: DateTime.now()));
        }
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
        if (index < errorGroup.length) _errorMessage += '\n';
        index++;
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

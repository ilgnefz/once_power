import 'package:once_power/model/file.dart';

class SelectionState {
  static final SelectionState _instance = SelectionState._internal();
  factory SelectionState() => _instance;
  SelectionState._internal();

  // 记录是否刚使用过 Ctrl 键进行多选
  static bool _filesPressedCtrl = false;
  static bool get filesPressedCtrl => _filesPressedCtrl;
  static void filesUpdate(bool value) => _filesPressedCtrl = value;

  static bool _menusPressedCtrl = false;
  static bool get menusPressedCtrl => _menusPressedCtrl;
  static void menusUpdate(bool value) => _menusPressedCtrl = value;
}

class SuspenseState {
  static final SuspenseState _instance = SuspenseState._internal();
  factory SuspenseState() => _instance;
  SuspenseState._internal();

  // 记录是否刚使用过 Ctrl 键进行多选
  static final List<FileInfo> _list = [];
  static List<FileInfo> get list => _list;

  static void addAll(List<FileInfo> file) => _list.addAll(file);

  static void clear() => _list.clear();
}

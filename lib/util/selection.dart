class SelectionState {
  static final SelectionState _instance = SelectionState._internal();
  factory SelectionState() => _instance;
  SelectionState._internal();

  // 记录是否刚使用过 Ctrl 键进行多选
  static bool _hadPressedCtrl = false;
  static bool get hadPressedCtrl => _hadPressedCtrl;

  static void update(bool value) {
    _hadPressedCtrl = value;
  }
}

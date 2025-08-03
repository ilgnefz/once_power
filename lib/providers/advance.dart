import 'package:once_power/constants/keys.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/utils/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'advance.g.dart';

@riverpod
class AdvanceMenuList extends _$AdvanceMenuList {
  @override
  List<AdvanceMenuModel> build() =>
      StorageUtil.getAdvanceList(AppKeys.advanceMenuList);

  void add(AdvanceMenuModel value) async {
    state = [...state, value];
    await StorageUtil.setAdvanceList(AppKeys.advanceMenuList, state);
  }

  void addAll(List<AdvanceMenuModel> value) async {
    state = [...state, ...value];
    await StorageUtil.setAdvanceList(AppKeys.advanceMenuList, state);
  }

  void toggle(AdvanceMenuModel value) async {
    state = state.map((e) {
      if (e.id == value.id) value.checked = !value.checked;
      return e;
    }).toList();
    await StorageUtil.setAdvanceList(AppKeys.advanceMenuList, state);
  }

  void remove(AdvanceMenuModel value) async {
    state = state.where((e) => e != value).toList();
    await StorageUtil.setAdvanceList(AppKeys.advanceMenuList, state);
  }

  void update(String id, AdvanceMenuModel value) async {
    state = state.map((e) {
      if (e.id == id) return value;
      return e;
    }).toList();
    await StorageUtil.setAdvanceList(AppKeys.advanceMenuList, state);
  }

  void setGroup(String id, String group) async {
    state = state.map((e) {
      if (e.id == id) e.group = group;
      return e;
    }).toList();
    await StorageUtil.setAdvanceList(AppKeys.advanceMenuList, state);
  }

  void setList(List<AdvanceMenuModel> list) async {
    state = list;
    await StorageUtil.setAdvanceList(AppKeys.advanceMenuList, state);
  }
}

@riverpod
class AdvancePresetList extends _$AdvancePresetList {
  @override
  List<AdvancePreset> build() =>
      StorageUtil.getAdvancePreset(AppKeys.advancePresetList);

  void add(AdvancePreset value) async {
    // 检查是否存在相同名称的预设，如果存在就将获得的 value.menus 覆盖
    int index = state.indexWhere((e) => e.name == value.name);
    if (index != -1) {
      state[index] = value;
    } else {
      state = [...state, value];
    }
    await StorageUtil.setAdvancePreset(AppKeys.advancePresetList, state);
  }

  void addAll(List<AdvancePreset> value) async {
    state = [...state, ...value];
    await StorageUtil.setAdvancePreset(AppKeys.advancePresetList, state);
  }

  void insert(int index, AdvancePreset value) async {
    state = [...state];
    state.insert(index, value);
    await StorageUtil.setAdvancePreset(AppKeys.advancePresetList, state);
  }

  void update(AdvancePreset value) async {
    state = state.map((e) {
      if (e.id == value.id) return value;
      return e;
    }).toList();
    await StorageUtil.setAdvancePreset(AppKeys.advancePresetList, state);
  }

  void remove(AdvancePreset value) async {
    state = state.where((e) => e != value).toList();
    await StorageUtil.setAdvancePreset(AppKeys.advancePresetList, state);
  }
}

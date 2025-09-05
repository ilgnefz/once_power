import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/utils/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'value.g.dart';

@riverpod
class DateLen extends _$DateLen {
  @override
  int build() => 8;
  void update(int value) => state = value;
}

@riverpod
class PrefixSerialLen extends _$PrefixSerialLen {
  @override
  int build() => StorageUtil.getInt(AppKeys.prefixSerialLen) ?? 0;
  Future<void> update(int value) async {
    state = value;
    await StorageUtil.setInt(AppKeys.prefixSerialLen, value);
  }
}

@riverpod
class PrefixSerialStart extends _$PrefixSerialStart {
  @override
  int build() => StorageUtil.getInt(AppKeys.prefixSerialStart) ?? 0;
  Future<void> update(int value) async {
    state = value;
    StorageUtil.setInt(AppKeys.prefixSerialStart, value);
  }
}

@riverpod
class SuffixSerialLen extends _$SuffixSerialLen {
  @override
  int build() => StorageUtil.getInt(AppKeys.suffixSerialLen) ?? 0;
  Future<void> update(int value) async {
    state = value;
    StorageUtil.setInt(AppKeys.suffixSerialLen, value);
  }
}

@riverpod
class SuffixSerialStart extends _$SuffixSerialStart {
  @override
  int build() => StorageUtil.getInt(AppKeys.suffixSerialStart) ?? 0;
  Future<void> update(int value) async {
    state = value;
    StorageUtil.setInt(AppKeys.suffixSerialStart, value);
  }
}

@riverpod
class CSVNameColumn extends _$CSVNameColumn {
  @override
  String build() => 'A';
  void update(String value) => state = value;
}

@riverpod
class ViewImageWidth extends _$ViewImageWidth {
  @override
  double build() => StorageUtil.getDouble(AppKeys.viewImageW) ?? AppNum.image;
  Future<void> update(bool left) async {
    List<double> list = AppNum.imageSizes;
    int index = list.indexOf(state);
    if (index == -1) {
      final tempList = List.from(list)
        ..add(state)
        ..sort();
      index = tempList.indexOf(state);
      if (index == 0) {
        index = -1;
      } else if (index != tempList.length - 1) {
        index = left ? index - 1 : index;
      }
    }
    if (!left) state = index > 0 ? list[index - 1] : state;
    if (left) state = index < list.length - 1 ? list[index + 1] : state;
    await StorageUtil.setDouble(AppKeys.viewImageW, state);
  }

  Future<void> set(double value) async {
    state = value;
    await StorageUtil.setDouble(AppKeys.viewImageW, state);
  }
}

@riverpod
class CurrentPresetName extends _$CurrentPresetName {
  @override
  String build() => StorageUtil.getString(AppKeys.currentPresetName) ?? '';
  Future<void> update(String value) async {
    state = value;
    await StorageUtil.setString(AppKeys.currentPresetName, value);
  }
}

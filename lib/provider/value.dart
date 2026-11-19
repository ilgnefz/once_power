import 'dart:async';

import 'package:once_power/constant/color.dart';
import 'package:once_power/constant/key.dart';
import 'package:once_power/enmu/match.dart';
import 'package:once_power/service/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'value.g.dart';

@riverpod
class SelectedReplaceType extends _$SelectedReplaceType {
  @override
  Set<ReplaceType> build() => {ReplaceType.match};
  void update(ReplaceType type) {
    if (state.contains(type)) {
      if (state.length == 1) return;
      state = state.where((e) => e != type).toSet();
    } else {
      if (state.length == 1) {
        state = type == ReplaceType.match || state.contains(ReplaceType.match)
            ? {...state, type}
            : {...state, type};
      } else if (state.length > 1) {
        state = {...state, ReplaceType.match, type};
      }
    }
    // StorageUtil.setReplaceTypeList(AppKeys.matchType, state);
  }
}

@riverpod
class SelectedKeepType extends _$SelectedKeepType {
  @override
  Set<KeepType> build() => {};
  void update(KeepType type) {
    state.contains(type)
        ? state = state.where((e) => e != type).toSet()
        : state = {...state, type};
    // StorageUtil.setKeepTypeList(AppKeys.reverseType, state);
  }
}

/// 分隔条比例是会话级偏好：没有监听者时也要留着，否则切走再回来就回到 1:1。
@Riverpod(keepAlive: true)
class SplitValues extends _$SplitValues {
  @override
  (int, int) build() => (1, 1);

  void update(List<double> ratios) {
    if (ratios.length < 2) return;
    final int left = (ratios[0] * 10000).round().clamp(0, 10000);
    final (int, int) next = (left, 10000 - left);
    if (state == next) return;
    state = next;
  }
}

@riverpod
class ThemeColor extends _$ThemeColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.color) ?? AppColors.themeSeeds.first;

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.color, value));
  }
}

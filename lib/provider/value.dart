import 'dart:async';

import 'package:once_power/constant/color.dart';
import 'package:once_power/constant/key.dart';
import 'package:once_power/enmu/match.dart';
import 'package:once_power/model/appearance.dart';
import 'package:once_power/service/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'switch.dart';
import 'toggle.dart';

part 'value.g.dart';

@riverpod
class SelectedReplaceType extends _$SelectedReplaceType {
  @override
  Set<ReplaceType> build() => StorageService.getEnumSet(
    AppKeys.matchType,
    ReplaceType.values,
    fallback: {ReplaceType.match},
  );
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
    unawaited(StorageService.setEnumSet(AppKeys.matchType, state));
  }
}

@riverpod
class SelectedKeepType extends _$SelectedKeepType {
  @override
  Set<KeepType> build() =>
      StorageService.getEnumSet(AppKeys.reverseType, KeepType.values);
  void update(KeepType type) {
    state.contains(type)
        ? state = state.where((e) => e != type).toSet()
        : state = {...state, type};
    unawaited(StorageService.setEnumSet(AppKeys.reverseType, state));
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

/* ---------- Appearance ---------- */
@riverpod
AppearanceSettings appearance(Ref ref) => AppearanceSettings(
  theme: ref.watch(currentThemeProvider),
  lightSeed: ref.watch(lightThemeColorProvider),
  darkSeed: ref.watch(darkThemeColorProvider),
  lightBackground: ref.watch(lightBackgroundColorProvider),
  darkBackground: ref.watch(darkBackgroundColorProvider),
  lightComponentSurface: ref.watch(lightComponentSurfaceColorProvider),
  darkComponentSurface: ref.watch(darkComponentSurfaceColorProvider),
  lightContainerSurface: ref.watch(lightContainerSurfaceColorProvider),
  darkContainerSurface: ref.watch(darkContainerSurfaceColorProvider),
  lightIcon: ref.watch(lightIconColorProvider),
  darkIcon: ref.watch(darkIconColorProvider),
  lightOutline: ref.watch(lightOutlineColorProvider),
  darkOutline: ref.watch(darkOutlineColorProvider),
  lightSync: ref.watch(isLightSyncProvider),
  darkSync: ref.watch(isDarkSyncProvider),
  lightTransparent: ref.watch(isLightTransparentProvider),
  darkTransparent: ref.watch(isDarkTransparentProvider),
);

@riverpod
class LightThemeColor extends _$LightThemeColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.lightColor) ?? AppColors.themeSeeds.first;

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.lightColor, value));
  }
}

@riverpod
class LightBackgroundColor extends _$LightBackgroundColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.lightBackgroundColor) ??
      AppColors.backgroundSeeds.first;

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.lightBackgroundColor, value));
  }
}

/// 控件底色：输入框 / 下拉面板 / 右键菜单 / tooltip 共用的表面色。
/// 同步背景打开时这些组件改成跟随页面背景，该值仅在不同步时生效。
@riverpod
class LightComponentSurfaceColor extends _$LightComponentSurfaceColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.lightComponentSurfaceColor) ??
      AppColors.controlSurface.toARGB32();

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.lightComponentSurfaceColor, value));
  }
}

@riverpod
class DarkComponentSurfaceColor extends _$DarkComponentSurfaceColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.darkComponentSurfaceColor) ??
      AppColors.darkControlSurface.toARGB32();

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.darkComponentSurfaceColor, value));
  }
}

/// 容器底色：NumberInput / EasyChip / IconBox 共用的表面色。
@riverpod
class LightContainerSurfaceColor extends _$LightContainerSurfaceColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.lightContainerSurfaceColor) ??
      AppColors.containerSurface.toARGB32();

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.lightContainerSurfaceColor, value));
  }
}

@riverpod
class DarkContainerSurfaceColor extends _$DarkContainerSurfaceColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.darkContainerSurfaceColor) ??
      AppColors.darkContainerSurface.toARGB32();

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.darkContainerSurfaceColor, value));
  }
}

@riverpod
class LightIconColor extends _$LightIconColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.lightIconColor) ??
      AppColors.icon.toARGB32();

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.lightIconColor, value));
  }
}

@riverpod
class LightOutlineColor extends _$LightOutlineColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.lightOutlineColor) ??
      AppColors.outline.toARGB32();

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.lightOutlineColor, value));
  }
}

@riverpod
class DarkThemeColor extends _$DarkThemeColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.darkColor) ?? AppColors.themeSeeds.first;

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.darkColor, value));
  }
}

@riverpod
class DarkBackgroundColor extends _$DarkBackgroundColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.darkBackgroundColor) ??
      AppColors.darkBackgroundSeeds.first;

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.darkBackgroundColor, value));
  }
}

@riverpod
class DarkIconColor extends _$DarkIconColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.darkIconColor) ??
      AppColors.darkIcon.toARGB32();

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.darkIconColor, value));
  }
}

@riverpod
class DarkOutlineColor extends _$DarkOutlineColor {
  @override
  int build() =>
      StorageService.getInt(AppKeys.darkOutlineColor) ??
      AppColors.darkOutline.toARGB32();

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.darkOutlineColor, value));
  }
}

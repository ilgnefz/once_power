// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedReplaceType)
final selectedReplaceTypeProvider = SelectedReplaceTypeProvider._();

final class SelectedReplaceTypeProvider
    extends $NotifierProvider<SelectedReplaceType, Set<ReplaceType>> {
  SelectedReplaceTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedReplaceTypeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedReplaceTypeHash();

  @$internal
  @override
  SelectedReplaceType create() => SelectedReplaceType();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<ReplaceType> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<ReplaceType>>(value),
    );
  }
}

String _$selectedReplaceTypeHash() =>
    r'364e4a9fd7e6f295197680aea1a77df450491ff4';

abstract class _$SelectedReplaceType extends $Notifier<Set<ReplaceType>> {
  Set<ReplaceType> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<ReplaceType>, Set<ReplaceType>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<ReplaceType>, Set<ReplaceType>>,
              Set<ReplaceType>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedKeepType)
final selectedKeepTypeProvider = SelectedKeepTypeProvider._();

final class SelectedKeepTypeProvider
    extends $NotifierProvider<SelectedKeepType, Set<KeepType>> {
  SelectedKeepTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedKeepTypeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedKeepTypeHash();

  @$internal
  @override
  SelectedKeepType create() => SelectedKeepType();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<KeepType> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<KeepType>>(value),
    );
  }
}

String _$selectedKeepTypeHash() => r'4f30a2386eb5b8ecb51c39a04f33afe0625c9b89';

abstract class _$SelectedKeepType extends $Notifier<Set<KeepType>> {
  Set<KeepType> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<KeepType>, Set<KeepType>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<KeepType>, Set<KeepType>>,
              Set<KeepType>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// 分隔条比例是会话级偏好：没有监听者时也要留着，否则切走再回来就回到 1:1。

@ProviderFor(SplitValues)
final splitValuesProvider = SplitValuesProvider._();

/// 分隔条比例是会话级偏好：没有监听者时也要留着，否则切走再回来就回到 1:1。
final class SplitValuesProvider
    extends $NotifierProvider<SplitValues, (int, int)> {
  /// 分隔条比例是会话级偏好：没有监听者时也要留着，否则切走再回来就回到 1:1。
  SplitValuesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'splitValuesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$splitValuesHash();

  @$internal
  @override
  SplitValues create() => SplitValues();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue((int, int) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<(int, int)>(value),
    );
  }
}

String _$splitValuesHash() => r'865ea8a5a777c4d41fcfe3a410b0566db3dcbd31';

/// 分隔条比例是会话级偏好：没有监听者时也要留着，否则切走再回来就回到 1:1。

abstract class _$SplitValues extends $Notifier<(int, int)> {
  (int, int) build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<(int, int), (int, int)>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<(int, int), (int, int)>,
              (int, int),
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ThemeColor)
final themeColorProvider = ThemeColorProvider._();

final class ThemeColorProvider extends $NotifierProvider<ThemeColor, int> {
  ThemeColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeColorHash();

  @$internal
  @override
  ThemeColor create() => ThemeColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$themeColorHash() => r'f0ed523424bf0c07530949a3ef0196cf37ce465c';

abstract class _$ThemeColor extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

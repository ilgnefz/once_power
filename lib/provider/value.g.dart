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
    r'18a286f802db21cf5968cabb007b8f15a9303e14';

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

String _$selectedKeepTypeHash() => r'1464ea65f4d7b091eaf1f3945a54b9b822c0a6de';

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

@ProviderFor(appearance)
final appearanceProvider = AppearanceProvider._();

final class AppearanceProvider
    extends
        $FunctionalProvider<
          AppearanceSettings,
          AppearanceSettings,
          AppearanceSettings
        >
    with $Provider<AppearanceSettings> {
  AppearanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appearanceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appearanceHash();

  @$internal
  @override
  $ProviderElement<AppearanceSettings> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppearanceSettings create(Ref ref) {
    return appearance(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppearanceSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppearanceSettings>(value),
    );
  }
}

String _$appearanceHash() => r'e06fc6559db59121a458eba4da087f4446fe7a19';

@ProviderFor(LightThemeColor)
final lightThemeColorProvider = LightThemeColorProvider._();

final class LightThemeColorProvider
    extends $NotifierProvider<LightThemeColor, int> {
  LightThemeColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lightThemeColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lightThemeColorHash();

  @$internal
  @override
  LightThemeColor create() => LightThemeColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$lightThemeColorHash() => r'bf010df7d4e482597d22334bf7e239d825e5cd63';

abstract class _$LightThemeColor extends $Notifier<int> {
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

@ProviderFor(LightBackgroundColor)
final lightBackgroundColorProvider = LightBackgroundColorProvider._();

final class LightBackgroundColorProvider
    extends $NotifierProvider<LightBackgroundColor, int> {
  LightBackgroundColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lightBackgroundColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lightBackgroundColorHash();

  @$internal
  @override
  LightBackgroundColor create() => LightBackgroundColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$lightBackgroundColorHash() =>
    r'3f5d47f866922f3194e27e676c3df201aad7a6df';

abstract class _$LightBackgroundColor extends $Notifier<int> {
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

/// 控件底色：输入框 / 下拉面板 / 右键菜单 / tooltip 共用的表面色。
/// 同步背景打开时这些组件改成跟随页面背景，该值仅在不同步时生效。

@ProviderFor(LightComponentSurfaceColor)
final lightComponentSurfaceColorProvider =
    LightComponentSurfaceColorProvider._();

/// 控件底色：输入框 / 下拉面板 / 右键菜单 / tooltip 共用的表面色。
/// 同步背景打开时这些组件改成跟随页面背景，该值仅在不同步时生效。
final class LightComponentSurfaceColorProvider
    extends $NotifierProvider<LightComponentSurfaceColor, int> {
  /// 控件底色：输入框 / 下拉面板 / 右键菜单 / tooltip 共用的表面色。
  /// 同步背景打开时这些组件改成跟随页面背景，该值仅在不同步时生效。
  LightComponentSurfaceColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lightComponentSurfaceColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lightComponentSurfaceColorHash();

  @$internal
  @override
  LightComponentSurfaceColor create() => LightComponentSurfaceColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$lightComponentSurfaceColorHash() =>
    r'7e9ecd37140759c97bc59439ab8fe34f77ea1e35';

/// 控件底色：输入框 / 下拉面板 / 右键菜单 / tooltip 共用的表面色。
/// 同步背景打开时这些组件改成跟随页面背景，该值仅在不同步时生效。

abstract class _$LightComponentSurfaceColor extends $Notifier<int> {
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

@ProviderFor(DarkComponentSurfaceColor)
final darkComponentSurfaceColorProvider = DarkComponentSurfaceColorProvider._();

final class DarkComponentSurfaceColorProvider
    extends $NotifierProvider<DarkComponentSurfaceColor, int> {
  DarkComponentSurfaceColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'darkComponentSurfaceColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$darkComponentSurfaceColorHash();

  @$internal
  @override
  DarkComponentSurfaceColor create() => DarkComponentSurfaceColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$darkComponentSurfaceColorHash() =>
    r'34ef2464e842960f1e8feee78d43eaea244f06f2';

abstract class _$DarkComponentSurfaceColor extends $Notifier<int> {
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

/// 容器底色：NumberInput / EasyChip / IconBox 共用的表面色。

@ProviderFor(LightContainerSurfaceColor)
final lightContainerSurfaceColorProvider =
    LightContainerSurfaceColorProvider._();

/// 容器底色：NumberInput / EasyChip / IconBox 共用的表面色。
final class LightContainerSurfaceColorProvider
    extends $NotifierProvider<LightContainerSurfaceColor, int> {
  /// 容器底色：NumberInput / EasyChip / IconBox 共用的表面色。
  LightContainerSurfaceColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lightContainerSurfaceColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lightContainerSurfaceColorHash();

  @$internal
  @override
  LightContainerSurfaceColor create() => LightContainerSurfaceColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$lightContainerSurfaceColorHash() =>
    r'9d759a84403c3790a39847dea993c2620385f9df';

/// 容器底色：NumberInput / EasyChip / IconBox 共用的表面色。

abstract class _$LightContainerSurfaceColor extends $Notifier<int> {
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

@ProviderFor(DarkContainerSurfaceColor)
final darkContainerSurfaceColorProvider = DarkContainerSurfaceColorProvider._();

final class DarkContainerSurfaceColorProvider
    extends $NotifierProvider<DarkContainerSurfaceColor, int> {
  DarkContainerSurfaceColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'darkContainerSurfaceColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$darkContainerSurfaceColorHash();

  @$internal
  @override
  DarkContainerSurfaceColor create() => DarkContainerSurfaceColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$darkContainerSurfaceColorHash() =>
    r'78181b34208da0753fb75afbb60d0685c4fcfcfd';

abstract class _$DarkContainerSurfaceColor extends $Notifier<int> {
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

@ProviderFor(LightIconColor)
final lightIconColorProvider = LightIconColorProvider._();

final class LightIconColorProvider
    extends $NotifierProvider<LightIconColor, int> {
  LightIconColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lightIconColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lightIconColorHash();

  @$internal
  @override
  LightIconColor create() => LightIconColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$lightIconColorHash() => r'999c565d6349a32f90583a3bd0f811278db6c10e';

abstract class _$LightIconColor extends $Notifier<int> {
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

@ProviderFor(LightOutlineColor)
final lightOutlineColorProvider = LightOutlineColorProvider._();

final class LightOutlineColorProvider
    extends $NotifierProvider<LightOutlineColor, int> {
  LightOutlineColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lightOutlineColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lightOutlineColorHash();

  @$internal
  @override
  LightOutlineColor create() => LightOutlineColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$lightOutlineColorHash() => r'd65d10bfdb06bf209a5727ee94c1720526aec098';

abstract class _$LightOutlineColor extends $Notifier<int> {
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

@ProviderFor(DarkThemeColor)
final darkThemeColorProvider = DarkThemeColorProvider._();

final class DarkThemeColorProvider
    extends $NotifierProvider<DarkThemeColor, int> {
  DarkThemeColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'darkThemeColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$darkThemeColorHash();

  @$internal
  @override
  DarkThemeColor create() => DarkThemeColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$darkThemeColorHash() => r'e21dac03aaf37f3529535add75d8d3a00e6bd04a';

abstract class _$DarkThemeColor extends $Notifier<int> {
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

@ProviderFor(DarkBackgroundColor)
final darkBackgroundColorProvider = DarkBackgroundColorProvider._();

final class DarkBackgroundColorProvider
    extends $NotifierProvider<DarkBackgroundColor, int> {
  DarkBackgroundColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'darkBackgroundColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$darkBackgroundColorHash();

  @$internal
  @override
  DarkBackgroundColor create() => DarkBackgroundColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$darkBackgroundColorHash() =>
    r'343ca0b248f7ea209904a4ed402d4e5f392bc711';

abstract class _$DarkBackgroundColor extends $Notifier<int> {
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

@ProviderFor(DarkIconColor)
final darkIconColorProvider = DarkIconColorProvider._();

final class DarkIconColorProvider
    extends $NotifierProvider<DarkIconColor, int> {
  DarkIconColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'darkIconColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$darkIconColorHash();

  @$internal
  @override
  DarkIconColor create() => DarkIconColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$darkIconColorHash() => r'77cd92fee3bcaacc7dc7c48109ab372fa961d086';

abstract class _$DarkIconColor extends $Notifier<int> {
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

@ProviderFor(DarkOutlineColor)
final darkOutlineColorProvider = DarkOutlineColorProvider._();

final class DarkOutlineColorProvider
    extends $NotifierProvider<DarkOutlineColor, int> {
  DarkOutlineColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'darkOutlineColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$darkOutlineColorHash();

  @$internal
  @override
  DarkOutlineColor create() => DarkOutlineColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$darkOutlineColorHash() => r'538a4b4f765b409758fd84c3fa105d5d59a31814';

abstract class _$DarkOutlineColor extends $Notifier<int> {
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

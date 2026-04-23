// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HiddenTip)
final hiddenTipProvider = HiddenTipProvider._();

final class HiddenTipProvider extends $NotifierProvider<HiddenTip, bool> {
  HiddenTipProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hiddenTipProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hiddenTipHash();

  @$internal
  @override
  HiddenTip create() => HiddenTip();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hiddenTipHash() => r'002c2a2019f9ad8c27ffe4fd1051c6218d335051';

abstract class _$HiddenTip extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ThemeSetting)
final themeSettingProvider = ThemeSettingProvider._();

final class ThemeSettingProvider
    extends $NotifierProvider<ThemeSetting, CustomTheme> {
  ThemeSettingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeSettingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeSettingHash();

  @$internal
  @override
  ThemeSetting create() => ThemeSetting();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomTheme value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomTheme>(value),
    );
  }
}

String _$themeSettingHash() => r'f6cc86d4751d32f7d8f6fbc5f8c4ee83d05a9f9d';

abstract class _$ThemeSetting extends $Notifier<CustomTheme> {
  CustomTheme build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CustomTheme, CustomTheme>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CustomTheme, CustomTheme>,
              CustomTheme,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

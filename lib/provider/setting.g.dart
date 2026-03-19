// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentMode)
final currentModeProvider = CurrentModeProvider._();

final class CurrentModeProvider
    extends $NotifierProvider<CurrentMode, FunctionMode> {
  CurrentModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentModeHash();

  @$internal
  @override
  CurrentMode create() => CurrentMode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FunctionMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FunctionMode>(value),
    );
  }
}

String _$currentModeHash() => r'120a6e7af85006154a5241ffb47396a275f76c60';

abstract class _$CurrentMode extends $Notifier<FunctionMode> {
  FunctionMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<FunctionMode, FunctionMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FunctionMode, FunctionMode>,
              FunctionMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(CurrentTheme)
final currentThemeProvider = CurrentThemeProvider._();

final class CurrentThemeProvider
    extends $NotifierProvider<CurrentTheme, ThemeType> {
  CurrentThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentThemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentThemeHash();

  @$internal
  @override
  CurrentTheme create() => CurrentTheme();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeType>(value),
    );
  }
}

String _$currentThemeHash() => r'29ffbbd9c9d2dd73ebeb1f461cfe0d0d80ca8d2e';

abstract class _$CurrentTheme extends $Notifier<ThemeType> {
  ThemeType build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeType, ThemeType>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeType, ThemeType>,
              ThemeType,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

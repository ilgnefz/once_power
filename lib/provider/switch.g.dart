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

String _$currentModeHash() => r'3f7e5c1085f36aeeb86ef1594188eeee14f68571';

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

@ProviderFor(CurrentDate)
final currentDateProvider = CurrentDateProvider._();

final class CurrentDateProvider
    extends $NotifierProvider<CurrentDate, DateType> {
  CurrentDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentDateHash();

  @$internal
  @override
  CurrentDate create() => CurrentDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateType>(value),
    );
  }
}

String _$currentDateHash() => r'045d549a1cd4c4e017a466b2fe2c3f9d601495b7';

abstract class _$CurrentDate extends $Notifier<DateType> {
  DateType build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DateType, DateType>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateType, DateType>,
              DateType,
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

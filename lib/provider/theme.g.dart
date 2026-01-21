// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$currentThemeHash() => r'5438070c83f89fae4291d9d062538e764faeec63';

abstract class _$CurrentTheme extends $Notifier<ThemeType> {
  ThemeType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ThemeType, ThemeType>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeType, ThemeType>,
              ThemeType,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

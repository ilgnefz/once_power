// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Count)
final countProvider = CountProvider._();

final class CountProvider extends $NotifierProvider<Count, int> {
  CountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countHash();

  @$internal
  @override
  Count create() => Count();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$countHash() => r'8e80697fd3247b0a48ff736a7e798b5d73afec4f';

abstract class _$Count extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Total)
final totalProvider = TotalProvider._();

final class TotalProvider extends $NotifierProvider<Total, int> {
  TotalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalHash();

  @$internal
  @override
  Total create() => Total();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$totalHash() => r'36d3ac44b850542d7fcc163ef29c2e1a63d3c434';

abstract class _$Total extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Cost)
final costProvider = CostProvider._();

final class CostProvider extends $NotifierProvider<Cost, double> {
  CostProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'costProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$costHash();

  @$internal
  @override
  Cost create() => Cost();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$costHash() => r'4abf34a7a07a8827a436a70a08ac67f8c66c3c01';

abstract class _$Cost extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<double, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double, double>,
              double,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(CurrentProgressFile)
final currentProgressFileProvider = CurrentProgressFileProvider._();

final class CurrentProgressFileProvider
    extends $NotifierProvider<CurrentProgressFile, ProgressFileInfo?> {
  CurrentProgressFileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentProgressFileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentProgressFileHash();

  @$internal
  @override
  CurrentProgressFile create() => CurrentProgressFile();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProgressFileInfo? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProgressFileInfo?>(value),
    );
  }
}

String _$currentProgressFileHash() =>
    r'5296a0c110418d606b8c0c0d847ba1b286070016';

abstract class _$CurrentProgressFile extends $Notifier<ProgressFileInfo?> {
  ProgressFileInfo? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProgressFileInfo?, ProgressFileInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProgressFileInfo?, ProgressFileInfo?>,
              ProgressFileInfo?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(CurrentSize)
final currentSizeProvider = CurrentSizeProvider._();

final class CurrentSizeProvider extends $NotifierProvider<CurrentSize, int> {
  CurrentSizeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentSizeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentSizeHash();

  @$internal
  @override
  CurrentSize create() => CurrentSize();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$currentSizeHash() => r'13581a1928585471400a032ba60d195aa34a7d59';

abstract class _$CurrentSize extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(IsApplying)
final isApplyingProvider = IsApplyingProvider._();

final class IsApplyingProvider extends $NotifierProvider<IsApplying, bool> {
  IsApplyingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isApplyingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isApplyingHash();

  @$internal
  @override
  IsApplying create() => IsApplying();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isApplyingHash() => r'c3945bac7f98889d1a03c9356128c4d3f2954c08';

abstract class _$IsApplying extends $Notifier<bool> {
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advance.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(AdvanceMenuList)
const advanceMenuListProvider = AdvanceMenuListProvider._();

final class AdvanceMenuListProvider
    extends $NotifierProvider<AdvanceMenuList, List<AdvanceMenuModel>> {
  const AdvanceMenuListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'advanceMenuListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$advanceMenuListHash();

  @$internal
  @override
  AdvanceMenuList create() => AdvanceMenuList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AdvanceMenuModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AdvanceMenuModel>>(value),
    );
  }
}

String _$advanceMenuListHash() => r'cc9e06d0e42bfce2753e2f7df2057eafbe6551b7';

abstract class _$AdvanceMenuList extends $Notifier<List<AdvanceMenuModel>> {
  List<AdvanceMenuModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<List<AdvanceMenuModel>, List<AdvanceMenuModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<AdvanceMenuModel>, List<AdvanceMenuModel>>,
              List<AdvanceMenuModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(AdvancePresetList)
const advancePresetListProvider = AdvancePresetListProvider._();

final class AdvancePresetListProvider
    extends $NotifierProvider<AdvancePresetList, List<AdvancePreset>> {
  const AdvancePresetListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'advancePresetListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$advancePresetListHash();

  @$internal
  @override
  AdvancePresetList create() => AdvancePresetList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AdvancePreset> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AdvancePreset>>(value),
    );
  }
}

String _$advancePresetListHash() => r'e38425d73b056fb876d22ce533537537d266f4e2';

abstract class _$AdvancePresetList extends $Notifier<List<AdvancePreset>> {
  List<AdvancePreset> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<AdvancePreset>, List<AdvancePreset>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<AdvancePreset>, List<AdvancePreset>>,
              List<AdvancePreset>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

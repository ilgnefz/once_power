// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectionController)
final selectionControllerProvider = SelectionControllerProvider._();

final class SelectionControllerProvider
    extends $NotifierProvider<SelectionController, MultiSelectController> {
  SelectionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectionControllerHash();

  @$internal
  @override
  SelectionController create() => SelectionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MultiSelectController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MultiSelectController>(value),
    );
  }
}

String _$selectionControllerHash() =>
    r'0bd794dc7905d341024dc06b5876826ad8ddf58a';

abstract class _$SelectionController extends $Notifier<MultiSelectController> {
  MultiSelectController build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MultiSelectController, MultiSelectController>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MultiSelectController, MultiSelectController>,
              MultiSelectController,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

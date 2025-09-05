// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(sortList)
const sortListProvider = SortListProvider._();

final class SortListProvider
    extends $FunctionalProvider<List<FileInfo>, List<FileInfo>, List<FileInfo>>
    with $Provider<List<FileInfo>> {
  const SortListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortListHash();

  @$internal
  @override
  $ProviderElement<List<FileInfo>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<FileInfo> create(Ref ref) {
    return sortList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FileInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FileInfo>>(value),
    );
  }
}

String _$sortListHash() => r'954b959c1636433620a100f5179fd08a02f74e54';

@ProviderFor(SortSelectList)
const sortSelectListProvider = SortSelectListProvider._();

final class SortSelectListProvider
    extends $NotifierProvider<SortSelectList, List<FileInfo>> {
  const SortSelectListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortSelectListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortSelectListHash();

  @$internal
  @override
  SortSelectList create() => SortSelectList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FileInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FileInfo>>(value),
    );
  }
}

String _$sortSelectListHash() => r'4f635dcbc64b08c1eeceefcce63f0f92d9d31e10';

abstract class _$SortSelectList extends $Notifier<List<FileInfo>> {
  List<FileInfo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<FileInfo>, List<FileInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<FileInfo>, List<FileInfo>>,
              List<FileInfo>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(AdvanceMenuSelectedList)
const advanceMenuSelectedListProvider = AdvanceMenuSelectedListProvider._();

final class AdvanceMenuSelectedListProvider
    extends $NotifierProvider<AdvanceMenuSelectedList, List<AdvanceMenuModel>> {
  const AdvanceMenuSelectedListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'advanceMenuSelectedListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$advanceMenuSelectedListHash();

  @$internal
  @override
  AdvanceMenuSelectedList create() => AdvanceMenuSelectedList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AdvanceMenuModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AdvanceMenuModel>>(value),
    );
  }
}

String _$advanceMenuSelectedListHash() =>
    r'a0be5a95592945706c46714f8c9a62a08eb2713d';

abstract class _$AdvanceMenuSelectedList
    extends $Notifier<List<AdvanceMenuModel>> {
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

@ProviderFor(CSVData)
const cSVDataProvider = CSVDataProvider._();

final class CSVDataProvider
    extends $NotifierProvider<CSVData, List<CsvRenameInfo>> {
  const CSVDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cSVDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cSVDataHash();

  @$internal
  @override
  CSVData create() => CSVData();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CsvRenameInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CsvRenameInfo>>(value),
    );
  }
}

String _$cSVDataHash() => r'a24606979d40a878b7d73205dfc4658ae3c3a2b9';

abstract class _$CSVData extends $Notifier<List<CsvRenameInfo>> {
  List<CsvRenameInfo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<CsvRenameInfo>, List<CsvRenameInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<CsvRenameInfo>, List<CsvRenameInfo>>,
              List<CsvRenameInfo>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(classifyList)
const classifyListProvider = ClassifyListProvider._();

final class ClassifyListProvider
    extends
        $FunctionalProvider<
          List<FileClassify>,
          List<FileClassify>,
          List<FileClassify>
        >
    with $Provider<List<FileClassify>> {
  const ClassifyListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'classifyListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$classifyListHash();

  @$internal
  @override
  $ProviderElement<List<FileClassify>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<FileClassify> create(Ref ref) {
    return classifyList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FileClassify> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FileClassify>>(value),
    );
  }
}

String _$classifyListHash() => r'e4624232a3cb0c796b8626951d3f79a3295af01b';

@ProviderFor(extensionListMap)
const extensionListMapProvider = ExtensionListMapProvider._();

final class ExtensionListMapProvider
    extends
        $FunctionalProvider<
          Map<FileClassify, List<String>>,
          Map<FileClassify, List<String>>,
          Map<FileClassify, List<String>>
        >
    with $Provider<Map<FileClassify, List<String>>> {
  const ExtensionListMapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'extensionListMapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$extensionListMapHash();

  @$internal
  @override
  $ProviderElement<Map<FileClassify, List<String>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<FileClassify, List<String>> create(Ref ref) {
    return extensionListMap(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<FileClassify, List<String>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<FileClassify, List<String>>>(
        value,
      ),
    );
  }
}

String _$extensionListMapHash() => r'2b89d1719bf8042f0cedaf1f445562487df18027';

@ProviderFor(selectedExtension)
const selectedExtensionProvider = SelectedExtensionFamily._();

final class SelectedExtensionProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const SelectedExtensionProvider._({
    required SelectedExtensionFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'selectedExtensionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedExtensionHash();

  @override
  String toString() {
    return r'selectedExtensionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as String;
    return selectedExtension(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedExtensionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedExtensionHash() => r'1a14da57f795e24097f1ac2ae47ab4d3384e7969';

final class SelectedExtensionFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  const SelectedExtensionFamily._()
    : super(
        retry: null,
        name: r'selectedExtensionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SelectedExtensionProvider call(String ext) =>
      SelectedExtensionProvider._(argument: ext, from: this);

  @override
  String toString() => r'selectedExtensionProvider';
}

@ProviderFor(pathList)
const pathListProvider = PathListProvider._();

final class PathListProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  const PathListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pathListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pathListHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return pathList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$pathListHash() => r'd103b39362c90566f45e1d469908ca61a1a2c3a6';

@ProviderFor(selectedPath)
const selectedPathProvider = SelectedPathFamily._();

final class SelectedPathProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const SelectedPathProvider._({
    required SelectedPathFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'selectedPathProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedPathHash();

  @override
  String toString() {
    return r'selectedPathProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as String;
    return selectedPath(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedPathProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedPathHash() => r'e6ada816007c8d815912a75a1a5579a487da4306';

final class SelectedPathFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  const SelectedPathFamily._()
    : super(
        retry: null,
        name: r'selectedPathProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SelectedPathProvider call(String folder) =>
      SelectedPathProvider._(argument: folder, from: this);

  @override
  String toString() => r'selectedPathProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

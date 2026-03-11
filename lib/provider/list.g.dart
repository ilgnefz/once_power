// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sortList)
final sortListProvider = SortListProvider._();

final class SortListProvider
    extends $FunctionalProvider<List<FileInfo>, List<FileInfo>, List<FileInfo>>
    with $Provider<List<FileInfo>> {
  SortListProvider._()
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

String _$sortListHash() => r'caf32285d5382842105f6cd07a8960e8173c3454';

@ProviderFor(SortSelectList)
final sortSelectListProvider = SortSelectListProvider._();

final class SortSelectListProvider
    extends $NotifierProvider<SortSelectList, List<FileInfo>> {
  SortSelectListProvider._()
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
    final ref = this.ref as $Ref<List<FileInfo>, List<FileInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<FileInfo>, List<FileInfo>>,
              List<FileInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(classifyList)
final classifyListProvider = ClassifyListProvider._();

final class ClassifyListProvider
    extends
        $FunctionalProvider<
          List<FileClassify>,
          List<FileClassify>,
          List<FileClassify>
        >
    with $Provider<List<FileClassify>> {
  ClassifyListProvider._()
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

String _$classifyListHash() => r'ef550e40895b2ecd60c5fcc903caf2b74859c894';

@ProviderFor(CSVData)
final cSVDataProvider = CSVDataProvider._();

final class CSVDataProvider
    extends $NotifierProvider<CSVData, List<CSVRenameInfo>> {
  CSVDataProvider._()
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
  Override overrideWithValue(List<CSVRenameInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CSVRenameInfo>>(value),
    );
  }
}

String _$cSVDataHash() => r'5cfa4e090f6f7a03d60d55ae04ac512d40ab6c5a';

abstract class _$CSVData extends $Notifier<List<CSVRenameInfo>> {
  List<CSVRenameInfo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<CSVRenameInfo>, List<CSVRenameInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<CSVRenameInfo>, List<CSVRenameInfo>>,
              List<CSVRenameInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

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

String _$sortListHash() => r'1e9b799ccc8a437d1a62ea22b9946b3d48c611c1';

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

@ProviderFor(fileTypeList)
final fileTypeListProvider = FileTypeListProvider._();

final class FileTypeListProvider
    extends
        $FunctionalProvider<
          List<CountFileType>,
          List<CountFileType>,
          List<CountFileType>
        >
    with $Provider<List<CountFileType>> {
  FileTypeListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileTypeListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileTypeListHash();

  @$internal
  @override
  $ProviderElement<List<CountFileType>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<CountFileType> create(Ref ref) {
    return fileTypeList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CountFileType> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CountFileType>>(value),
    );
  }
}

String _$fileTypeListHash() => r'7f002ecfd173fede0664119180eb32202d4c6524';

@ProviderFor(extensionListMap)
final extensionListMapProvider = ExtensionListMapProvider._();

final class ExtensionListMapProvider
    extends
        $FunctionalProvider<
          Map<FileType, List<String>>,
          Map<FileType, List<String>>,
          Map<FileType, List<String>>
        >
    with $Provider<Map<FileType, List<String>>> {
  ExtensionListMapProvider._()
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
  $ProviderElement<Map<FileType, List<String>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<FileType, List<String>> create(Ref ref) {
    return extensionListMap(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<FileType, List<String>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<FileType, List<String>>>(value),
    );
  }
}

String _$extensionListMapHash() => r'334fda6931435f951f4143f65af78b3fb3230bd2';

@ProviderFor(selectedExtension)
final selectedExtensionProvider = SelectedExtensionFamily._();

final class SelectedExtensionProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  SelectedExtensionProvider._({
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

String _$selectedExtensionHash() => r'9099f30769bba0f9a4b258cc30a7f89cc6d6dc2d';

final class SelectedExtensionFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  SelectedExtensionFamily._()
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
final pathListProvider = PathListProvider._();

final class PathListProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  PathListProvider._()
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

String _$pathListHash() => r'6b063b2d123b1fda494c39b5463debc3e7f21cdc';

@ProviderFor(selectedPath)
final selectedPathProvider = SelectedPathFamily._();

final class SelectedPathProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  SelectedPathProvider._({
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

String _$selectedPathHash() => r'06a67e969b1320871c12dab9d4ea6efb8c968365';

final class SelectedPathFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  SelectedPathFamily._()
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

@ProviderFor(AdvanceMenuSelectedList)
final advanceMenuSelectedListProvider = AdvanceMenuSelectedListProvider._();

final class AdvanceMenuSelectedListProvider
    extends $NotifierProvider<AdvanceMenuSelectedList, List<AdvanceMenuModel>> {
  AdvanceMenuSelectedListProvider._()
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
    element.handleCreate(ref, build);
  }
}

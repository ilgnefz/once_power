// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sortListHash() => r'c303d0c8eaf11f443503fce18d7672ceca534e5a';

/// See also [sortList].
@ProviderFor(sortList)
final sortListProvider = AutoDisposeProvider<List<FileInfo>>.internal(
  sortList,
  name: r'sortListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sortListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SortListRef = AutoDisposeProviderRef<List<FileInfo>>;
String _$classifyListHash() => r'ef550e40895b2ecd60c5fcc903caf2b74859c894';

/// See also [classifyList].
@ProviderFor(classifyList)
final classifyListProvider = AutoDisposeProvider<List<FileClassify>>.internal(
  classifyList,
  name: r'classifyListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$classifyListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClassifyListRef = AutoDisposeProviderRef<List<FileClassify>>;
String _$extensionListMapHash() => r'ec4d29d198bb37b5df2afe7946c8956b0c25d986';

/// See also [extensionListMap].
@ProviderFor(extensionListMap)
final extensionListMapProvider =
    AutoDisposeProvider<Map<FileClassify, List<String>>>.internal(
  extensionListMap,
  name: r'extensionListMapProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$extensionListMapHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExtensionListMapRef
    = AutoDisposeProviderRef<Map<FileClassify, List<String>>>;
String _$selectedExtensionHash() => r'56fe0f08a8b23505129f7f431e6c9e4ffb093b1b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [selectedExtension].
@ProviderFor(selectedExtension)
const selectedExtensionProvider = SelectedExtensionFamily();

/// See also [selectedExtension].
class SelectedExtensionFamily extends Family<bool> {
  /// See also [selectedExtension].
  const SelectedExtensionFamily();

  /// See also [selectedExtension].
  SelectedExtensionProvider call(
    String ext,
  ) {
    return SelectedExtensionProvider(
      ext,
    );
  }

  @override
  SelectedExtensionProvider getProviderOverride(
    covariant SelectedExtensionProvider provider,
  ) {
    return call(
      provider.ext,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectedExtensionProvider';
}

/// See also [selectedExtension].
class SelectedExtensionProvider extends AutoDisposeProvider<bool> {
  /// See also [selectedExtension].
  SelectedExtensionProvider(
    String ext,
  ) : this._internal(
          (ref) => selectedExtension(
            ref as SelectedExtensionRef,
            ext,
          ),
          from: selectedExtensionProvider,
          name: r'selectedExtensionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedExtensionHash,
          dependencies: SelectedExtensionFamily._dependencies,
          allTransitiveDependencies:
              SelectedExtensionFamily._allTransitiveDependencies,
          ext: ext,
        );

  SelectedExtensionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ext,
  }) : super.internal();

  final String ext;

  @override
  Override overrideWith(
    bool Function(SelectedExtensionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SelectedExtensionProvider._internal(
        (ref) => create(ref as SelectedExtensionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ext: ext,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _SelectedExtensionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedExtensionProvider && other.ext == ext;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ext.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SelectedExtensionRef on AutoDisposeProviderRef<bool> {
  /// The parameter `ext` of this provider.
  String get ext;
}

class _SelectedExtensionProviderElement extends AutoDisposeProviderElement<bool>
    with SelectedExtensionRef {
  _SelectedExtensionProviderElement(super.provider);

  @override
  String get ext => (origin as SelectedExtensionProvider).ext;
}

String _$pathListHash() => r'6b063b2d123b1fda494c39b5463debc3e7f21cdc';

/// See also [pathList].
@ProviderFor(pathList)
final pathListProvider = AutoDisposeProvider<List<String>>.internal(
  pathList,
  name: r'pathListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pathListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PathListRef = AutoDisposeProviderRef<List<String>>;
String _$selectedPathHash() => r'06a67e969b1320871c12dab9d4ea6efb8c968365';

/// See also [selectedPath].
@ProviderFor(selectedPath)
const selectedPathProvider = SelectedPathFamily();

/// See also [selectedPath].
class SelectedPathFamily extends Family<bool> {
  /// See also [selectedPath].
  const SelectedPathFamily();

  /// See also [selectedPath].
  SelectedPathProvider call(
    String folder,
  ) {
    return SelectedPathProvider(
      folder,
    );
  }

  @override
  SelectedPathProvider getProviderOverride(
    covariant SelectedPathProvider provider,
  ) {
    return call(
      provider.folder,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectedPathProvider';
}

/// See also [selectedPath].
class SelectedPathProvider extends AutoDisposeProvider<bool> {
  /// See also [selectedPath].
  SelectedPathProvider(
    String folder,
  ) : this._internal(
          (ref) => selectedPath(
            ref as SelectedPathRef,
            folder,
          ),
          from: selectedPathProvider,
          name: r'selectedPathProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedPathHash,
          dependencies: SelectedPathFamily._dependencies,
          allTransitiveDependencies:
              SelectedPathFamily._allTransitiveDependencies,
          folder: folder,
        );

  SelectedPathProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.folder,
  }) : super.internal();

  final String folder;

  @override
  Override overrideWith(
    bool Function(SelectedPathRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SelectedPathProvider._internal(
        (ref) => create(ref as SelectedPathRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        folder: folder,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _SelectedPathProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedPathProvider && other.folder == folder;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, folder.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SelectedPathRef on AutoDisposeProviderRef<bool> {
  /// The parameter `folder` of this provider.
  String get folder;
}

class _SelectedPathProviderElement extends AutoDisposeProviderElement<bool>
    with SelectedPathRef {
  _SelectedPathProviderElement(super.provider);

  @override
  String get folder => (origin as SelectedPathProvider).folder;
}

String _$sortSelectListHash() => r'4f635dcbc64b08c1eeceefcce63f0f92d9d31e10';

/// See also [SortSelectList].
@ProviderFor(SortSelectList)
final sortSelectListProvider =
    AutoDisposeNotifierProvider<SortSelectList, List<FileInfo>>.internal(
  SortSelectList.new,
  name: r'sortSelectListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sortSelectListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SortSelectList = AutoDisposeNotifier<List<FileInfo>>;
String _$advanceMenuSelectedListHash() =>
    r'a0be5a95592945706c46714f8c9a62a08eb2713d';

/// See also [AdvanceMenuSelectedList].
@ProviderFor(AdvanceMenuSelectedList)
final advanceMenuSelectedListProvider = AutoDisposeNotifierProvider<
    AdvanceMenuSelectedList, List<AdvanceMenuModel>>.internal(
  AdvanceMenuSelectedList.new,
  name: r'advanceMenuSelectedListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$advanceMenuSelectedListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AdvanceMenuSelectedList = AutoDisposeNotifier<List<AdvanceMenuModel>>;
String _$cSVDataHash() => r'a24606979d40a878b7d73205dfc4658ae3c3a2b9';

/// See also [CSVData].
@ProviderFor(CSVData)
final cSVDataProvider =
    AutoDisposeNotifierProvider<CSVData, List<CsvRenameInfo>>.internal(
  CSVData.new,
  name: r'cSVDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cSVDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CSVData = AutoDisposeNotifier<List<CsvRenameInfo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

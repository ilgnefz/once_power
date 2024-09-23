// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sortListHash() => r'1bd057027e3392399365be8d160c0cf869a2e3b7';

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

typedef SortListRef = AutoDisposeProviderRef<List<FileInfo>>;
String _$selectFileHash() => r'4b923f6166c9029bd60fcd235bb69dae1b9cd00c';

/// See also [selectFile].
@ProviderFor(selectFile)
final selectFileProvider = AutoDisposeProvider<int>.internal(
  selectFile,
  name: r'selectFileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectFileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectFileRef = AutoDisposeProviderRef<int>;
String _$classifyListHash() => r'10845e41cc26efebe4d86d275f66b480dd2877e3';

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

typedef ClassifyListRef = AutoDisposeProviderRef<List<FileClassify>>;
String _$extensionListMapHash() => r'56b79a9076d6200b51a1f30cff2f0227a5e81a60';

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

typedef ExtensionListMapRef
    = AutoDisposeProviderRef<Map<FileClassify, List<String>>>;
String _$selectedExtensionHash() => r'bed35cce95c8904157a1636adc16bebcde1b0818';

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

String _$easyRenameInfoListHash() =>
    r'f50cd9df7222f93c32226f777b70c55706ae76dd';

/// See also [easyRenameInfoList].
@ProviderFor(easyRenameInfoList)
final easyRenameInfoListProvider =
    AutoDisposeProvider<List<EasyRenameInfo>>.internal(
  easyRenameInfoList,
  name: r'easyRenameInfoListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$easyRenameInfoListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EasyRenameInfoListRef = AutoDisposeProviderRef<List<EasyRenameInfo>>;
String _$fileListHash() => r'5e3d52652382933019f8547cb50e17feda131e61';

/// See also [FileList].
@ProviderFor(FileList)
final fileListProvider =
    AutoDisposeNotifierProvider<FileList, List<FileInfo>>.internal(
  FileList.new,
  name: r'fileListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fileListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FileList = AutoDisposeNotifier<List<FileInfo>>;
String _$selectAllHash() => r'bb39801d68715244071f9e67dda3c91743b3204c';

/// See also [SelectAll].
@ProviderFor(SelectAll)
final selectAllProvider = AutoDisposeNotifierProvider<SelectAll, bool>.internal(
  SelectAll.new,
  name: r'selectAllProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectAllHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectAll = AutoDisposeNotifier<bool>;
String _$tempListHash() => r'1bc790f0c4444f4c209fe419872e58349a5bd063';

/// See also [TempList].
@ProviderFor(TempList)
final tempListProvider =
    AutoDisposeNotifierProvider<TempList, List<RenameInfo>>.internal(
  TempList.new,
  name: r'tempListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tempListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TempList = AutoDisposeNotifier<List<RenameInfo>>;
String _$badListHash() => r'dc2a31e03c6cbeb2289cc45fd01002d99d310604';

/// See also [BadList].
@ProviderFor(BadList)
final badListProvider =
    AutoDisposeNotifierProvider<BadList, List<String>>.internal(
  BadList.new,
  name: r'badListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$badListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BadList = AutoDisposeNotifier<List<String>>;
String _$cSVDataHash() => r'f191af1b6fec9422f6cdb24734d70af8f9b8db11';

/// See also [CSVData].
@ProviderFor(CSVData)
final cSVDataProvider =
    AutoDisposeNotifierProvider<CSVData, List<List<String>>>.internal(
  CSVData.new,
  name: r'cSVDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cSVDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CSVData = AutoDisposeNotifier<List<List<String>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

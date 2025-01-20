// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sortListHash() => r'3f3264a3669b0e826d52c35bb6049202e1e4b577';

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
String _$selectFileHash() => r'd32feda656490dd60f3b87299e22c6b1680070c7';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectFileRef = AutoDisposeProviderRef<int>;
String _$classifyListHash() => r'f7e93b2936d4c3bea40440692b010d31d4139865';

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
String _$extensionListMapHash() => r'8f0256506288891e5df036718968f6dd37856b79';

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
String _$selectedExtensionHash() => r'9099f30769bba0f9a4b258cc30a7f89cc6d6dc2d';

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

String _$fileListHash() => r'026f4212d120dfde7f75bd4182e97c9eac3baeeb';

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
String _$cSVDataHash() => r'0796f163632583fca7c020dbb6099dc0bad76d89';

/// See also [CSVData].
@ProviderFor(CSVData)
final cSVDataProvider =
    AutoDisposeNotifierProvider<CSVData, List<EasyRenameInfo>>.internal(
  CSVData.new,
  name: r'cSVDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cSVDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CSVData = AutoDisposeNotifier<List<EasyRenameInfo>>;
String _$operateLogListHash() => r'1b9d8bce7747da16fffe57ce25285161b0022933';

/// See also [OperateLogList].
@ProviderFor(OperateLogList)
final operateLogListProvider =
    AutoDisposeNotifierProvider<OperateLogList, List<String>>.internal(
  OperateLogList.new,
  name: r'operateLogListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$operateLogListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OperateLogList = AutoDisposeNotifier<List<String>>;
String _$advanceMenuListHash() => r'73df1772fc179947b199747130fb35a43279558f';

/// See also [AdvanceMenuList].
@ProviderFor(AdvanceMenuList)
final advanceMenuListProvider = AutoDisposeNotifierProvider<AdvanceMenuList,
    List<AdvanceMenuModel>>.internal(
  AdvanceMenuList.new,
  name: r'advanceMenuListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$advanceMenuListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AdvanceMenuList = AutoDisposeNotifier<List<AdvanceMenuModel>>;
String _$advancePresetListHash() => r'c6a7f82235dce59df79a5608be7e07800ede2056';

/// See also [AdvancePresetList].
@ProviderFor(AdvancePresetList)
final advancePresetListProvider = AutoDisposeNotifierProvider<AdvancePresetList,
    List<AdvancePreset>>.internal(
  AdvancePresetList.new,
  name: r'advancePresetListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$advancePresetListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AdvancePresetList = AutoDisposeNotifier<List<AdvancePreset>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

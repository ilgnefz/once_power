// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sortListHash() => r'0938e9913b7eab8331ae3615aea90d1bbc432bde';

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
String _$getFileClassifyHash() => r'06e7975cee32e4b3b3eec8979ead427d56e0e5ec';

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

typedef GetFileClassifyRef = AutoDisposeProviderRef<FileClassify>;

/// See also [getFileClassify].
@ProviderFor(getFileClassify)
const getFileClassifyProvider = GetFileClassifyFamily();

/// See also [getFileClassify].
class GetFileClassifyFamily extends Family<FileClassify> {
  /// See also [getFileClassify].
  const GetFileClassifyFamily();

  /// See also [getFileClassify].
  GetFileClassifyProvider call(
    String extension,
  ) {
    return GetFileClassifyProvider(
      extension,
    );
  }

  @override
  GetFileClassifyProvider getProviderOverride(
    covariant GetFileClassifyProvider provider,
  ) {
    return call(
      provider.extension,
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
  String? get name => r'getFileClassifyProvider';
}

/// See also [getFileClassify].
class GetFileClassifyProvider extends AutoDisposeProvider<FileClassify> {
  /// See also [getFileClassify].
  GetFileClassifyProvider(
    this.extension,
  ) : super.internal(
          (ref) => getFileClassify(
            ref,
            extension,
          ),
          from: getFileClassifyProvider,
          name: r'getFileClassifyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getFileClassifyHash,
          dependencies: GetFileClassifyFamily._dependencies,
          allTransitiveDependencies:
              GetFileClassifyFamily._allTransitiveDependencies,
        );

  final String extension;

  @override
  bool operator ==(Object other) {
    return other is GetFileClassifyProvider && other.extension == extension;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, extension.hashCode);

    return _SystemHash.finish(hash);
  }
}

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
String _$fileListHash() => r'dc5e9ab712f3264a01c511b8bfdb48734e77c948';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member

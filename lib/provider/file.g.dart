// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sortListHash() => r'7cd70b2377d16594a7952ffb6617563823d9c6e7';

/// See also [sortList].
@ProviderFor(sortList)
final sortListProvider = AutoDisposeProvider<List<RenameFile>>.internal(
  sortList,
  name: r'sortListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sortListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SortListRef = AutoDisposeProviderRef<List<RenameFile>>;
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
String _$getAllFileHash() => r'c4c4d5e04a471ac08f8cfc0f0eb0b02eb3801ef1';

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

typedef GetAllFileRef = AutoDisposeProviderRef<List<String>>;

/// See also [getAllFile].
@ProviderFor(getAllFile)
const getAllFileProvider = GetAllFileFamily();

/// See also [getAllFile].
class GetAllFileFamily extends Family<List<String>> {
  /// See also [getAllFile].
  const GetAllFileFamily();

  /// See also [getAllFile].
  GetAllFileProvider call(
    String folder,
  ) {
    return GetAllFileProvider(
      folder,
    );
  }

  @override
  GetAllFileProvider getProviderOverride(
    covariant GetAllFileProvider provider,
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
  String? get name => r'getAllFileProvider';
}

/// See also [getAllFile].
class GetAllFileProvider extends AutoDisposeProvider<List<String>> {
  /// See also [getAllFile].
  GetAllFileProvider(
    this.folder,
  ) : super.internal(
          (ref) => getAllFile(
            ref,
            folder,
          ),
          from: getAllFileProvider,
          name: r'getAllFileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAllFileHash,
          dependencies: GetAllFileFamily._dependencies,
          allTransitiveDependencies:
              GetAllFileFamily._allTransitiveDependencies,
        );

  final String folder;

  @override
  bool operator ==(Object other) {
    return other is GetAllFileProvider && other.folder == folder;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, folder.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getFileClassifyHash() => r'06e7975cee32e4b3b3eec8979ead427d56e0e5ec';
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
String _$fileListHash() => r'8d06cf0b8a1a9748bd5fa0fd9e3fc167f71a2ef0';

/// See also [FileList].
@ProviderFor(FileList)
final fileListProvider =
    AutoDisposeNotifierProvider<FileList, List<RenameFile>>.internal(
  FileList.new,
  name: r'fileListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fileListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FileList = AutoDisposeNotifier<List<RenameFile>>;
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

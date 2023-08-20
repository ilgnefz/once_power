// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_file.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getFileClassifyHash() => r'f67c8021c99d8c57370a7d1852b5add6f557c6c8';

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

String _$getAllFileHash() => r'c4c4d5e04a471ac08f8cfc0f0eb0b02eb3801ef1';
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

String _$fileListHash() => r'1f9d6b6da4a4d8fc9338ef03de6e78a85455b859';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member

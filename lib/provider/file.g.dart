// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FileList)
final fileListProvider = FileListProvider._();

final class FileListProvider
    extends $NotifierProvider<FileList, List<FileInfo>> {
  FileListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileListHash();

  @$internal
  @override
  FileList create() => FileList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FileInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FileInfo>>(value),
    );
  }
}

String _$fileListHash() => r'd04cad69016622d5da46ce9a8e416b1cfdd1d993';

abstract class _$FileList extends $Notifier<List<FileInfo>> {
  List<FileInfo> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<FileInfo>, List<FileInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<FileInfo>, List<FileInfo>>,
              List<FileInfo>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

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

String _$sortListHash() => r'9d554534898fa5d17b971b1896a1ba93debfc130';

@ProviderFor(PreviewFile)
final previewFileProvider = PreviewFileProvider._();

final class PreviewFileProvider
    extends $NotifierProvider<PreviewFile, FileInfo?> {
  PreviewFileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'previewFileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$previewFileHash();

  @$internal
  @override
  PreviewFile create() => PreviewFile();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileInfo? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileInfo?>(value),
    );
  }
}

String _$previewFileHash() => r'fb928f92201239e9da8f4ef6bbf95a887ffd4ae2';

abstract class _$PreviewFile extends $Notifier<FileInfo?> {
  FileInfo? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<FileInfo?, FileInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FileInfo?, FileInfo?>,
              FileInfo?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

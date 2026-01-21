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

String _$fileListHash() => r'e87b6e52d9f675e7dda7aa416cf7c631f31a79ba';

abstract class _$FileList extends $Notifier<List<FileInfo>> {
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

@ProviderFor(SelectAll)
final selectAllProvider = SelectAllProvider._();

final class SelectAllProvider extends $NotifierProvider<SelectAll, bool> {
  SelectAllProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectAllProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectAllHash();

  @$internal
  @override
  SelectAll create() => SelectAll();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$selectAllHash() => r'bb39801d68715244071f9e67dda3c91743b3204c';

abstract class _$SelectAll extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

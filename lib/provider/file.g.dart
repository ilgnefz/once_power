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

String _$fileListHash() => r'2f907bab0d26c4189cba6d1d1a12fe8fb39d8f2b';

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

@ProviderFor(PrefixUploadMark)
final prefixUploadMarkProvider = PrefixUploadMarkProvider._();

final class PrefixUploadMarkProvider
    extends $NotifierProvider<PrefixUploadMark, UploadMarkInfo?> {
  PrefixUploadMarkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prefixUploadMarkProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prefixUploadMarkHash();

  @$internal
  @override
  PrefixUploadMark create() => PrefixUploadMark();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UploadMarkInfo? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UploadMarkInfo?>(value),
    );
  }
}

String _$prefixUploadMarkHash() => r'fe2029ace5e00d4745363c573f3f6888f16e26e9';

abstract class _$PrefixUploadMark extends $Notifier<UploadMarkInfo?> {
  UploadMarkInfo? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UploadMarkInfo?, UploadMarkInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UploadMarkInfo?, UploadMarkInfo?>,
              UploadMarkInfo?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SuffixUploadMark)
final suffixUploadMarkProvider = SuffixUploadMarkProvider._();

final class SuffixUploadMarkProvider
    extends $NotifierProvider<SuffixUploadMark, UploadMarkInfo?> {
  SuffixUploadMarkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'suffixUploadMarkProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$suffixUploadMarkHash();

  @$internal
  @override
  SuffixUploadMark create() => SuffixUploadMark();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UploadMarkInfo? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UploadMarkInfo?>(value),
    );
  }
}

String _$suffixUploadMarkHash() => r'df10099259826d610543a3bb403bc91cb441b3ae';

abstract class _$SuffixUploadMark extends $Notifier<UploadMarkInfo?> {
  UploadMarkInfo? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UploadMarkInfo?, UploadMarkInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UploadMarkInfo?, UploadMarkInfo?>,
              UploadMarkInfo?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

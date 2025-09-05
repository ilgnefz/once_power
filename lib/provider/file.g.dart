// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(FileList)
const fileListProvider = FileListProvider._();

final class FileListProvider
    extends $NotifierProvider<FileList, List<FileInfo>> {
  const FileListProvider._()
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

String _$fileListHash() => r'36b4c18a6ea76c8e93fee3601edbdf8860c8ef25';

abstract class _$FileList extends $Notifier<List<FileInfo>> {
  List<FileInfo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<FileInfo>, List<FileInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<FileInfo>, List<FileInfo>>,
              List<FileInfo>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SortHoverFile)
const sortHoverFileProvider = SortHoverFileProvider._();

final class SortHoverFileProvider
    extends $NotifierProvider<SortHoverFile, FileInfo?> {
  const SortHoverFileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortHoverFileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortHoverFileHash();

  @$internal
  @override
  SortHoverFile create() => SortHoverFile();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileInfo? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileInfo?>(value),
    );
  }
}

String _$sortHoverFileHash() => r'e86ba6f0a0b120375aa4fb28f83b38f422a20f9d';

abstract class _$SortHoverFile extends $Notifier<FileInfo?> {
  FileInfo? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FileInfo?, FileInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FileInfo?, FileInfo?>,
              FileInfo?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SelectAll)
const selectAllProvider = SelectAllProvider._();

final class SelectAllProvider extends $NotifierProvider<SelectAll, bool> {
  const SelectAllProvider._()
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
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(PrefixUploadMark)
const prefixUploadMarkProvider = PrefixUploadMarkProvider._();

final class PrefixUploadMarkProvider
    extends $NotifierProvider<PrefixUploadMark, UploadMarkInfo?> {
  const PrefixUploadMarkProvider._()
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
    final created = build();
    final ref = this.ref as $Ref<UploadMarkInfo?, UploadMarkInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UploadMarkInfo?, UploadMarkInfo?>,
              UploadMarkInfo?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SuffixUploadMark)
const suffixUploadMarkProvider = SuffixUploadMarkProvider._();

final class SuffixUploadMarkProvider
    extends $NotifierProvider<SuffixUploadMark, UploadMarkInfo?> {
  const SuffixUploadMarkProvider._()
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
    final created = build();
    final ref = this.ref as $Ref<UploadMarkInfo?, UploadMarkInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UploadMarkInfo?, UploadMarkInfo?>,
              UploadMarkInfo?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

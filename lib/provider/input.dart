import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'input.g.dart';

@riverpod
class MatchText extends _$MatchText {
  @override
  String build() => '';
  void update(String value) => state = value;
}

@riverpod
class ModifyText extends _$ModifyText {
  @override
  String build() => '';
  void update(String value) => state = value;
}

@riverpod
class PrefixText extends _$PrefixText {
  @override
  String build() => '';
  void update(String value) => state = value;
}

@riverpod
class PrefixPlaceNum extends _$PrefixPlaceNum {
  @override
  int build() => 0;
  void update(int value) => state = value;
}

@riverpod
class PrefixStartNum extends _$PrefixStartNum {
  @override
  int build() => 0;
  void update(int value) => state = value;
}

@riverpod
class SuffixText extends _$SuffixText {
  @override
  String build() => '';
  void update(String value) => state = value;
}

@riverpod
class SuffixPlaceNum extends _$SuffixPlaceNum {
  @override
  int build() => 0;
  void update(int value) => state = value;
}

@riverpod
class SuffixStartNum extends _$SuffixStartNum {
  @override
  int build() => 0;
  void update(int value) => state = value;
}

@riverpod
class FileExtension extends _$FileExtension {
  @override
  String build() => '';
  void update(String value) => state = value;
}

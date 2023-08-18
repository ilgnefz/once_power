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
class DateLength extends _$DateLength {
  @override
  int build() => 8;
  void update(int value) => state = value;
}

@riverpod
class PrefixText extends _$PrefixText {
  @override
  String build() => '';
  void update(String value) => state = value;
}

@riverpod
class PrefixNumLength extends _$PrefixNumLength {
  @override
  int build() => 0;
  void update(int value) => state = value;
}

@riverpod
class PrefixNumStart extends _$PrefixNumStart {
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
class SuffixNumLength extends _$SuffixNumLength {
  @override
  int build() => 0;
  void update(int value) => state = value;
}

@riverpod
class SuffixNumStart extends _$SuffixNumStart {
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

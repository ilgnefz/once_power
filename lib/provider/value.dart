import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'value.g.dart';

@riverpod
class DateDigit extends _$DateDigit {
  @override
  int build() => 8;

  void update(int value) => state = value;
}

@riverpod
class PrefixDigit extends _$PrefixDigit {
  @override
  int build() => 0;

  void update(int value) => state = value;
}

@riverpod
class PrefixStart extends _$PrefixStart {
  @override
  int build() => 0;

  void update(int value) => state = value;
}

@riverpod
class SuffixDigit extends _$SuffixDigit {
  @override
  int build() => 0;

  void update(int value) => state = value;
}

@riverpod
class SuffixStart extends _$SuffixStart {
  @override
  int build() => 0;

  void update(int value) => state = value;
}

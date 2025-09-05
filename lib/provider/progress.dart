import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress.g.dart';

@riverpod
class CurrentFile extends _$CurrentFile {
  @override
  String build() => '';
  void update(String value) => state = value;
}

@riverpod
class Count extends _$Count {
  @override
  int build() => 0;
  void update() => state++;
  void reset() => state = 0;
}

@riverpod
class Total extends _$Total {
  @override
  int build() => 0;
  void update(int value) => state = value;
}

@riverpod
class Cost extends _$Cost {
  @override
  double build() => 0.0;
  void update(double value) => state = value;
}

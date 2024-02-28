import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress.g.dart';

@riverpod
class Count extends _$Count {
  @override
  int build() => 0;
  void update(int value) => state = value;
  void clear() => state = 0;
  // void reduce() => state = state - 1;
}

@riverpod
class Total extends _$Total {
  @override
  int build() => 0;
  void update(int value) => state = value;
  void clear() => state = 0;
}

@riverpod
class Cost extends _$Cost {
  @override
  double build() => 0;
  void update(double value) => state = value;
  void clear() => state = 0;
}

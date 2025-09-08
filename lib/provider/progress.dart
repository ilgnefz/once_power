import 'package:once_power/models/progress.dart';
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

@riverpod
class CurrentProgressFile extends _$CurrentProgressFile {
  @override
  ProgressFileInfo? build() => null;
  void update(ProgressFileInfo value) => state = value;
  void clear() => state = null;
}

@riverpod
class CurrentSize extends _$CurrentSize {
  @override
  int build() => 0;
  void update(int value) => state += value;
  void clear() => state = 0;
}

@riverpod
class IsApplying extends _$IsApplying {
  @override
  bool build() => false;
  void start() => state = true;
  void finish() => state = false;
}

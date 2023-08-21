import 'package:once_power/provider/file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress.g.dart';

@riverpod
class Total extends _$Total {
  @override
  int build() => 0;
  void update(int value) => state = value;
  void clear() => state = 0;
  void reduce() => state = state - 1;
}

@riverpod
int count(CountRef ref) => ref.watch(fileListProvider).length;

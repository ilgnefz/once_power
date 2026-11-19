import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list.g.dart';

@riverpod
class SelectedIds extends _$SelectedIds {
  @override
  List<String> build() => [];

  void add(String id) => state = [...state, id];

  void addAll(List<String> ids) => state = ids;

  void remove(String id) =>
      state = state.where((element) => element != id).toList();

  void clear() => state = [];
}

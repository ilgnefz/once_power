import 'package:once_power/model/enum.dart';

class CheckList {
  FileClassify classify;
  bool check;

  CheckList({required this.classify, required this.check});

  @override
  String toString() {
    return 'CheckList(classify: $classify, check: $check)';
  }
}

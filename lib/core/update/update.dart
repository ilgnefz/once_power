import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/provider/select.dart';

import 'normal.dart';

void updateName(WidgetRef ref) {
  FunctionMode mode = ref.read(currentModeProvider);
  switch (mode) {
    case FunctionMode.replace:
      normalUpdateName(ref, true);
      break;
    case FunctionMode.reserve:
      normalUpdateName(ref, false);
      break;
    case FunctionMode.advance:
      advanceUpdateName(ref);
      break;
    default:
      break;
  }
}

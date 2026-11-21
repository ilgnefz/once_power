import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';

import '../add.dart';
import '../case.dart';
import '../pick.dart';
import 'chip.dart';
import 'date.dart';
import 'extension.dart';
import 'prefix_index.dart';
import 'match.dart';
import 'modify.dart';
import 'prefix.dart';
import 'suffix.dart';
import 'suffix_index.dart';

class ActionNormal extends StatelessWidget {
  const ActionNormal(this.isReplace, {super.key});

  final bool isReplace;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(vertical: AppNumber.spaceMedium),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: AppNumber.spaceMedium,
                children: [
                  const MatchInput(),
                  MatchChip(isReplace),
                  const ModifyInput(),
                  const DateInput(),
                  const PrefixInput(),
                  const PrefixIndexInput(),
                  const SuffixInput(),
                  const SuffixIndexInput(),
                  const ExtensionInput(),
                ],
              ),
            ),
          ),
          const CaseGroup(),
          const AddGroup(),
          SizedBox(height: AppNumber.spaceSmall),
          const PickerGroup(),
        ],
      ),
    );
  }
}

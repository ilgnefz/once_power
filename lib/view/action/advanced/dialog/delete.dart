import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/advance.dart';
import 'package:once_power/enmu/delete.dart';
import 'package:once_power/enmu/file.dart';
import 'package:once_power/widget/action/mode_switch.dart';

import 'frame.dart';
import 'delete_extension.dart';
import 'delete_input.dart';
import 'delete_type.dart';
import 'match_part.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({super.key});

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog>
    with AutomaticKeepAliveClientMixin {
  String match = '', extension = '', group = 'all';
  bool regex = false, deleteExtension = false;
  DeleteMode mode = .enter;
  MatchContent content = .number;
  MatchPosition position = .self;
  int number = 1, font = 1, behind = 1, start = 1, digit = 1;
  List<DeleteType> deleteTypes = [];
  DeleteExtensionType extensionType = .all;
  FileType fileType = .image;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Localizations.localeOf(context);
    return AdvanceDialogFrame(
      group: group,
      onComplete: () {},
      onCompleteExit: () => Navigator.of(context).pop(),
      onGroupChange: (value) => setState(() => group = value),
      child: Column(
        children: [
          Wrap(
            alignment: .center,
            spacing: AppNumber.space,
            children: DeleteMode.values.map((e) {
              return ModeSwitchItem(
                selected: mode == e,
                label: e.label,
                onTap: () => setState(() => mode = e),
              );
            }).toList(),
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          DeleteInputGroup(
            selected: mode.isEnter,
            match: match,
            onMatchChanged: (value) {
              match = value;
              mode = .enter;
              setState(() {});
            },
            regex: regex,
            onRegexPressed: () {
              regex = !regex;
              mode = .enter;
              setState(() {});
            },
            content: content,
            onContentChanged: (value) {
              content = value;
              mode = .enter;
              setState(() {});
            },
            number: number,
            onNumberChanged: (value) {
              number = value;
              mode = .enter;
              setState(() {});
            },
            position: position,
            onPositionChanged: (value) {
              position = value;
              mode = .enter;
              setState(() {});
            },
            front: font,
            onFrontChanged: (value) {
              font = value;
              mode = .enter;
              setState(() {});
            },
            behind: behind,
            onBehindChanged: (value) {
              behind = value;
              mode = .enter;
              setState(() {});
            },
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          MatchPartGroup(
            selected: mode.isPart,
            start: start,
            digit: digit,
            onStartChanged: (value) {
              start = value;
              mode = .part;
              setState(() {});
            },
            onDigitChanged: (value) {
              digit = value;
              mode = .part;
              setState(() {});
            },
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          DeleteTypeGroup(
            selected: mode.isType,
            deleteTypes: deleteTypes,
            onChanged: (value) => setState(() {
              deleteTypes.contains(value)
                  ? deleteTypes.remove(value)
                  : deleteTypes.add(value);
              mode = .type;
            }),
            onAllChanged: (value) => setState(() {
              deleteTypes = value
                  ? Set<DeleteType>.from(DeleteType.values).toList()
                  : [];
              mode = .type;
            }),
          ),
          DeleteExtensionGroup(
            selected: mode.isExtension,
            extensionType: extensionType,
            onExtensionTypeChanged: (value) {
              extensionType = value;
              mode = .extension;
              setState(() {});
            },
            fileType: fileType,
            onFileTypeChanged: (value) {
              fileType = value;
              mode = .extension;
              setState(() {});
            },
            enter: extension,
            onEnterChanged: (value) {
              extension = value;
              mode = .extension;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

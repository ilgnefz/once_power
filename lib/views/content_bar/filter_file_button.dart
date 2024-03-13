import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/rename.dart';

class FilterFileButton extends ConsumerWidget {
  const FilterFileButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String delete = S.of(context).deleted;

    bool isCheck(FileClassify classify) {
      if (classify == FileClassify.audio) return ref.watch(selectAudioProvider);
      if (classify == FileClassify.other) return ref.watch(selectOtherProvider);
      if (classify == FileClassify.image) return ref.watch(selectImageProvider);
      if (classify == FileClassify.text) return ref.watch(selectTextProvider);
      if (classify == FileClassify.video) return ref.watch(selectVideoProvider);
      if (classify == FileClassify.zip) return ref.watch(selectZipProvider);
      return ref.watch(selectFolderProvider);
    }

    void remove() {
      ref.read(fileListProvider.notifier).removeUncheck();
      Navigator.of(context).pop();
    }

    DropdownMenuItem deleteUncheck() {
      return DropdownMenuItem(
        value: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppNum.fileCardP),
          child: InkWell(
            onTap: remove,
            child: Text(delete, style: const TextStyle(color: Colors.red)),
          ),
        ),
      );
    }

    List<DropdownMenuItem> items = ref.watch(classifyListProvider).map(
      (e) {
        return DropdownMenuItem(
          value: e,
          child: StatefulBuilder(
            builder: (context, setState) {
              void toggleCheck(v) {
                ref.read(fileListProvider.notifier).checkPart(e, !isCheck(e));
                updateName(ref);
                updateExtension(ref);
                setState(() {});
              }

              return Row(
                children: [
                  Checkbox(value: isCheck(e), onChanged: toggleCheck),
                  Text(e.value),
                ],
              );
            },
          ),
        );
      },
    ).toList();

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(
          Icons.filter_alt_rounded,
          size: 24,
          color: AppColors.icon,
        ),
        items: [deleteUncheck(), ...items],
        onChanged: (value) {},
        dropdownStyleData: DropdownStyleData(
          width: 152,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          offset: const Offset(-48, 0),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: AppNum.fileCardP),
        ),
      ),
    );
  }
}

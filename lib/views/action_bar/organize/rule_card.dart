import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/action_bar/folder_input.dart';

class RuleCard extends StatelessWidget {
  const RuleCard({
    super.key,
    required this.title,
    required this.cacheKey,
    required this.cacheListKey,
  });

  final String title;
  final String cacheKey;
  final String cacheListKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppNum.inputP, vertical: AppNum.smallG),
      child: Row(
        // spacing: AppNum.smallG,
        children: [
          Text('$title:'),
          Expanded(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return FolderInput(
                  cacheKey: cacheKey,
                  cacheListKey: cacheListKey,
                  cache: ref.watch(isSaveConfigProvider),
                  value: StorageUtil.getString(cacheKey) ?? '',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

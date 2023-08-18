import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/check_tile.dart';
import 'package:once_power/widgets/normal_tile.dart';

class ContentBar extends StatelessWidget {
  const ContentBar({super.key});

  @override
  Widget build(BuildContext context) {
    const String originName = '原始名称';
    const String renameName = '重命名名称';

    return Expanded(
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: AppNum.fileCardH,
              // width: double.infinity,
              child: Row(
                children: [
                  const CheckTile(originName),
                  const NormalTile(renameName),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_alt_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_forever_rounded),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Consumer(
                  builder: (context, ref, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(ref.watch(matchTextProvider)),
                        Text(ref.watch(modifyTextProvider)),
                        Text(ref.watch(dateLengthProvider).toString()),
                        Text(ref.watch(currentDateTypeProvider).value),
                        Text(ref.watch(prefixTextProvider)),
                        Text(ref.watch(prefixNumLengthProvider).toString()),
                        Text(ref.watch(prefixNumStartProvider).toString()),
                        Text(ref.watch(suffixTextProvider)),
                        Text(ref.watch(suffixNumLengthProvider).toString()),
                        Text(ref.watch(suffixNumStartProvider).toString()),
                        Text(ref.watch(fileExtensionProvider)),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

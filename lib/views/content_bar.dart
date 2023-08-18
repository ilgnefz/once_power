import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/views/content_bar/top_title_bar.dart';

class ContentBar extends StatelessWidget {
  const ContentBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            const TopTitleBar(),
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

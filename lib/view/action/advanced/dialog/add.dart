import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';

import 'button.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double contentMax =
            (constraints.maxHeight -
                    AppNumber.widgetHeight -
                    AppNumber.spaceMedium)
                .clamp(0.0, double.infinity)
                .toDouble();
        return Column(
          spacing: AppNumber.spaceMedium,
          mainAxisSize: .min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: contentMax),
              child: SingleChildScrollView(
                padding: .symmetric(horizontal: AppNumber.padding),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1296 / 1728,
                      child: Image.file(
                        File(r'D:\天翼云盘下载\AI\ewpKRA1.jpeg'),
                        fit: .cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ButtonGroup(
              group: '0',
              onComplete: () {},
              onCompleteExit: () {},
              onGroupChange: (value) {},
            ),
          ],
        );
      },
    );
  }
}

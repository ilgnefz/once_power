import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/my_text.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
    required this.count,
    required this.total,
    required this.tip,
    required this.onPressed,
  }) : super(key: key);

  final int count;
  final int total;
  final String tip;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/loading.gif'),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: SizedBox(
              width: 400,
              height: 8,
              child: LinearProgressIndicator(value: count / total),
            ),
          ),
          const SizedBox(height: 12),
          MyText(
            tip == S.of(context).adding
                ? '${S.of(context).adding} $count/$total'
                : '${S.of(context).processing} $count/$total',
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: onPressed,
            child: MyText(tip == S.of(context).adding
                ? S.of(context).cancelAdd
                : S.of(context).cancelProcessing),
          ),
        ],
      ),
    );
  }
}

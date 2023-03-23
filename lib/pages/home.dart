import 'package:flutter/material.dart';
import 'package:once_power/pages/action_bar.dart';
import 'package:once_power/pages/content_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: const [
            SizedBox(width: 320, child: ActionBar()),
            SizedBox(width: 8),
            Expanded(child: ContentBar()),
          ],
        ),
      ),
    );
  }
}

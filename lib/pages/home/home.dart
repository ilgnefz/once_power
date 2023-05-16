import 'package:flutter/material.dart';
import 'package:once_power/pages/home/action_bar.dart';

import 'content_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(width: 320, child: ActionBar()),
            SizedBox(width: 8),
            Expanded(child: ContentBar()),
          ],
        ),
      ),
    );
  }
}

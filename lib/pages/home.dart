import 'package:flutter/material.dart';
import 'package:once_power/pages/action_bar.dart';
import 'package:once_power/pages/content_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(width: 320, child: ActionBar()),
          Expanded(child: ContentBar()),
        ],
      ),
    );
  }
}

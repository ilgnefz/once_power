import 'package:flutter/material.dart';
import 'package:once_power/views/action_bar/action_bar.dart';
import 'package:once_power/views/bottom_bar.dart';
import 'package:once_power/views/content_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(child: Row(children: [ActionBar(), ContentBar()])),
          BottomBar(),
        ],
      ),
    );
  }
}

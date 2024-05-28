import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.error,
      fit: BoxFit.none,
    );
  }
}

import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  const UploadButton(this.onPress, {Key? key}) : super(key: key);

  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: Icon(
        Icons.upload_file_rounded,
        size: 20,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

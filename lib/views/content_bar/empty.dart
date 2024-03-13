import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.drive_folder_upload_rounded,
            size: 80,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            S.of(context).tip,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

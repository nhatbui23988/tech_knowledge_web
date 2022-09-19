import 'package:flutter/material.dart';

class AppDialog {
  static Future showAppDialog(BuildContext context, Widget dialogWidget) async {
    final result = await showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(content: dialogWidget);
        });
    return result;
  }
}

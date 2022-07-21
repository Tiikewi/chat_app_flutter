import 'package:flutter/material.dart';

Future<void> popDialog(
    {required BuildContext context, required String title, String? content}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content ?? ""),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "OK",
                  textAlign: TextAlign.end,
                ))
          ],
        );
      });
}

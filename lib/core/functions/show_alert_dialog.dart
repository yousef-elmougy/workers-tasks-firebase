import 'package:flutter/material.dart';

Future<void> showAlertDialog(
  context, {
  required String content,
  required VoidCallback onPressed,
}) async =>
    await showDialog<void>(
      context: context,
      builder: (context) =>  AlertDialog(
              title: const Text("Warning !!"),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: const Text("Confirm"),
                ),
              ],
            ),
    );

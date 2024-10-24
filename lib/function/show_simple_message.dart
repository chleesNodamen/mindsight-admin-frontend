import 'package:flutter/material.dart';

void showSimpleMessage(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('알림'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('확인'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

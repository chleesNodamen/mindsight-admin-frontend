import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showSimpleMessage(String message) async {
  await showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Notification".tr),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text("Confirm".tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

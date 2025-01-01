import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showSimpleMessage(String message) async {
  await showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("알림".tr),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text("확인".tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

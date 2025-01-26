// src/utils/dialog_utils.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindsight_admin_page/theme/custom_text_style.dart';

Future<bool?> showDeleteConfirmationDialog() {
  return Get.dialog<bool>(
    AlertDialog(
      title: Text(
        "Delete Confirmation",
        style: CustomTextStyles.titleLargeBlack,
      ),
      content: Text(
        "Are you sure you want to delete?",
        style: CustomTextStyles.bodyLargeBlack,
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Get.back(result: true),
          child: const Text("Delete"),
        ),
      ],
    ),
  );
}

import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';

/// 범용 업로드 서비스
/// 다른 페이지에서도 재사용 가능한 업로드 진행률 다이얼로그를 제공합니다.
class UploadService {
  /// 파일 업로드를 진행하고, 진행률 다이얼로그를 띄운 뒤 성공 여부를 반환합니다.
  static Future<bool> uploadWithProgressDialog({
    required File file,
    required String endpoint,
    required String fileName,
  }) async {
    final progressNotifier = ValueNotifier<double>(0.0);

    // 다이얼로그 표시
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text("Uploading...".tr),
        content: ValueListenableBuilder<double>(
          valueListenable: progressNotifier,
          builder: (_, value, __) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(value: value),
              const SizedBox(height: 8),
              Text("${(value * 100).toStringAsFixed(1)}%"),
            ],
          ),
        ),
      ),
    );

    // 실제 업로드 수행
    final success = await UploadRepository().uploadWithProgress(
      file: file,
      endpoint: endpoint,
      fileName: fileName,
      onProgress: (p) => progressNotifier.value = p,
    );

    // 다이얼로그 닫기
    Navigator.of(Get.context!).pop();
    return success;
  }
}

// 사용 예시:
// if (mediaFile != null) {
//   final ok = await UploadService.uploadWithProgressDialog(
//     file: mediaFile!,
//     endpoint: 'upload/media',
//     fileName: mediaBlobName,
//   );
//   if (!ok) return showSimpleMessage('업로드 실패');
// }

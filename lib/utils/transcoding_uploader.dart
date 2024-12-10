// ignore_for_file: unused_import

import 'dart:io';
import 'package:get/get.dart';
import 'package:mindsight_admin_page/data/upload/upload_model.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:mindsight_admin_page/utils/ffmpeg_service.dart';
import 'package:mindsight_admin_page/utils/logger.dart';
import 'dart:html' as html;

class TranscodingUploader {
  final RxString ffmpegStatus = "".obs;
  late FFmpegService _ffmpegService;

  Future<String> uploadTranscoding(html.File filePickerResult) async {
    try {
      _ffmpegService = FFmpegService(
        onProgress: (ratio) {
          ffmpegStatus.value =
              "트랜스코딩 진행율: ${(ratio * 100).toStringAsFixed(2)}%";

          if (ratio > 0.95) {
            ffmpegStatus.value = "트랜스코딩 최종 정리 중..기다려 주십시오..";
          }
          Logger.info("트랜스코딩 진행율: ${(ratio * 100).toStringAsFixed(2)}%");
        },
        onLog: (log) {
          Logger.info(log);
        },
      );

      await _ffmpegService.loadFFmpeg();

      Map<String, List<dynamic>> fileInfo =
          await _ffmpegService.transcodeToM3U8(filePickerResult);

      List<dynamic>? filename = fileInfo["filename"];
      List<dynamic>? data = fileInfo["data"];

      Logger.info("트랜 코딩 된 파일리스트: $filename");

      String folder = '';
      String mediaUrl = '';

      for (int i = 0; i < filename!.length; i++) {
        ffmpegStatus.value = "업로드 진행율: $i/${filename.length}%";

        if (filename[i].contains(".m3u8")) {
          UploadModel model = await UploadRepository()
              .uploadFileTrascoding(filename[i], data![i], folder);

          if (folder.isEmpty) {
            mediaUrl = model.url!;
            folder = model.folder!;
          }
        } else {
          await UploadRepository()
              .uploadFileTrascoding(filename[i], data![i], folder);
        }
      }

      // ffmpegStatus.value = "업로드 진행율: ${filename.length}/${filename.length}%";

      ffmpegStatus.value = "트랜스코딩 완료";

      _ffmpegService.dispose();
      return mediaUrl;
    } catch (e) {
      ffmpegStatus.value = '트랜스코딩 중 에러 발생: $e';
      _ffmpegService.dispose();
      Logger.info('트랜스코딩 중 에러 발생: $e');
      rethrow;
    }
  }
}

// ignore_for_file: unused_import

import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:mindsight_admin_page/data/upload/upload_model.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:mindsight_admin_page/utils/ffmpeg_service.dart';
import 'package:mindsight_admin_page/utils/logger.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:universal_html/html.dart';

class TranscodingUploader {
  final RxString ffmpegStatus = "".obs;
  FFmpegService? _ffmpegService;

  Future<String> uploadTranscoding(html.File filePickerResult) async {
    try {
      List<dynamic>? filename;
      List<dynamic>? data;

      bool isMp4 = filePickerResult.name.toLowerCase().endsWith('.mp4');

      if (isMp4) {
        _ffmpegService = FFmpegService(
          onProgress: (ratio) {
            ffmpegStatus.value =
                "${"Transcoding Progress".tr}: ${(ratio * 100).toStringAsFixed(2)}%";

            Logger.info(
                "Transcoding Progress: ${(ratio * 100).toStringAsFixed(2)}%");
          },
          onLog: (log) {
            Logger.info(log);
          },
        );

        await _ffmpegService?.loadFFmpeg();

        Map<String, List<dynamic>> fileInfo =
            await _ffmpegService!.transcodeToM3U8(filePickerResult);

        filename = fileInfo["filename"];
        data = fileInfo["data"];

        _ffmpegService!.dispose();
      } else {
        filename = [filePickerResult.name];

        final reader = FileReader();
        reader.readAsArrayBuffer(filePickerResult);
        await reader.onLoadEnd.first;
        Uint8List fileBytes = reader.result as Uint8List;

        data = [fileBytes];
      }

      Logger.info("트랜 코딩 된 File리스트: $filename");
      // Logger.info("트랜 코딩 된 File Data: $data");

      String folder = '';
      String mediaUrl = '';

      for (int i = 0; i < filename!.length; i++) {
        ffmpegStatus.value = "업로드 진행율: $i/${filename.length}%";

        UploadModel model = await UploadRepository()
            .uploadFileTrascoding(filename[i], data![i], folder);

        if (filename[i].contains(".m3u8") ||
            filename[i].contains(".mp3") ||
            filename[i].contains(".wav")) {
          if (folder.isEmpty) {
            mediaUrl = model.url!;
            folder = model.folder!;
          }
        }
      }

      ffmpegStatus.value = "트랜스코딩 Complete";

      return mediaUrl;
    } catch (e) {
      ffmpegStatus.value = '트랜스코딩 중 에러 발생: $e';
      Logger.info('트랜스코딩 중 에러 발생: $e');

      _ffmpegService?.dispose();

      rethrow;
    }
  }
}

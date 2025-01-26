// import 'dart:typed_data';
// import 'package:get/get.dart';
// import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
// import 'package:mindsight_admin_page/utils/ffmpeg_service.dart';
// import 'package:mindsight_admin_page/utils/logger.dart';
// // ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html;
// import 'package:universal_html/html.dart';

// class TranscodingUploader {
//   final RxString ffmpegStatus = "".obs;
//   bool isTranscodingComplete = false;
//   FFmpegService? _ffmpegService;
//   String mediaUrl = "";
//   List<dynamic>? filename;
//   List<dynamic>? data;

//   Future<String> transcoding(html.File filePickerResult) async {
//     try {
//       await dispose();
//       isTranscodingComplete = false;

//       bool isMp4 = filePickerResult.name.toLowerCase().endsWith('.mp4');

//       if (isMp4) {
//         _ffmpegService = FFmpegService(
//           onProgress: (ratio) {
//             ffmpegStatus.value =
//                 "${"Transcoding Progress".tr}: ${(ratio * 100).toStringAsFixed(2)}%";

//             Logger.info(
//                 "Transcoding Progress: ${(ratio * 100).toStringAsFixed(2)}%");
//           },
//           onLog: (log) {
//             Logger.info(log);
//           },
//         );

//         await _ffmpegService?.loadFFmpeg();

//         Map<String, List<dynamic>> fileInfo =
//             await _ffmpegService!.transcodeToM3U8(filePickerResult);

//         filename = fileInfo["filename"];
//         data = fileInfo["data"];

//         _ffmpegService!.dispose();
//         _ffmpegService = null;
//       } else {
//         filename = [filePickerResult.name];

//         final reader = FileReader();
//         reader.readAsArrayBuffer(filePickerResult);
//         await reader.onLoadEnd.first;
//         Uint8List fileBytes = reader.result as Uint8List;

//         data = [fileBytes];
//       }

//       Logger.info("트랜 코딩 된 File리스트: $filename");

//       ffmpegStatus.value = "Transcoding Complete".tr;
//       isTranscodingComplete = true;

//       return mediaUrl;
//     } catch (e) {
//       ffmpegStatus.value = '트랜스코딩 중 에러 발생: $e';
//       Logger.info('트랜스코딩 중 에러 발생: $e');

//       _ffmpegService?.dispose();
//       _ffmpegService = null;

//       isTranscodingComplete = false;

//       rethrow;
//     }
//   }

//   Future<void> upload(String folder) async {
//     for (int i = 0; i < filename!.length; i++) {
//       ffmpegStatus.value = "${"Upload Progress".tr}: $i/${filename!.length}%";

//       await UploadRepository()
//           .uploadFileBytes(filename![i], data![i], folder: folder);
//     }
//   }

//   Future<void> dispose() async {
//     _ffmpegService?.dispose();
//     _ffmpegService = null;

//     filename?.clear();
//     data?.clear();

//     isTranscodingComplete = false;

//     Logger.info("트랜스코딩 해제");
//   }
// }

import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:mindsight_admin_page/utils/ffmpeg_service.dart';
import 'package:mindsight_admin_page/utils/logger.dart';

class TranscodingUploader {
  final RxString ffmpegStatus = "".obs;
  bool isTranscodingComplete = false;
  FFmpegService? _ffmpegService;
  String mediaUrl = "";
  List<dynamic>? filename;
  List<dynamic>? data;
  int? durationTime;

  Future<String> transcoding(html.File filePickerResult) async {
    try {
      await dispose();
      isTranscodingComplete = false;

      // Get duration time
      durationTime = await getDurationTime(filePickerResult);
      Logger.info("Media Duration: $durationTime seconds");

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
        _ffmpegService = null;
      } else {
        filename = [filePickerResult.name];

        final reader = html.FileReader();
        reader.readAsArrayBuffer(filePickerResult);
        await reader.onLoadEnd.first;
        Uint8List fileBytes = reader.result as Uint8List;

        data = [fileBytes];
      }

      Logger.info("트랜 코딩 된 File리스트: $filename");

      ffmpegStatus.value = "Transcoding Complete".tr;
      isTranscodingComplete = true;

      return mediaUrl;
    } catch (e) {
      ffmpegStatus.value = '트랜스코딩 중 에러 발생: $e';
      Logger.info('트랜스코딩 중 에러 발생: $e');

      _ffmpegService?.dispose();
      _ffmpegService = null;

      isTranscodingComplete = false;

      rethrow;
    }
  }

  Future<int> getDurationTime(html.File? pickedFile) async {
    if (pickedFile == null) {
      throw Exception("No file selected");
    }

    final completer = Completer<int>();

    final url = html.Url.createObjectUrlFromBlob(pickedFile);
    final mediaElement = pickedFile.type.startsWith('video')
        ? html.VideoElement()
        : html.AudioElement();

    mediaElement.src = url;

    mediaElement.onLoadedMetadata.listen((event) {
      if (mediaElement.duration.isFinite) {
        completer.complete(mediaElement.duration.floor());
      } else {
        completer.completeError("Unable to determine duration");
      }
      mediaElement.remove();
      html.Url.revokeObjectUrl(url);
    });

    mediaElement.onError.listen((event) {
      completer.completeError("Error loading media");
      mediaElement.remove();
      html.Url.revokeObjectUrl(url);
    });

    return completer.future;
  }

  Future<void> upload(String folder) async {
    for (int i = 0; i < filename!.length; i++) {
      ffmpegStatus.value = "${"Upload Progress".tr}: $i/${filename!.length}%";

      await UploadRepository()
          .uploadFileBytes(filename![i], data![i], folder: folder);
    }
  }

  Future<void> dispose() async {
    _ffmpegService?.dispose();
    _ffmpegService = null;

    filename?.clear();
    data?.clear();
    durationTime = null;

    isTranscodingComplete = false;

    Logger.info("트랜스코딩 해제");
  }
}

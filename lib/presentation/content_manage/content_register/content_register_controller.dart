/*
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_repository.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_req_post.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'dart:html' as html;
import 'dart:js' as js;

class ContentRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  final Map<ContentCategory, List<ContentType>> contentType = {
    ContentCategory.body: [
      ContentType.basicBody,
      ContentType.intermediateBody,
      ContentType.advanceBody
    ],
    ContentCategory.breath: [
      ContentType.natureBreathing,
      ContentType.guidedMeditation,
    ],
    ContentCategory.mindfulness: [
      ContentType.mindfulArt,
      ContentType.artWithMusic,
      ContentType.nature,
      ContentType.kAsmr
    ],
    ContentCategory.theory: [
      ContentType.emotionManagement,
      ContentType.philosophy,
      ContentType.selfDevelopment
    ]
  };

  final List<ContentLanguage> contentLanguage = [
    ContentLanguage.english,
    ContentLanguage.korean,
    ContentLanguage.japanese
  ];

  List<ContentType> categoryContentType = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  late final focusNode = FocusNode();

  Rx<ContentCategory?> selectedCategory = Rx<ContentCategory?>(null);
  Rx<ContentType?> selectedType = Rx<ContentType?>(null);

  Rx<ContentLevel?> selectedLevel = Rx<ContentLevel?>(null);
  Rx<ContentLanguage?> selectedTargetLanguage = Rx<ContentLanguage?>(null);
  Rx<ContentExposure?> selectedExposure = Rx<ContentExposure?>(null);
  RxList<String> tags = <String>[].obs;

  RxString thumbnailName = "".obs;
  RxString ccName = "".obs;
  File? thumbnailFile;
  File? mediaFile;

  RxString ffmpegStatus = "".obs;
  late FFmpeg _ffmpeg;

  @override
  Future<void> onClose() async {
    super.onClose();

    tagController.dispose();
    introController.dispose();
    nameController.dispose();
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    await initData();
  }

  Future<void> initData() async {
    if (AppConstant.test) {
      await MasterSigninRepository().post(MasterSigninReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    introController.addListener(formatText);

    isInited.value = true;
    isLoading.value = false;
  }

  void selectCategory(ContentCategory? category) {
    // isLoading.value = true;
    selectedCategory.value = category;

    categoryContentType = contentType[category]!;
    selectedType.value = null;

    // isLoading.value = false;
  }

  void addTag(String tag) {
    // tags.add(tag.toLowerCase());
    tags.add(tag);
    tagController.text = "";
  }

  void formatText() {
    String text = introController.text;
    if (text.isEmpty) return;

    List<String> lines = text.split('\n');
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].startsWith('- ')) {
        lines[i] = '\t\t-\t\t';
      }
      if (lines[i].startsWith('* ')) {
        lines[i] = '\t\t•\t\t';
      }
    }
    String formattedText = lines.join('\n');
    if (formattedText != text) {
      introController.value = introController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  void nextList() {
    String text = introController.text;
    if (text.isEmpty) return;

    List<String> lines = text.split('\n');
    if (lines.last.startsWith('\t\t-\t\t')) {
      lines.add('\t\t-\t\t');
    }
    if (lines.last.startsWith('\t\t•\t\t')) {
      lines.add('\t\t•\t\t');
    }
    String formattedText = lines.join('\n');
    if (formattedText != text) {
      introController.value = introController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  bool isSaveValidate() {
    return true;
  }

  Future<void> _loadFFmpeg() async {
    _ffmpeg = createFFmpeg(
      CreateFFmpegParam(
        log: true,
        corePath: "https://unpkg.com/@ffmpeg/core@0.11.0/dist/ffmpeg-core.js",
      ),
    );

    _ffmpeg.setProgress(_onProgressHandler);
    _ffmpeg.setLogger(_onLogHandler);

    await _ffmpeg.load();

    Logger.info("ffmpeg 로드상태: ${_ffmpeg.isLoaded()}");
  }

  void _onProgressHandler(ProgressParam progress) {
    // final isDone = progress.ratio >= 1;

    ffmpegStatus.value = "트랜스코딩 진행율: ${progress.ratio.toStringAsFixed(2)}";

    Logger.info("트랜스코딩 진행율: ${progress.ratio.toStringAsFixed(2)}");
  }

  static final regex = RegExp(
    r'frame\s*=\s*(\d+)\s+fps\s*=\s*(\d+(?:\.\d+)?)\s+q\s*=\s*([\d.-]+)\s+L?size\s*=\s*(\d+)\w*\s+time\s*=\s*([\d:\.]+)\s+bitrate\s*=\s*([\d.]+)\s*(\w+)/s\s+speed\s*=\s*([\d.]+)x',
  );

  void _onLogHandler(LoggerParam logger) {
    if (logger.type == 'fferr') {
      final match = regex.firstMatch(logger.message);

      if (match != null) {
        // indicates the number of frames that have been processed so far.
        final frame = match.group(1);
        // is the current frame rate
        final fps = match.group(2);
        // stands for quality 0.0 indicating lossless compression, other values indicating that there is some lossy compression happening
        final q = match.group(3);
        // indicates the size of the output file so far
        final size = match.group(4);
        // is the time that has elapsed since the beginning of the conversion
        final time = match.group(5);
        // is the current output bitrate
        final bitrate = match.group(6);
        // for instance: 'kbits/s'
        final bitrateUnit = match.group(7);
        // is the speed at which the conversion is happening, relative to real-time
        final speed = match.group(8);

        Logger.info(
            'frame: $frame, fps: $fps, q: $q, size: $size, time: $time, bitrate: $bitrate$bitrateUnit, speed: $speed');
      }
    }
  }

  Future<Uint8List> _createTranscodingVideo(File filePickerResult) async {
    try {
      final reader = html.FileReader();
      reader.readAsArrayBuffer(filePickerResult);
      await reader.onLoadEnd.first;

      Uint8List fileBytes = reader.result as Uint8List;

      /// FFmpeg에 파일 쓰기
      _ffmpeg.writeFile('input.mp4', fileBytes);

      ffmpegStatus.value = '트랜스코딩 시작';

      // 수정된 FFmpeg 명령어: 원본 비율 유지하며 최대 해상도를 1080p로 설정
      await _ffmpeg.run([
        '-i',
        'input.mp4',
        '-vf',
        'scale=1920:1080:force_original_aspect_ratio=decrease',
        '-c:a',
        'copy',
        '1080P_output.mp4'
      ]);

      ffmpegStatus.value = '트랜스코딩 저장 중';
      final hqVideo = _ffmpeg.readFile('1080P_output.mp4');

      ffmpegStatus.value = '트랜스코딩 완료';

      return hqVideo;
    } catch (e) {
      // 에러 처리
      ffmpegStatus.value = '트랜스코딩 중 에러 발생: $e';
      Logger.info('트랜스코딩 중 에러 발생: $e');
      rethrow;
    }
  }

  Future<void> onSave() async {
    isLoading.value = true;

    String? thumbnailUrl;
    String? mediaUrl;

    if (thumbnailFile != null) {
      thumbnailUrl = await UploadRepository().uploadFile(thumbnailFile!);
    }

    if (mediaFile != null) {
      // 트랜스코딩 처리 하기
      await _loadFFmpeg();

      var hqVideo = await _createTranscodingVideo(mediaFile!);

      mediaUrl =
          await UploadRepository().uploadFileBytes(mediaFile!.name, hqVideo);
    }

    BaseModel contentRegisterModel =
        await ContentRegisterRepository().post(ContentRegisterReqPost(
      name: nameController.text,
      category: selectedCategory.value?.keywordName,
      type: selectedType.value?.keywordName,
      level: selectedLevel.value?.keywordName,
      targetLanguage: selectedTargetLanguage.value?.keywordName,
      exposure: selectedExposure.value?.keywordName,
      tags: tags,
      intro: introController.text,
      media: mediaUrl,
      thumbnail: thumbnailUrl,
    ));

    isLoading.value = false;

    if (contentRegisterModel.isSuccess) {
      await showSimpleMessage("저장 되었습니다");

      Get.offAllNamed(AppRoutes.contentManage);
    } else {
      showSimpleMessage("저장에 실패 하였습니다");
    }
  }

  void onPickThumbnail(File? pickedFile) {
    if (pickedFile != null) {
      thumbnailFile = pickedFile;
    }
  }

  void onPickMedia(File? pickedFile) {
    if (pickedFile != null) {
      mediaFile = pickedFile;
    }
  }
}
*/

// content_register_controller.dart
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_repository.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_req_post.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:mindsight_admin_page/utils/ffmpeg_service.dart';
import 'package:mindsight_admin_page/utils/transcoding_uploader.dart';

class ContentRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  final Map<ContentCategory, List<ContentType>> contentType = {
    ContentCategory.body: [
      ContentType.basicBody,
      ContentType.intermediateBody,
      ContentType.advanceBody
    ],
    ContentCategory.breath: [
      ContentType.natureBreathing,
      ContentType.guidedMeditation,
    ],
    ContentCategory.mindfulness: [
      ContentType.mindfulArt,
      ContentType.artWithMusic,
      ContentType.nature,
      ContentType.kAsmr
    ],
    ContentCategory.theory: [
      ContentType.emotionManagement,
      ContentType.philosophy,
      ContentType.selfDevelopment
    ]
  };

  final List<ContentLanguage> contentLanguage = [
    ContentLanguage.english,
    ContentLanguage.korean,
    ContentLanguage.japanese
  ];

  List<ContentType> categoryContentType = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  late final focusNode = FocusNode();

  Rx<ContentCategory?> selectedCategory = Rx<ContentCategory?>(null);
  Rx<ContentType?> selectedType = Rx<ContentType?>(null);

  Rx<ContentLevel?> selectedLevel = Rx<ContentLevel?>(null);
  Rx<ContentLanguage?> selectedTargetLanguage = Rx<ContentLanguage?>(null);
  Rx<ContentExposure?> selectedExposure = Rx<ContentExposure?>(null);
  RxList<String> tags = <String>[].obs;

  RxString thumbnailName = "".obs;
  RxString ccName = "".obs;
  File? thumbnailFile;
  File? mediaFile;

  // RxString ffmpegStatus = "".obs;
  // late FFmpegService _ffmpegService;

  final transcodingUploader = TranscodingUploader();

  @override
  Future<void> onClose() async {
    super.onClose();

    tagController.dispose();
    introController.dispose();
    nameController.dispose();
    // _ffmpegService.dispose();
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    await initData();
    // _ffmpegService = FFmpegService(
    //   onProgress: (ratio) {
    //     ffmpegStatus.value = "트랜스코딩 진행율: ${(ratio * 100).toStringAsFixed(2)}%";
    //     Logger.info("트랜스코딩 진행율: ${(ratio * 100).toStringAsFixed(2)}%");
    //   },
    //   onLog: (log) {
    //     Logger.info(log);
    //   },
    // );
  }

  Future<void> initData() async {
    if (AppConstant.test) {
      await MasterSigninRepository().post(MasterSigninReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    introController.addListener(formatText);

    isInited.value = true;
    isLoading.value = false;
  }

  void selectCategory(ContentCategory? category) {
    selectedCategory.value = category;

    categoryContentType = contentType[category]!;
    selectedType.value = null;
  }

  void addTag(String tag) {
    tags.add(tag);
    tagController.text = "";
  }

  void formatText() {
    String text = introController.text;
    if (text.isEmpty) return;

    List<String> lines = text.split('\n');
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].startsWith('- ')) {
        lines[i] = '\t\t-\t\t';
      }
      if (lines[i].startsWith('* ')) {
        lines[i] = '\t\t•\t\t';
      }
    }
    String formattedText = lines.join('\n');
    if (formattedText != text) {
      introController.value = introController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  void nextList() {
    String text = introController.text;
    if (text.isEmpty) return;

    List<String> lines = text.split('\n');
    if (lines.last.startsWith('\t\t-\t\t')) {
      lines.add('\t\t-\t\t');
    }
    if (lines.last.startsWith('\t\t•\t\t')) {
      lines.add('\t\t•\t\t');
    }
    String formattedText = lines.join('\n');
    if (formattedText != text) {
      introController.value = introController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  bool isSaveValidate() {
    return true;
  }

  // Future<Map<String, List<dynamic>>> _createTranscodingVideo(
  //     File filePickerResult) async {
  //   try {
  //     ffmpegStatus.value = '트랜스코딩 시작';

  //     var hqVideo = await _ffmpegService.transcodeToM3U8(filePickerResult);

  //     ffmpegStatus.value = '트랜스코딩 완료';

  //     return hqVideo;
  //   } catch (e) {
  //     ffmpegStatus.value = '트랜스코딩 중 에러 발생: $e';
  //     Logger.info('트랜스코딩 중 에러 발생: $e');
  //     rethrow;
  //   }
  // }

  Future<void> onSave() async {
    isLoading.value = true;

    String? thumbnailUrl;
    String? mediaUrl;

    if (thumbnailFile != null) {
      thumbnailUrl = (await UploadRepository().uploadFile(thumbnailFile!)).url;
    }

    if (mediaFile != null) {
      mediaUrl = await transcodingUploader.uploadTranscoding(mediaFile!);
    }

    // if (mediaFile != null) {
    //   await _ffmpegService.loadFFmpeg();

    //   var fileInfo = await _createTranscodingVideo(mediaFile!);

    //   var filename = fileInfo["filename"];
    //   var data = fileInfo["data"];

    //   Logger.info("트랜스 코딩 된 파일리스트: $filename");

    //   String folder = '';

    //   for (int i = 0; i < filename!.length; i++) {
    //     ffmpegStatus.value = "업로드 진행율: $i/${filename.length}%";

    //     if (filename[i].contains(".m3u8")) {
    //       UploadModel model = await UploadRepository()
    //           .uploadFileTrascoding(filename[i], data![i], folder);

    //       if (folder.isEmpty) {
    //         mediaUrl = model.url;
    //         folder = model.folder!;
    //       }

    //       // Logger.info(mediaUrl);
    //       // Logger.info(folder);
    //     } else {
    //       await UploadRepository()
    //           .uploadFileTrascoding(filename[i], data![i], folder);
    //     }
    //   }

    //   ffmpegStatus.value = "업로드 진행율: ${filename.length}/${filename.length}%";
    // }

    BaseModel contentRegisterModel =
        await ContentRegisterRepository().post(ContentRegisterReqPost(
      name: nameController.text,
      category: selectedCategory.value?.keywordName,
      type: selectedType.value?.keywordName,
      level: selectedLevel.value?.keywordName,
      targetLanguage: selectedTargetLanguage.value?.keywordName,
      exposure: selectedExposure.value?.keywordName,
      tags: tags,
      intro: introController.text,
      media: mediaUrl,
      thumbnail: thumbnailUrl,
    ));

    isLoading.value = false;

    if (contentRegisterModel.isSuccess) {
      await showSimpleMessage("저장 되었습니다");

      Get.offAllNamed(AppRoutes.contentManage);
    } else {
      showSimpleMessage(
          "저장에 실패 하였습니다. ${contentRegisterModel.getErrorMessage().tr}");
    }
  }

  void onPickThumbnail(File? pickedFile) {
    if (pickedFile != null) {
      thumbnailFile = pickedFile;
    }
  }

  void onPickMedia(File? pickedFile) {
    if (pickedFile != null) {
      mediaFile = pickedFile;
    }
  }
}

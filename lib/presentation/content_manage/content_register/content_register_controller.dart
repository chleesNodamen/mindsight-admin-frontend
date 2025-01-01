// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_repository.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_req_post.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
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

  Rx<ContentCategory?> selectedCategory =
      Rx<ContentCategory?>(ContentCategory.body);
  Rx<ContentType?> selectedType = Rx<ContentType?>(ContentType.basicBody);

  Rx<ContentLevel?> selectedLevel = Rx<ContentLevel?>(ContentLevel.all);
  Rx<ContentLanguage?> selectedTargetLanguage =
      Rx<ContentLanguage?>(ContentLanguage.korean);
  Rx<ContentExposure?> selectedExposure =
      Rx<ContentExposure?>(ContentExposure.nonExposed);
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

    categoryContentType = contentType[ContentCategory.body]!;

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
    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    introController.addListener(formatText);

    isInited.value = true;
    isLoading.value = false;
  }

  void selectCategory(ContentCategory? category) {
    selectedCategory.value = category;

    categoryContentType = contentType[category]!;
    selectedType.value = categoryContentType[0];
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
      await showSimpleMessage("저장 되었습니다".tr);

      Get.offAllNamed(AppRoutes.contentManage);
    } else {
      showSimpleMessage(
          "${"저장에 실패 하였습니다.".tr} ${contentRegisterModel.getErrorMessage().tr}");
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

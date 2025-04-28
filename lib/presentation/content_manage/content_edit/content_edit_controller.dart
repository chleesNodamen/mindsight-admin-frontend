import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_model.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_repository.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_repository.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_req_put.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as p;

class ContentEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  // final String id = "UGl7aJVSYCDtjlHfxgYC0A%253D%253D";

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late Rx<ContentDetailsModel> contentDetailsModel;

  final List<ContentLanguage> contentLanguage = [
    ContentLanguage.english,
    ContentLanguage.korean
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  late final focusNode = FocusNode();

  File? thumbnailFile;
  File? mediaFile;

  Rx<Map<String, String>?> selectedMaster = Rx<Map<String, String>?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();

    contentDetailsModel = (await ContentDetailsRepository().get(id)).obs;

    introController.addListener(formatText);

    nameController.text = contentDetailsModel.value.name ?? '';
    introController.text = contentDetailsModel.value.intro ?? '';

    isLoading.value = false;
    isInited.value = true;
  }

  void addTag(String tag) {
    isLoading.value = true;
    contentDetailsModel.update((model) {
      model?.tags?.add(tag);
    });
    tagController.text = "";
    isLoading.value = false;
  }

  void formatText() {
    String text = introController.text;
    if (text.isEmpty) return;

    List<String> lines = text.split('\n');
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].startsWith('- ')) lines[i] = '\t\t-\t\t';
      if (lines[i].startsWith('* ')) lines[i] = '\t\t•\t\t';
    }
    String formattedText = lines.join('\n');
    if (formattedText != text) {
      introController.value = introController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  Future<int?> getDurationTime(File file) async {
    final extension = p.extension(file.name).toLowerCase();

    // ✅ 파일 자체를 URL로 만든다
    final url = Url.createObjectUrl(file);

    if (['.mp4', '.mov', '.mkv', '.avi', '.webm'].contains(extension)) {
      // ✅ 비디오 파일 처리
      final controller = VideoPlayerController.network(url);

      try {
        await controller.initialize();
        final duration = controller.value.duration.inSeconds;
        controller.dispose();
        Url.revokeObjectUrl(url); // URL 해제
        return duration;
      } catch (e) {
        controller.dispose();
        Url.revokeObjectUrl(url);
        return null;
      }
    } else if (['.mp3', '.aac', '.wav', '.flac', '.ogg', '.m4a']
        .contains(extension)) {
      // ✅ 오디오 파일 처리
      final audio = AudioElement()
        ..src = url
        ..preload = 'metadata';

      try {
        await audio.onLoadedMetadata.first;
        final duration = audio.duration?.round();
        Url.revokeObjectUrl(url); // URL 해제
        return duration;
      } catch (e) {
        Url.revokeObjectUrl(url);
        return null;
      }
    } else {
      Url.revokeObjectUrl(url);
      return null;
    }
  }

  Future<void> onSave() async {
    String mediaBlobName = "";

    if (mediaFile != null) {
      String? extension =
          mediaFile != null ? p.extension(mediaFile!.name).toLowerCase() : null;
      if (extension == null || extension.isEmpty) {
        showSimpleMessage("error file extension".tr);
        return;
      }

      // ✅ 오디오/비디오 확장자 목록
      const videoExtensions = ['.mp4', '.mov', '.mkv', '.avi', '.webm'];
      const audioExtensions = ['.mp3', '.aac', '.wav', '.flac', '.ogg', '.m4a'];

      // ✅ 어떤 타입인지 확인
      bool isVideo = videoExtensions.contains(extension);
      bool isAudio = audioExtensions.contains(extension);

      if (!isVideo && !isAudio) {
        showSimpleMessage("unsupported file type".tr);
        return;
      }

      String videoFolder = BlobNameGenerator.generateBlobFolderName();
      String mediaUrl = "$videoFolder/master.m3u8";
      mediaBlobName = "$videoFolder$extension";

      if (isAudio) {
        mediaBlobName =
            mediaUrl = BlobNameGenerator.generateBlobName(mediaFile!);
      }
      contentDetailsModel.value.durationTime =
          await getDurationTime(mediaFile!);
      contentDetailsModel.value.video = mediaUrl;
    }

    if (thumbnailFile != null) {
      contentDetailsModel.value.thumbnail =
          BlobNameGenerator.generateBlobName(thumbnailFile!);
    }

    BaseModel contentEditModel = await ContentEditRepository().put(
        id,
        ContentEditReqPut(
            name: nameController.text,
            category: contentDetailsModel.value.category,
            level: contentDetailsModel.value.level,
            targetLanguage: contentDetailsModel.value.targetLanguage,
            exposure: contentDetailsModel.value.exposure,
            tags: contentDetailsModel.value.tags,
            intro: introController.text,
            status: contentDetailsModel.value.status,
            thumbnail: contentDetailsModel.value.thumbnail,
            video: contentDetailsModel.value.video,
            durationTime: contentDetailsModel.value.durationTime ?? 0,
            masterId: selectedMaster.value != null
                ? selectedMaster.value!["id"]
                : null));

    isLoading.value = false;

    if (contentEditModel.isSuccess) {
      isLoading.value = true;

      if (thumbnailFile != null) {
        await UploadRepository().uploadFile(thumbnailFile!,
            blobName: contentDetailsModel.value.thumbnail);
      }

      if (mediaFile != null) {
        await UploadRepository().uploadVideoFile(
          mediaFile!,
          blobName: mediaBlobName,
        );
      }

      isLoading.value = false;

      await showSimpleMessage("Saved successfully".tr);

      Get.offAllNamed(AppRoutes.contentDetails,
          arguments: {RouteArguments.id: id});
    } else {
      showSimpleMessage(
          "${"Save failed".tr} ${contentEditModel.getErrorMessage().tr}");
    }
  }
/*
  Future<void> onSave() async {
    
    String folder = BlobNameGenerator.generateBlobFolderName();

    if (mediaFile != null) {
      if (!transcodingUploader.isTranscodingCompleted) {
        showSimpleMessage(
            "Transcoding is still in progress. Please wait until it completes before saving."
                .tr);
        return;
      }
      contentDetailsModel.video = "$folder/1080p.m3u8";
      contentDetailsModel.durationTime = transcodingUploader.durationTime;
    }

    isLoading.value = true;

    if (thumbnailFile != null) {
      contentDetailsModel.thumbnail =
          BlobNameGenerator.generateBlobName(thumbnailFile!);
    }

    BaseModel contentEditModel = await ContentEditRepository().put(
        id,
        ContentEditReqPut(
            name: nameController.text,
            category: contentDetailsModel.category,
            level: contentDetailsModel.level,
            targetLanguage: contentDetailsModel.targetLanguage,
            status: contentDetailsModel.status,
            exposure: contentDetailsModel.exposure,
            tags: contentDetailsModel.tags!,
            intro: introController.text,
            thumbnail: contentDetailsModel.thumbnail,
            video: contentDetailsModel.video,
            cc: contentDetailsModel.cc,
            durationTime: contentDetailsModel.durationTime ?? 100));

    isLoading.value = false;

    if (contentEditModel.isSuccess) {
      if (thumbnailFile != null) {
        await UploadRepository().uploadFile(thumbnailFile!,
            blobName: contentDetailsModel.thumbnail);
      }

      await transcodingUploader.upload(folder);

      Get.offAllNamed(AppRoutes.contentDetails,
          arguments: {RouteArguments.id: id});
    } else {
      showSimpleMessage("수정에 실패 하였습니다");
    }
  }
  */

  void onPickThumbnail(File? pickedFile) {
    if (pickedFile != null) {
      thumbnailFile = pickedFile;
      contentDetailsModel.update((model) {
        model?.thumbnail = pickedFile.name;
      });
    }
  }

  void onPickMedia(File? pickedFile) {
    if (contentDetailsModel.value.isTranscodingCompleted == false) {
      showSimpleMessage(
          "The media file is currently being transcoded and cannot be modified."
              .tr);
      return;
    }
    if (pickedFile != null) {
      mediaFile = pickedFile;
      contentDetailsModel.update((model) {
        model?.video = pickedFile.name;
      });
    }
  }

  void onChangeStatus(ContentStatus? newValue) {
    if (Account.isAdminWithMsg) {
      isLoading.value = true;
      contentDetailsModel.update((model) {
        model?.status = newValue?.keywordName;
      });
      isLoading.value = false;
    }
  }

  void onExposureChange(ContentExposure? newValue) {
    isLoading.value = true;
    contentDetailsModel.update((model) {
      model?.exposure = newValue?.keywordName;
    });
    isLoading.value = false;
  }
}

/*
import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_model.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_repository.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_repository.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_req_put.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:mindsight_admin_page/utils/transcoding_uploader_nouse.dart';

class ContentEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late ContentDetailsModel contentDetailsModel;

  final List<ContentLanguage> contentLanguage = [
    ContentLanguage.english,
    ContentLanguage.korean
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  final TextEditingController mediaController = TextEditingController();
  late final focusNode = FocusNode();

  File? thumbnailFile;
  File? ccFile;
  File? mediaFile;

  Rx<Map<String, String>?> selectedMaster = Rx<Map<String, String>?>(null);

  @override
  Future<void> onClose() async {
    nameController.dispose();
    tagController.dispose();
    introController.dispose();
    mediaController.dispose();
    // await transcodingUploader.dispose();
    super.onClose();
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    contentDetailsModel = (await ContentDetailsRepository().get(id));

    introController.addListener(formatText);

    nameController.text = contentDetailsModel.name!;
    introController.text = contentDetailsModel.intro!;

    // tags.value = contentDetailsModel.tags!;

    mediaController.text = contentDetailsModel.video!;

    isLoading.value = false;
    isInited.value = true;
  }

  void addTag(String tag) {
    isLoading.value = true;
    contentDetailsModel.tags!.add(tag);
    tagController.text = "";

    isLoading.value = false;
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

  void onPickThumbnail(File? pickedFile) {
    if (pickedFile != null) {
      thumbnailFile = pickedFile;
      contentDetailsModel.thumbnail = pickedFile.name;
    }
  }

  void onPickCC(File? pickedFile) {
    if (pickedFile != null) {
      ccFile = pickedFile;
      contentDetailsModel.cc = pickedFile.name;
    }
  }

  void onPickMedia(File? pickedFile) {
    if (pickedFile != null) {
      mediaFile = pickedFile;
      contentDetailsModel.video = pickedFile.name;

      // transcodingUploader.transcoding(mediaFile!);
    }
  }

  // Future<List<List<double>>> computeAndLogEmbedding() async {
  //   final embeddingHelper = TextEmbedding();

  //   final weightedTexts = [
  //     {"text": nameController.text, "weight": 1}, // 제목에 가중치 1
  //     {"text": introController.text, "weight": 1}, // 설명에 가중치 1
  //     {"text": contentDetailsModel.category ?? '', "weight": 1}, // 카테고리에 가중치 1
  //   ];

  //   final embedding =
  //       await embeddingHelper.computeWeightedEmbeddingAverage(weightedTexts);
  //   Logger.log("가중 평균 적용 후 임베딩 벡터: $embedding");

  //   return embedding;
  // }

  Future<void> onSave() async {
    /*
    String folder = BlobNameGenerator.generateBlobFolderName();

    if (mediaFile != null) {
      if (!transcodingUploader.isTranscodingCompleted) {
        showSimpleMessage(
            "Transcoding is still in progress. Please wait until it completes before saving."
                .tr);
        return;
      }
      contentDetailsModel.video = "$folder/1080p.m3u8";
      contentDetailsModel.durationTime = transcodingUploader.durationTime;
    }

    isLoading.value = true;

    if (thumbnailFile != null) {
      contentDetailsModel.thumbnail =
          BlobNameGenerator.generateBlobName(thumbnailFile!);
    }

    BaseModel contentEditModel = await ContentEditRepository().put(
        id,
        ContentEditReqPut(
            name: nameController.text,
            category: contentDetailsModel.category,
            level: contentDetailsModel.level,
            targetLanguage: contentDetailsModel.targetLanguage,
            status: contentDetailsModel.status,
            exposure: contentDetailsModel.exposure,
            tags: contentDetailsModel.tags!,
            intro: introController.text,
            thumbnail: contentDetailsModel.thumbnail,
            video: contentDetailsModel.video,
            cc: contentDetailsModel.cc,
            durationTime: contentDetailsModel.durationTime ?? 100));

    isLoading.value = false;

    if (contentEditModel.isSuccess) {
      if (thumbnailFile != null) {
        await UploadRepository().uploadFile(thumbnailFile!,
            blobName: contentDetailsModel.thumbnail);
      }

      await transcodingUploader.upload(folder);

      Get.offAllNamed(AppRoutes.contentDetails,
          arguments: {RouteArguments.id: id});
    } else {
      showSimpleMessage("수정에 실패 하였습니다");
    }
    */
  }

  void onChangeStatus(ContentStatus? newValue) {
    if (Account.isAdminWithMsg) {
      isLoading.value = true;
      contentDetailsModel.status = newValue?.keywordName;
      isLoading.value = false;
    }
  }

  void onExposureChange(ContentExposure? newValue) {
    isLoading.value = true;
    contentDetailsModel.exposure = newValue?.keywordName;
    isLoading.value = false;
  }
}
*/

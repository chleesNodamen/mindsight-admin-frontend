import 'dart:async';
import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_repository.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_req_post.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:path/path.dart' as p;
import 'package:video_player/video_player.dart';

class ContentRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  final List<ContentLanguage> contentLanguage = [
    ContentLanguage.english,
    ContentLanguage.korean
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  late final focusNode = FocusNode();

  final Rx<ContentCategory?> selectedCategory = Rx<ContentCategory?>(null);

  Rx<ContentLevel?> selectedLevel = Rx<ContentLevel?>(ContentLevel.all);
  Rx<ContentLanguage?> selectedTargetLanguage =
      Rx<ContentLanguage?>(ContentLanguage.english);
  Rx<ContentExposure?> selectedExposure =
      Rx<ContentExposure?>(ContentExposure.exposed);
  RxList<String> tags = <String>[].obs;

  Rx<File?> mediaFile = Rx<File?>(null);
  Rx<File?> thumbnailFile = Rx<File?>(null);

  @override
  Future<void> onClose() async {
    tagController.dispose();
    introController.dispose();
    nameController.dispose();

    // await transcodingUploader.dispose();

    super.onClose();
  }

  @override
  Future<void> onInit() async {
    await initData();

    super.onInit();
  }

  Future<void> initData() async {
    introController.addListener(formatText);

    isInited.value = true;
    isLoading.value = false;
  }

  void selectCategory(ContentCategory? category) {
    selectedCategory.value = category;
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

  Future<void> onSave() async {
    if (mediaFile.value == null) {
      showSimpleMessage("No media file selected.".tr); // ✅ No media file
      return;
    }

    if (thumbnailFile.value == null) {
      showSimpleMessage(
          "No thumbnail file selected.".tr); // ✅ No thumbnail file
      return;
    }
    // ✅ mediaFile에서 확장자 추출
    String? extension = mediaFile.value != null
        ? p.extension(mediaFile.value!.name).toLowerCase()
        : null;
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

    // isLoading.value = true;

    String thumbnailUrl =
        BlobNameGenerator.generateBlobName(thumbnailFile.value!);

    String videoFolder = BlobNameGenerator.generateBlobFolderName();
    String mediaUrl = "$videoFolder/master.m3u8";
    String mediaBlobName = "$videoFolder$extension";

    if (isAudio) {
      mediaBlobName =
          mediaUrl = BlobNameGenerator.generateBlobName(mediaFile.value!);
    }

    int? durationTime = await getDurationTime(mediaFile.value!);

    BaseModel contentRegisterModel =
        await ContentRegisterRepository().post(ContentRegisterReqPost(
      name: nameController.text,
      category: selectedCategory.value?.keywordName,
      level: selectedLevel.value?.keywordName,
      targetLanguage: selectedTargetLanguage.value?.keywordName,
      exposure: selectedExposure.value?.keywordName,
      tags: tags,
      intro: introController.text,
      media: mediaUrl,
      thumbnail: thumbnailUrl,
      durationTime: durationTime,
    ));

    isLoading.value = false;

    if (contentRegisterModel.isSuccess) {
      isLoading.value = true;

      await UploadRepository()
          .uploadFile(thumbnailFile.value!, blobName: thumbnailUrl);

      await UploadRepository().uploadVideoFile(
        mediaFile.value!,
        blobName: mediaBlobName,
      );

      isLoading.value = false;

      await showSimpleMessage("Saved successfully".tr);

      Get.offAllNamed(AppRoutes.contentManage);
    } else {
      showSimpleMessage(
          "${"Save failed".tr} ${contentRegisterModel.getErrorMessage().tr}");
    }
  }

  // Future<int?> getDurationTime(File file) async {
  //   // 여기에 실제 미디어 duration 읽어오는 로직 추가해야 함
  //   // 예: video_player 패키지나, 미디어 분석 패키지로
  //   return 60; // 일단 null 반환
  // }

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

  void onPickThumbnail(File? pickedFile) {
    if (pickedFile != null) {
      thumbnailFile.value = pickedFile;
    }
  }

  Future<void> onPickVideo(File? pickedFile) async {
    if (pickedFile != null) {
      mediaFile.value = pickedFile;
    }
  }
}

import 'dart:async';
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

  final List<ContentLanguage> contentLanguage = [
    ContentLanguage.english,
    ContentLanguage.korean,
    ContentLanguage.japanese
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  late final focusNode = FocusNode();

  Rx<ContentCategory?> selectedCategory =
      Rx<ContentCategory?>(ContentCategory.body);

  Rx<ContentLevel?> selectedLevel = Rx<ContentLevel?>(ContentLevel.all);
  Rx<ContentLanguage?> selectedTargetLanguage =
      Rx<ContentLanguage?>(ContentLanguage.english);
  Rx<ContentExposure?> selectedExposure =
      Rx<ContentExposure?>(ContentExposure.nonExposed);
  RxList<String> tags = <String>[].obs;

  File? thumbnailFile;
  File? ccFile;
  File? mediaFile;

  final transcodingUploader = TranscodingUploader();

  @override
  Future<void> onClose() async {
    tagController.dispose();
    introController.dispose();
    nameController.dispose();

    await transcodingUploader.dispose();

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
    if (!transcodingUploader.isTranscodingComplete) {
      showSimpleMessage(
          "Transcoding is still in progress. Please wait until it completes before saving."
              .tr);
      return;
    }
    isLoading.value = true;

    String? thumbnailUrl;
    String folder = BlobNameGenerator.generateFolderName();
    String? mediaUrl = "$folder/1080p.m3u8";

    if (thumbnailFile != null) {
      thumbnailUrl = BlobNameGenerator.generateBlobName(thumbnailFile!);
    }

    BaseModel contentRegisterModel = await ContentRegisterRepository().post(
        ContentRegisterReqPost(
            name: nameController.text,
            category: selectedCategory.value?.keywordName,
            level: selectedLevel.value?.keywordName,
            targetLanguage: selectedTargetLanguage.value?.keywordName,
            exposure: selectedExposure.value?.keywordName,
            tags: tags,
            intro: introController.text,
            media: mediaUrl,
            thumbnail: thumbnailUrl,
            durationTime: transcodingUploader.durationTime));

    isLoading.value = false;

    if (contentRegisterModel.isSuccess) {
      if (thumbnailFile != null) {
        await UploadRepository()
            .uploadFile(thumbnailFile!, blobName: thumbnailUrl);
      }

      await transcodingUploader.upload(folder);

      await showSimpleMessage("Saved successfully".tr);

      Get.offAllNamed(AppRoutes.contentManage);
    } else {
      showSimpleMessage(
          "${"Save failed".tr} ${contentRegisterModel.getErrorMessage().tr}");
    }
  }

  void onPickThumbnail(File? pickedFile) {
    if (pickedFile != null) {
      thumbnailFile = pickedFile;
    }
  }

  Future<void> onPickMedia(File? pickedFile) async {
    if (pickedFile != null) {
      mediaFile = pickedFile;

      transcodingUploader.transcoding(mediaFile!);
    }
  }
}

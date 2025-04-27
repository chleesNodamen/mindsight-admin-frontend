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

  // final transcodingUploader = TranscodingUploader();

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
      if (!transcodingUploader.isTranscodingComplete) {
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

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_model.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_repository.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_repository.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_req_put.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:mindsight_admin_page/utils/transcoding_uploader.dart';

class ContentEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late Rx<ContentDetailsModel> contentDetailsModel;

  final Map<ContentCategory, List<ContentType>> types = {
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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  final TextEditingController mediaController = TextEditingController();
  late final focusNode = FocusNode();

  File? thumbnailFile;
  File? mediaFile;

  final transcodingUploader = TranscodingUploader();

  @override
  Future<void> onInit() async {
    super.onInit();

    contentDetailsModel = (await ContentDetailsRepository().get(id)).obs;

    introController.addListener(formatText);

    nameController.text = contentDetailsModel.value.name!;
    introController.text = contentDetailsModel.value.intro!;

    // tags.value = contentDetailsModel.value.tags!;

    mediaController.text = contentDetailsModel.value.video!;

    isLoading.value = false;
    isInited.value = true;
  }

  void addTag(String tag) {
    contentDetailsModel.value.tags!.add(tag);
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

  bool isSaveOk() {
    return true;
  }

  void onPickThumbnail(File? pickedFile) {
    if (pickedFile != null) {
      thumbnailFile = pickedFile;
      contentDetailsModel.value.thumbnail = pickedFile.name;
    }
  }

  void onPickMedia(File? pickedFile) {
    if (pickedFile != null) {
      mediaFile = pickedFile;
      contentDetailsModel.value.video = pickedFile.name;
    }
  }

  Future<void> onSave() async {
    isLoading.value = true;

    if (thumbnailFile != null) {
      contentDetailsModel.value.thumbnail =
          (await UploadRepository().uploadFile(thumbnailFile!)).url;
    }

    if (mediaFile != null) {
      contentDetailsModel.value.video =
          await transcodingUploader.uploadTranscoding(mediaFile!);
    }

    BaseModel contentEditModel = await ContentEditRepository().put(
      id,
      ContentEditReqPut(
        name: nameController.text,
        category: contentDetailsModel.value.category,
        type: contentDetailsModel.value.type,
        level: contentDetailsModel.value.level,
        targetLanguage: contentDetailsModel.value.targetLanguage,
        status: contentDetailsModel.value.status,
        exposure: contentDetailsModel.value.exposure,
        tags: contentDetailsModel.value.tags!,
        intro: introController.text,
        thumbnail: contentDetailsModel.value.thumbnail,
        video: contentDetailsModel.value.video,
        cc: contentDetailsModel.value.cc,
      ),
    );

    isLoading.value = false;

    if (contentEditModel.isSuccess) {
      await showSimpleMessage("수정 되었습니다");

      Get.offAllNamed(AppRoutes.contentDetails,
          arguments: {RouteArguments.id: id});
    } else {
      showSimpleMessage("수정에 실패 하였습니다");
    }
  }

  void onChangeStatus(ContentStatus? newValue) {
    if (Account.isAdminWithMsg) {
      isLoading.value = true;
      contentDetailsModel.value.status = newValue?.keywordName;
      isLoading.value = false;
    }
  }

  void onExposureChange(ContentExposure? newValue) {
    isLoading.value = true;
    contentDetailsModel.value.exposure = newValue?.keywordName;
    isLoading.value = false;
  }
}

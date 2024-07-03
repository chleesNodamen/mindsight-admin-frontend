import 'dart:html';
import 'package:mindsight_admin_page/data/upload/upload_request.dart';
import 'package:video_player/video_player.dart';

import 'package:file_picker/file_picker.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_model.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_repository.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_model.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_repository.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_req_put.dart';

class ContentEditController extends GetxController {
  // final id = Get.arguments[RouteArguments.id];
  final id = "";

  final List<String> categories = ["Body", "Breath", "Mindfulness"];

  final Map<String, List<String>> types = {
    "Body": ["Basic body", "Intermediate body", "Advance body"],
    "Breath": [
      'Relaxing breath',
      'Focus breath',
      'Energy breathing',
      'Nature breathing',
      'Guided meditation'
    ],
    'Mindfulness': ['Mindful art', 'Art with music', 'Nature', 'K-ASMR']
  };

  final TextEditingController tagController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController videoController = TextEditingController();
  final TextEditingController thumbnailController = TextEditingController();
  final TextEditingController ccController = TextEditingController();
  VideoPlayerController? videoPlayerController;
  late final focusNode = FocusNode();

  RxString selectedCategory = "".obs;
  RxBool categorySelected = false.obs;
  RxString selectedType = "".obs;
  RxList<String> tags = <String>[].obs;
  RxString selectedMaster = "".obs;

  RxBool enableCategoryError = false.obs;
  RxBool enableTypeError = false.obs;
  RxBool enableThumbnailError = false.obs;

  File? ccFile;
  File? thumbnailFile;
  String? ccUrl;
  String? thumbnailUrl;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late ContentDetailsModel contentDetailsModel;
  late ContentEditModel contentEditModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (AppConstant.chleesTest) {
      contentDetailsModel = await ContentDetailsRepository().get(id);
    } else {
      contentDetailsModel = ContentDetailsModel().copyWith(
        id: id,
        category: "Body",
        type: "Basic body",
        master: "Mindsight master",
        tags: ["sleep", "good night", "bed", "calm", "relax"],
        intro:
            "This exercise strengthen the lower body and straigthen the spine. The mountain pose and lunge pose help strengthen the lower body and relieve stress. Back rolls aid in stimulating the spine and improving internal function.",
        thumbnail: "https://nodamen.akamaized.net/Mi...",
        video: "https://nodamen.akamaized.net/Mi...",
        cc: "https://nodamen.akamaized.net/Mi...",
        name: "Spine & Lower Body",
        seen: 99999,
        liked: 4221,
        durationTime: 10,
      );
    }
    introController.addListener(formatText);
    if (contentDetailsModel.intro != null) {
      introController.text = contentDetailsModel.intro!;
    } else {
      introController.text = "";
    }
    if (contentDetailsModel.name != null) {
      titleController.text = contentDetailsModel.name!;
    } else {
      titleController.text = "";
    }
    if (contentDetailsModel.category != null) {
      selectedCategory.value = contentDetailsModel.category!;
      categorySelected.value = true;
    }
    if (contentDetailsModel.type != null) {
      selectedType.value = contentDetailsModel.type!;
    }
    if (contentDetailsModel.master != null) {
      selectedMaster.value = contentDetailsModel.master!;
    }
    if (contentDetailsModel.tags != null) {
      tags.value = contentDetailsModel.tags!;
    }
    if (contentDetailsModel.video != null) {
      videoController.text = contentDetailsModel.video!;
    } else {
      videoController.text = "";
    }
    if (contentDetailsModel.thumbnail != null) {
      thumbnailController.text = contentDetailsModel.thumbnail!;
    } else {
      thumbnailController.text = "";
    }
    if (contentDetailsModel.cc != null) {
      ccController.text = contentDetailsModel.cc!;
    } else {
      ccController.text = "";
    }
    isLoading.value = false;
    isInited.value = true;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    categorySelected.value = true;
    selectedType.value = "";
    enableCategoryError.value = false;
  }

  void addTag(String tag) {
    tags.add(tag.toLowerCase().replaceAll(' ', ''));
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
    if (selectedCategory.value == "") {
      enableCategoryError.value = true;
    } else {
      enableCategoryError.value = false;
    }
    if (selectedType.value == "") {
      enableTypeError.value = true;
    } else {
      enableTypeError.value = false;
    }
    if (thumbnailFile == null && thumbnailController.text == "") {
      enableThumbnailError.value = true;
    } else {
      enableThumbnailError.value = false;
    }
    if (enableCategoryError.value ||
        enableTypeError.value ||
        enableThumbnailError.value) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> onSave() async {
    if (ccFile != null) {
      ccUrl =
          await UploadRepository().uploadFile(ccFile!, "mindsight.im/upload");
    }
    if (thumbnailFile != null) {
      thumbnailUrl = await UploadRepository()
          .uploadFile(thumbnailFile!, "mindsight.im/upload");
    }
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoController.text));
    await videoPlayerController?.initialize();
    int? duration = videoPlayerController?.value.duration.inMinutes;
    contentEditModel = await ContentEditRepository().put(
        id,
        ContentEditReqPut(
          category: selectedCategory.value,
          type: selectedType.value,
          master: selectedMaster.value,
          tags: tags,
          intro: introController.text,
          thumbnail: thumbnailUrl ?? thumbnailController.text,
          video: videoController.text,
          cc: ccUrl ?? ccController.text,
          name: titleController.text,
          durationTime: duration ?? 0,
        ).toJson());

    if (contentEditModel.isSuccess) {
      Get.toNamed(AppRoutes.contentDetails, arguments: {RouteArguments.id: id});
    }
  }

  void pickFile(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      if (type == "cc") {
        ccController.text = file.name;
        ccFile = File([file.bytes!], file.name);
      } else {
        thumbnailController.text = file.name;
        thumbnailFile = File([file.bytes!], file.name);
      }
    } else {
      return;
    }
  }
}

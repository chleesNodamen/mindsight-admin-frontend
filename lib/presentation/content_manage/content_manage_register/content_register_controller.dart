import 'dart:html';
import 'package:mindsight_admin_page/data/content_master/master_model.dart';
import 'package:mindsight_admin_page/data/content_master/master_repository.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_model.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_repository.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_req_post.dart';
import 'package:mindsight_admin_page/data/upload/upload_request.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mindsight_admin_page/app_export.dart';

class ContentRegisterController extends GetxController {
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
  VideoPlayerController? videoPlayerController;
  late final focusNode = FocusNode();

  RxString selectedCategory = "".obs;
  RxBool categorySelected = false.obs;
  RxString selectedType = "".obs;
  RxList<String> tags = <String>[].obs;
  RxString selectedMaster = "".obs;
  List<String> masters = <String>[];
  RxString thumbnailName = "".obs;
  RxString ccName = "".obs;

  RxBool enableCategoryError = false.obs;
  RxBool enableTypeError = false.obs;
  RxBool enableThumbnailError = false.obs;

  File? ccFile;
  File? thumbnailFile;
  String? ccUrl;
  String? thumbnailUrl;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late MasterModel masterModel;
  late ContentRegisterModel contentRegisterModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (AppConstant.chleesTest) {
      masterModel = await MasterRepository().get();
    } else {
      masterModel =
          MasterModel().copyWith(id: [""], name: ["Mindsight master"]);
    }
    introController.addListener(formatText);
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
    if (thumbnailFile == null && thumbnailName.value == "") {
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
    contentRegisterModel =
        await ContentRegisterRepository().post(ContentRegisterReqPost(
      category: selectedCategory.value,
      type: selectedType.value,
      master: selectedMaster.value,
      tags: tags,
      intro: introController.text,
      thumbnail: thumbnailUrl,
      video: videoController.text,
      cc: ccUrl,
      name: titleController.text,
      durationTime: duration ?? 0,
    ).toJson());

    if (contentRegisterModel.isSuccess) {
      Get.toNamed(AppRoutes.contentManage);
    }
  }

  void pickFile(String type) async {
    List<String> extensions;
    if (type == "cc") {
      extensions = ['srt'];
    } else {
      extensions = ['jpg'];
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      if (type == "cc") {
        ccName.value = file.name;
        ccFile = File([file.bytes!], file.name);
      } else {
        thumbnailName.value = file.name;
        thumbnailFile = File([file.bytes!], file.name);
      }
    } else {
      return;
    }
  }
}

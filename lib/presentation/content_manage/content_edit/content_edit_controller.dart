// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:mindsight_admin_page/data/content_master/master_model.dart';
import 'package:mindsight_admin_page/data/content_master/master_repository.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_details/content_details_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_model.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_repository.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_model.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_repository.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_req_put.dart';

class ContentEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  final List<Category> categories = [
    Category.body,
    Category.breath,
    Category.mindfulness,
    Category.theory,
  ];

  final Map<Category, List<String>> types = {
    Category.body: ["Basic body", "Intermediate body", "Advance body"],
    Category.breath: [
      'Relaxing breath',
      'Focus breath',
      'Energy breathing',
      'Nature breathing',
      'Guided meditation'
    ],
    Category.mindfulness: ['Mindful art', 'Art with music', 'Nature', 'K-ASMR'],
    Category.theory: ['Theory-0', 'Theory-1', 'Theory-2', 'Theory-3']
  };

  final TextEditingController tagController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController videoController = TextEditingController();
  late final focusNode = FocusNode();

  Rx<Category?> selectedCategory = Rx<Category?>(null);
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

  late ContentDetailsModel contentDetailsModel;
  late ContentEditModel contentEditModel;
  late MasterModel masterModel;

  @override
  Future<void> onInit() async {
    super.onInit();

    masterModel = await MasterRepository().get();
    contentDetailsModel = await ContentDetailsRepository().get(id);

    // if (AppConstant.test) {
    //   masterModel = await MasterRepository().get();
    //   contentDetailsModel = await ContentDetailsRepository().get(id);
    // } else {
    //   masterModel =
    //       MasterModel().copyWith(id: [""], name: ["Mindsight master"]);
    //   contentDetailsModel = ContentDetailsModel().copyWith(
    //     id: id,
    //     category: "Body",
    //     type: "Basic body",
    //     master: "Mindsight master",
    //     tags: ["sleep", "good night", "bed", "calm", "relax"],
    //     intro:
    //         "This exercise strengthen the lower body and straigthen the spine. The mountain pose and lunge pose help strengthen the lower body and relieve stress. Back rolls aid in stimulating the spine and improving internal function.",
    //     thumbnail: "https://nodamen.akamaized.net/Mi...",
    //     video: "https://nodamen.akamaized.net/Mi...",
    //     cc: "https://nodamen.akamaized.net/Mi...",
    //     name: "Spine & Lower Body",
    //     seen: 99999,
    //     liked: 4221,
    //     durationTime: 10,
    //   );
    // }

    introController.addListener(formatText);

    if (masterModel.name != null) {
      masters = masterModel.name!;
    }
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
      selectedCategory.value =
          Category.fromKeyword(contentDetailsModel.category!);
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
      thumbnailName.value = contentDetailsModel.thumbnail!;
    }
    if (contentDetailsModel.cc != null) {
      ccName.value = contentDetailsModel.cc!;
    }
    isLoading.value = false;
    isInited.value = true;
  }

  void selectCategory(Category category) {
    selectedCategory.value = category;
    categorySelected.value = true;
    selectedType.value = "";
    enableCategoryError.value = false;
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
    isLoading.value = true;

    if (ccFile != null) {
      ccUrl = await UploadRepository().uploadFile(ccFile!);
    }
    if (thumbnailFile != null) {
      thumbnailUrl = await UploadRepository().uploadFile(thumbnailFile!);
    }
    contentEditModel = await ContentEditRepository().put(
      id,
      ContentEditReqPut(
        category: selectedCategory.value?.toKeywordName(),
        type: selectedType.value,
        master: selectedMaster.value,
        tags: tags,
        intro: introController.text,
        thumbnail: thumbnailUrl ?? thumbnailName.value,
        video: videoController.text,
        cc: ccUrl ?? ccName.value,
        name: titleController.text,
      ),
    );

    if (contentEditModel.isSuccess) {
      if (Get.isRegistered<ContentDetailsController>()) {
        Get.delete<ContentDetailsController>();
      }
      Get.offAllNamed(AppRoutes.contentDetails,
          arguments: {RouteArguments.id: id});
    }

    isLoading.value = false;
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

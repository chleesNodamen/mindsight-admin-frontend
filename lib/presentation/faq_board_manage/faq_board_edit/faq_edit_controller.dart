// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/faq_board_detail/faq_board_model.dart';
import 'package:mindsight_admin_page/data/faq_board_detail/faq_board_repository.dart';
import 'package:mindsight_admin_page/data/faq_board_edit/faq_board_edit_repository.dart';
import 'package:mindsight_admin_page/data/faq_board_edit/faq_board_edit_req_put.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';

class FAQBoardEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late FAQBoardDetailModel faqBoardDetailModel;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  late final focusNode = FocusNode();

  File? attachedFile;

  @override
  Future<void> onInit() async {
    await initData();

    super.onInit();
  }

  @override
  Future<void> onClose() async {
    titleController.dispose();
    contentController.dispose();

    super.onClose();
  }

  Future<void> initData() async {
    faqBoardDetailModel = await FAQBoardDetailRepository().get(id);

    titleController.text = faqBoardDetailModel.question ?? "";
    contentController.text = faqBoardDetailModel.answer ?? "";

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    if (attachedFile != null) {
      faqBoardDetailModel.attachedFile =
          BlobNameGenerator.generateBlobName(attachedFile!);
    }

    BaseModel model = await FAQBoardEditRepository().put(
        id,
        FAQBoardEditReqPut(
            question: titleController.text,
            answer: contentController.text,
            attachedFile: faqBoardDetailModel.attachedFile));

    if (model.isSuccess) {
      if (attachedFile != null) {
        await UploadRepository().uploadFile(attachedFile!,
            blobName: faqBoardDetailModel.attachedFile);
      }

      Get.offAllNamed(AppRoutes.faqBoardDetail,
          arguments: {RouteArguments.id: id});
    } else {
      showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
    }

    isLoading.value = false;
  }

  void onPickFile(File? pickedFile) {
    if (pickedFile != null) {
      attachedFile = pickedFile;
    }
  }

  void nextList() {
    String text = contentController.text;
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
      contentController.value = contentController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }
}

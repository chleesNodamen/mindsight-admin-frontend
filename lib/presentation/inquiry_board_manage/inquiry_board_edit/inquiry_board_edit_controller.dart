import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/inquiry_board_detail/inquiry_board_detail_model.dart';
import 'package:mindsight_admin_page/data/inquiry_board_detail/inquiry_board_detail_repository.dart';
import 'package:mindsight_admin_page/data/inquiry_board_edit/inquiry_board_edit_repository.dart';
import 'package:mindsight_admin_page/data/inquiry_board_edit/inquiry_board_edit_req_put.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';

class InquiryBoardEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late InquiryBoardDetailModel inquiryBoardDetailModel;

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  late final focusNode = FocusNode();

  File? attachedFile;

  @override
  Future<void> onInit() async {
    await initData();

    super.onInit();
  }

  @override
  Future<void> onClose() async {
    subjectController.dispose();
    messageController.dispose();

    super.onClose();
  }

  Future<void> initData() async {
    inquiryBoardDetailModel = await InquiryBoardDetailRepository().get(id);

    subjectController.text = inquiryBoardDetailModel.subject ?? "";
    messageController.text = inquiryBoardDetailModel.message ?? "";

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    if (attachedFile != null) {
      inquiryBoardDetailModel.attachedFile =
          BlobNameGenerator.generateBlobName(attachedFile!);
    }

    BaseModel model = await InquiryBoardEditRepository().put(
        id,
        InquiryBoardEditReqPut(
            subject: subjectController.text,
            message: messageController.text,
            attachedFile: inquiryBoardDetailModel.attachedFile));

    if (model.isSuccess) {
      if (attachedFile != null) {
        await UploadRepository().uploadFile(attachedFile!,
            blobName: inquiryBoardDetailModel.attachedFile);
      }

      Get.offAllNamed(AppRoutes.inquiryBoardDetail,
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
    String text = messageController.text;
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
      messageController.value = messageController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }
}

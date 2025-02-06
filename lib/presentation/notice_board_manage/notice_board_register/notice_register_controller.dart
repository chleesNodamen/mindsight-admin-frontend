// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/notice_board_register/notice_board_register_repository.dart';
import 'package:mindsight_admin_page/data/notice_board_register/notice_board_register_req_post.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';

class NoticeBoardRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  late final focusNode = FocusNode();

  // 첨부파일
  File? attachedFile;

  @override
  Future<void> onInit() async {
    super.onInit();

    await initData();
  }

  @override
  Future<void> onClose() async {
    super.onClose();

    titleController.dispose();
    contentController.dispose();
  }

  Future<void> initData() async {
    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    // 첨부파일
    String? attachedFileUrl;
    if (attachedFile != null) {
      attachedFileUrl = BlobNameGenerator.generateBlobName(attachedFile!);
    }

    BaseModel model = await NoticeBoardRegisterRepository().post(
        NoticeBoardRegisterReqPost(
            title: titleController.text,
            content: contentController.text,
            attachedFile: attachedFileUrl // 첨부파일
            ));

    if (model.isSuccess) {
      // 첨부파일
      if (attachedFile != null) {
        await UploadRepository()
            .uploadFile(attachedFile!, blobName: attachedFileUrl);
      }

      Get.offAllNamed(AppRoutes.noticeBoardManage);
    } else {
      showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
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

  // 첨부파일
  void onPickFile(File? pickedFile) {
    if (pickedFile != null) {
      attachedFile = pickedFile;
    }
  }
}

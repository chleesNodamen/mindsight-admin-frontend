// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/free_board_register/free_board_register_repository.dart';
import 'package:mindsight_admin_page/data/free_board_register/free_board_register_req_post.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';

class FreeBoardRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

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
    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    String? attachedFileUrl;
    if (attachedFile != null) {
      attachedFileUrl = BlobNameGenerator.generateBlobName(attachedFile!);
    }

    BaseModel model = await FreeBoardRegisterRepository().post(
        FreeBoardRegisterReqPost(
            title: titleController.text,
            content: contentController.text,
            attachedFile: attachedFileUrl));

    if (model.isSuccess) {
      if (attachedFile != null) {
        await UploadRepository()
            .uploadFile(attachedFile!, blobName: attachedFileUrl);
      }
      Get.offAllNamed(AppRoutes.freeBoardManage);
    } else {
      showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
    }
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

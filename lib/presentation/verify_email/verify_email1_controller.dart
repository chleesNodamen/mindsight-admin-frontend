import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/master_check_code/master_check_code_repository.dart';
import 'package:mindsight_admin_page/data/master_check_code/master_check_code_req_post.dart';
import 'package:mindsight_admin_page/data/master_verify_email/master_verify_email_repository.dart';
import 'package:mindsight_admin_page/data/master_verify_email/master_verify_email_req_post.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_register/master_register_controller.dart';

class VerifyEmail1Controller extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isInited = true.obs;

  TextEditingController codeController = TextEditingController();
  String email = Get.arguments[RouteArguments.email];

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    super.onClose();

    codeController.dispose();
  }

  Future<void> onResendCode() async {
    isLoading.value = true;

    BaseModel model = await MasterVerifyEmailRepository().post(
        MasterVerifyEmailReqPost(
            email: email, type: MasterVerifyEmailRepository.register));

    isLoading.value = false;

    if (model.isSuccess) {
      showSimpleMessage("Code sent successfully.".tr);
    }
  }

  Future<void> onContinue() async {
    isLoading.value = true;

    BaseModel model = await MasterCheckCodeRepository()
        .post(MasterCheckCodeReqPost(email: email, code: codeController.text));

    isLoading.value = false;

    if (model.isSuccess) {
      Get.toNamed(AppRoutes.masterRegister,
          arguments: MasterRegisterArgs(email: email, isThirdParty: false));
    } else {
      showSimpleMessage(model.getErrorMessage());
    }
  }
}

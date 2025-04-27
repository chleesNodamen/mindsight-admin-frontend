import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/master_verify_email/master_verify_email_repository.dart';
import 'package:mindsight_admin_page/data/master_verify_email/master_verify_email_req_post.dart';

class VerifyEmail0Controller extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isInited = true.obs;

  TextEditingController emailController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    super.onClose();

    emailController.dispose();
  }

  Future<void> onContinue() async {
    isLoading.value = true;

    BaseModel model = await MasterVerifyEmailRepository().post(
        MasterVerifyEmailReqPost(
            email: emailController.text,
            type: MasterVerifyEmailRepository.register));

    isLoading.value = false;

    if (model.isSuccess) {
      Get.toNamed(AppRoutes.verifyEmail1,
          arguments: {RouteArguments.email: emailController.text});
    } else {
      showSimpleMessage(model.getErrorMessage());
    }
  }
}

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/master_password_reset/master_password_reset_repository.dart';
import 'package:mindsight_admin_page/data/master_password_reset/master_password_reset_req_post.dart';

class VerifyEmail2Controller extends GetxController {
  String email = Get.arguments[RouteArguments.email];
  String code = Get.arguments[RouteArguments.code];

  RxBool isLoading = false.obs;
  RxBool isInited = true.obs;

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCofirmController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    super.onClose();

    passwordController.dispose();
    passwordCofirmController.dispose();
  }

  Future<void> onContinue() async {
    if (passwordController.text != passwordCofirmController.text) {
      showSimpleMessage("The password does not match.".tr);
      return;
    }
    isLoading.value = true;

    BaseModel model = await MasterPasswordResetRepository().put(
        MasterPasswordResetReqPost(
            email: email, code: code, password: passwordController.text));

    isLoading.value = false;

    if (model.isSuccess) {
      await showSimpleMessage("Saved successfully".tr);

      Account.isLogined
          ? Get.offAllNamed(AppRoutes.masterManage)
          : Get.offAllNamed(AppRoutes.auth);
    }
  }
}

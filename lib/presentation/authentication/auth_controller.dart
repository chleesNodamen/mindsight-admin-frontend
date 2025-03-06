import 'dart:async';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_model.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';

class AuthenticationController extends GetxController {
  late MasterSigninModel masterSigninModel;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isTextNotEmpty = false.obs;
  RxBool isObscured = true.obs;

  RxBool isLoading = false.obs;
  RxBool isInited = false.obs;

  @override
  void onInit() async {
    super.onInit();
    emailController.addListener(_updateTextStatus);
    isInited.value = true;

    if (AppConstant.test) {
      emailController.text = AppConstant.testEmail;
      passwordController.text = AppConstant.testPassword;
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  void _updateTextStatus() {
    isTextNotEmpty.value = emailController.text.isNotEmpty;
  }

  String? emailValidator(String? value) {
    if (value == null ||
        !isValidEmail(value, isRequired: true) ||
        masterSigninModel.isErrorCode(ApiErrorCode.credentialsInvalid) ||
        masterSigninModel.isErrorCode(ApiErrorCode.emailNotVerified)) {
      return "가입된 정보가 없습니다. 다시 Confirm하고 입력해주세요. ".tr;
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null ||
        !isValidPassword(value, isRequired: true) ||
        masterSigninModel.isErrorCode(ApiErrorCode.credentialsMismatch)) {
      return "가입된 정보가 없습니다. 다시 Confirm하고 입력해주세요.".tr;
    }
    return null;
  }

  Future<bool> onContinue() async {
    isLoading.value = true;

    masterSigninModel = await MasterSigninRepository().post(MasterSigninReqPost(
        email: emailController.text, password: passwordController.text));

    isLoading.value = false;

    if (masterSigninModel.isSuccess) {
      if (Account.isAdmin) {
        Get.offAllNamed(AppRoutes.dashboard);
        SideMenuController.to.changeActiveItemTo(dashboardPageDisplayName);
        SideMenuController.to.changeActiveSubItem("");
      } else {
        Get.offAllNamed(AppRoutes.contentManage);
        SideMenuController.to.changeActiveItemTo(contentManagePageDisplayName);
        SideMenuController.to
            .changeActiveSubItem(contentManageContentDisplayName);
      }
    } else {
      if (masterSigninModel
          .getErrorMessage()
          .contains("Version is incorrect")) {
        showSimpleMessage("버젼이 맞지 않습니다. 웹브라우져를 완전히 종료 후 다시 시작 해 주십시오.");
      } else {
        showSimpleMessage(
            "Login에 실패 하였습니다. ${masterSigninModel.getErrorMessage().tr}");
      }
    }

    return true;
  }

  void onRegister() {
    Get.offAllNamed(AppRoutes.masterRegister);
  }
}

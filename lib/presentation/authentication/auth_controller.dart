import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_model.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';


class AuthenticationController extends GetxController {
  late AuthModel authModel;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isTextNotEmpty = false.obs;
  RxBool isObscured = true.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  RxBool isInited = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_updateTextStatus);

    isInited.value = true;
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
        authModel.compareErrorCode(ApiErrorCode.credentialsInvalid) ||
        authModel.compareErrorCode(ApiErrorCode.emailNotVerified)
        ) {
      return "가입된 정보가 없습니다. 다시 확인하고 입력해주세요. "
          .tr;
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null ||
        !isValidPassword(value, isRequired: true) ||
        authModel.compareErrorCode(ApiErrorCode.credentialsMismatch)
        ) {
      return "This password is incorrect.\nYou have ${authModel.attemptsLeft} attempts remaining to try again."
          .tr;
    }
    return null;
  }

  Future<bool> onContinue() async {
    isLoading.value = true;

    authModel = await AuthRepository().post(AuthReqPost(
        email: emailController.text, password: passwordController.text));

    isLoading.value = false;

    if (authModel.isSuccess) {
      Get.offAllNamed(AppRoutes.rootRoute);
    } else {
      formKey.currentState!.validate();

      if (authModel.compareErrorCode(ApiErrorCode.credentialsMismatch)) {
        if (authModel.attemptsLeft! <= 0) {
          return false;
        }
      }
    }

    return true;
  }
}

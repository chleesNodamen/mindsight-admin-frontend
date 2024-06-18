import 'package:mindsight_admin_page/app_export.dart';
// import 'package:mindsight/data/auth_sign_in/auth_signin_model.dart';
// import 'package:mindsight/data/auth_sign_in/auth_signin_repository.dart';
// import 'package:mindsight/data/auth_sign_in/auth_signin_req_post.dart';
// import 'package:mindsight/data/auth_verify_email/auth_verify_email_model.dart';
// import 'package:mindsight/data/auth_verify_email/auth_verify_email_repository.dart';
// import 'package:mindsight/data/auth_verify_email/auth_verify_email_req_post.dart';

class AuthenticationController extends GetxController {
  // late AuthSigninModel authSigninModel;
  // late AuthVerifyEmailModel authVerifyEmailModel;

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
    // debounce<String>(username, validations, time: const Duration(milliseconds: 500));

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
        !isValidEmail(value, isRequired: true)
        // authSigninModel.compareErrorCode(ApiErrorCode.credentialsInvalid) ||
        // authSigninModel.compareErrorCode(ApiErrorCode.emailNotVerified)
        ) {
      return "This email address is not registered.\nPlease check your email and try again."
          .tr;
    }

    // if (!authSigninModel.isSuccess) {
    //   return "Unknown error.\nPlease check your email and try again.".tr;
    // }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null
        // !isValidPassword(value, isRequired: true) ||
        // authSigninModel.compareErrorCode(ApiErrorCode.credentialsMismatch)
        ) {
      // return "This password is incorrect.\nYou have ${authSigninModel.attemptsLeft} attempts remaining to try again."
          // .tr;
    }
    return null;
  }

  Future<bool> onContinue() async {
    // isLoading.value = true;

    // authSigninModel = await AuthSigninRepository().post(AuthSigninReqPost(
        // email: emailController.text, password: passwordController.text));

    // isLoading.value = false;

    // if (authSigninModel.isSuccess) {
    //   Get.offAllNamed(AppRoutes.bottomNavi);
    // } else {
    //   formKey.currentState!.validate();

    //   if (authSigninModel.compareErrorCode(ApiErrorCode.credentialsMismatch)) {
    //     if (authSigninModel.attemptsLeft! <= 0) {
    //       return false;
    //     }
    //   }
    // }

    return true;
  }
}

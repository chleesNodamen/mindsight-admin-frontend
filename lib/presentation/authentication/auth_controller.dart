import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_model.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_register/master_register_controller.dart';

class AuthenticationController extends GetxController {
  late MasterSigninModel masterSigninModel;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isTextNotEmpty = false.obs;
  RxBool isObscured = true.obs;
  RxBool isLoading = false.obs;
  RxBool isInited = false.obs;
  RxBool isLoginMode = true.obs;

  @override
  void onInit() {
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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _updateTextStatus() {
    isTextNotEmpty.value = emailController.text.isNotEmpty;
  }

  String? emailValidator(String? value) {
    if (value == null ||
        !isValidEmail(value, isRequired: true) ||
        masterSigninModel.isErrorCode(ApiErrorCode.credentialsInvalid) ||
        masterSigninModel.isErrorCode(ApiErrorCode.emailNotVerified)) {
      return "No registered information found. Please confirm and try again."
          .tr;
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null ||
        !isValidPassword(value, isRequired: true) ||
        masterSigninModel.isErrorCode(ApiErrorCode.credentialsMismatch)) {
      return "No registered information found. Please confirm and try again."
          .tr;
    }
    return null;
  }

  Future<bool> onContinue() async {
    return _handleSignin(
      isThirdParty: false,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  Future<void> onSigninWithGoogle() async {
    isLoading.value = true;
    try {
      final userCredential = await googleLogin();
      Logger.log('Login success: ${userCredential.user?.email}');

      await _handleSignin(
        isThirdParty: true,
        email: userCredential.user?.email ?? '',
        password: '',
      );

      isLoading.value = false;
    } catch (e) {
      Logger.log('Login failed: $e');
      showSimpleMessage("Login Failed".tr);

      isLoading.value = false;
    }
  }

  Future<void> onSignupWithGoogle() async {
    isLoading.value = true;

    try {
      final userCredential = await googleLogin();
      Logger.log('Login success: ${userCredential.user?.email}');

      Get.toNamed(
        AppRoutes.masterRegister,
        arguments: MasterRegisterArgs(
          email: userCredential.user!.email!,
          isThirdParty: true,
        ),
      );

      isLoading.value = false;
    } catch (e) {
      Logger.log('Login failed: $e');
      showSimpleMessage("Login Failed".tr);

      isLoading.value = false;
    }
  }

  Future<UserCredential> googleLogin() async {
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.setCustomParameters({'prompt': 'select_account'});

    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  Future<bool> _handleSignin({
    required bool isThirdParty,
    required String email,
    String? password,
  }) async {
    isLoading.value = true;

    masterSigninModel = await MasterSigninRepository().post(
      MasterSigninReqPost(
        email: email,
        password: password ?? '',
        isThirdParty: isThirdParty,
      ),
    );

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
      return true;
    } else {
      if (masterSigninModel
          .getErrorMessage()
          .contains("Version is incorrect")) {
        showSimpleMessage(
          "The version does not match. Please completely close and reopen your browser."
              .tr,
        );
      } else {
        showSimpleMessage(
          "${"Login failed.".tr} ${masterSigninModel.getErrorMessage().tr}",
        );
      }
      return false;
    }
  }

  void onRegister() {
    Get.offAllNamed(AppRoutes.verifyEmail0);
  }
}

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_model.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_model.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';

class AuthenticationController extends GetxController {
  late MasterSigninModel masterSigninModel;

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
    // emailController.text = "admin@mindsight.com";
    // passwordController.text = "1234";
    emailController.text = AppConstant.defaultEmail;
    passwordController.text = AppConstant.defaultPassword;
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
        masterSigninModel.compareErrorCode(ApiErrorCode.credentialsInvalid) ||
        masterSigninModel.compareErrorCode(ApiErrorCode.emailNotVerified)) {
      return "가입된 정보가 없습니다. 다시 확인하고 입력해주세요. ".tr;
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null ||
        !isValidPassword(value, isRequired: true) ||
        masterSigninModel.compareErrorCode(ApiErrorCode.credentialsMismatch)) {
      return "가입된 정보가 없습니다. 다시 확인하고 입력해주세요.".tr;
    }
    return null;
  }

  Future<bool> onContinue() async {
    isLoading.value = true;

    masterSigninModel = await MasterSigninRepository().post(MasterSigninReqPost(
        email: emailController.text, password: passwordController.text));

    isLoading.value = false;

    if (masterSigninModel.isSuccess) {
      Get.offAllNamed(AppRoutes.dashboard);
      // PrefUtils.to.setIsLogined(true);
    } else {
      showSimpleMessage("로그인에 실패 하였습니다");
    }

    return true;
  }
}

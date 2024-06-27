import 'package:mindsight_admin_page/app_export.dart';

enum PasswordValidEnum { waiting, valid, invalid }

class AdminSettingsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }

  String email = 'random@gmail.com';
  String code = 'randomcode';

  late AuthPasswordResetModel authPasswordResetModel;

  final TextEditingController passwordController = TextEditingController();

  final CorrectWordChecker _wordChecker = CorrectWordChecker('');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isShowPassword = true.obs;

  List<Rx<PasswordValidEnum>> isPasswordValid = [
    PasswordValidEnum.waiting.obs,
    PasswordValidEnum.waiting.obs,
    PasswordValidEnum.waiting.obs
  ];

  bool checkPasswordValid(String value, bool showInvalidRedColor) {
    _wordChecker.check(value);

    Logger.log("$value ${_wordChecker.is8Characters}");

    if (_wordChecker.is8Characters) {
      isPasswordValid[0].value = PasswordValidEnum.valid;
    } else {
      if (showInvalidRedColor) {
        isPasswordValid[0].value = PasswordValidEnum.invalid;
      } else {
        isPasswordValid[0].value = PasswordValidEnum.waiting;
      }
    }

    if (_wordChecker.isUpperLowerLetter) {
      isPasswordValid[1].value = PasswordValidEnum.valid;
    } else {
      if (showInvalidRedColor) {
        isPasswordValid[1].value = PasswordValidEnum.invalid;
      } else {
        isPasswordValid[1].value = PasswordValidEnum.waiting;
      }
    }

    if (_wordChecker.is1Symbol) {
      isPasswordValid[2].value = PasswordValidEnum.valid;
    } else {
      if (showInvalidRedColor) {
        isPasswordValid[2].value = PasswordValidEnum.invalid;
      } else {
        isPasswordValid[2].value = PasswordValidEnum.waiting;
      }
    }

    return _wordChecker.is8Characters &&
        _wordChecker.isUpperLowerLetter &&
        _wordChecker.is1Symbol;
  }

  Future<void> onContinue() async {
    if (!checkPasswordValid(passwordController.text, false)) {
      return;
    }

    isLoading.value = true;

    // authPasswordResetModel = await AuthPasswordResetRepository().put(
    //     AuthPasswordResetReqPost(
    //             email: email, code: code, password: passwordController.text)
    //         .toJson());

    isLoading.value = false;

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (authPasswordResetModel.isSuccess) {
      Get.offAllNamed(AppRoutes.adminSettings);
    }
  }
}

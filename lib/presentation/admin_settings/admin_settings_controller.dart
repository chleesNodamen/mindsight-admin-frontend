// import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_mydata/admin_mydata_model.dart';
import 'package:mindsight_admin_page/data/admin_mydata/admin_mydata_repository.dart';
import 'package:mindsight_admin_page/data/admin_password/admin_password_model.dart';
import 'package:mindsight_admin_page/data/admin_password/admin_password_repository.dart';
import 'package:mindsight_admin_page/data/admin_password/admin_password_req_put.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';

enum PasswordValidEnum { waiting, valid, invalid }

class AdminSettingsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late AdminMyDataModel adminMyDataModel;
  late AdminPasswordModel adminPasswordModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;
    isInited.value = false;
    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    adminMyDataModel = await AdminMydataRepository().get();

    isLoading.value = false;
    isInited.value = true;
  }

  @override
  void onClose() {
    super.onClose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
  }

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isShowPasswordOne = true.obs;
  RxBool isShowPasswordTwo = true.obs;

  List<Rx<PasswordValidEnum>> isPasswordValid = [
    PasswordValidEnum.waiting.obs,
    PasswordValidEnum.waiting.obs,
    PasswordValidEnum.waiting.obs
  ];

  // bool checkPasswordValid(String value, bool showInvalidRedColor) {
  //   _wordChecker.check(value);

  //   Logger.log("$value ${_wordChecker.is8Characters}");

  //   if (_wordChecker.is8Characters) {
  //     isPasswordValid[0].value = PasswordValidEnum.valid;
  //   } else {
  //     if (showInvalidRedColor) {
  //       isPasswordValid[0].value = PasswordValidEnum.invalid;
  //     } else {
  //       isPasswordValid[0].value = PasswordValidEnum.waiting;
  //     }
  //   }

  //   if (_wordChecker.isUpperLowerLetter) {
  //     isPasswordValid[1].value = PasswordValidEnum.valid;
  //   } else {
  //     if (showInvalidRedColor) {
  //       isPasswordValid[1].value = PasswordValidEnum.invalid;
  //     } else {
  //       isPasswordValid[1].value = PasswordValidEnum.waiting;
  //     }
  //   }

  //   if (_wordChecker.is1Symbol) {
  //     isPasswordValid[2].value = PasswordValidEnum.valid;
  //   } else {
  //     if (showInvalidRedColor) {
  //       isPasswordValid[2].value = PasswordValidEnum.invalid;
  //     } else {
  //       isPasswordValid[2].value = PasswordValidEnum.waiting;
  //     }
  //   }

  //   return _wordChecker.is8Characters &&
  //       _wordChecker.isUpperLowerLetter &&
  //       _wordChecker.is1Symbol;
  // }

  Future<void> onContinue() async {
    // if (!checkPasswordValid(oldPasswordController.text, false)) {
    //   return;
    // }

    isLoading.value = true;

    adminPasswordModel = await AdminPasswordRepository().put(
        AdminPasswordReqPut(
            previousPassword: oldPasswordController.text,
            newPassword: newPasswordController.text));

    isLoading.value = false;

    // if (!formKey.currentState!.validate()) {
    //   return;
    // }

    if (adminPasswordModel.isSuccess) {
      Get.offAllNamed(AppRoutes.adminSettings);
    }
  }
}

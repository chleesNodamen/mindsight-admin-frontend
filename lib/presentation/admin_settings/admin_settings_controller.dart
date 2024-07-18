// import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_mydata/admin_mydata_model.dart';
import 'package:mindsight_admin_page/data/admin_mydata/admin_mydata_repository.dart';
import 'package:mindsight_admin_page/data/admin_password/admin_password_model.dart';
import 'package:mindsight_admin_page/data/admin_password/admin_password_repository.dart';
import 'package:mindsight_admin_page/data/admin_password/admin_password_req_put.dart';

enum PasswordValidEnum { waiting, valid, invalid }

class AdminSettingsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late AdminMyDataModel adminMyDataModel;
  late AdminPasswordModel adminPasswordModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;
    if (AppConstant.chleesTest) {
      adminMyDataModel = await AdminMydataRepository().get();
    } else {
      adminMyDataModel = AdminMyDataModel().copyWith(
        id: "ms_content@nodamen.com",
        department: "Mindsight Content Dept.",
        role: "마스터 (변경불가)",
        manager: "이진아",
        phone: "01012345678",
        adminEmail: "jalee@nodamen.com",
        lastActivity: DateTime.parse("2024-06-01T12:02:21"),
      );
    }
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

  final CorrectWordChecker _wordChecker = CorrectWordChecker('');
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
                newPassword: newPasswordController.text)
            .toJson());

    isLoading.value = false;

    // if (!formKey.currentState!.validate()) {
    //   return;
    // }

    if (adminPasswordModel.isSuccess) {
      Get.offAllNamed(AppRoutes.adminSettings);
    }
  }
}

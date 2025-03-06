import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_mydata/admin_mydata_model.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_mydata/admin_mydata_repository.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_password/admin_password_model.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_password/admin_password_repository.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_password/admin_password_req_put.dart';

enum PasswordValidEnum { waiting, valid, invalid }

class AdminSettingsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late AdminMyDataModel adminMyDataModel;
  late AdminPasswordModel adminPasswordModel;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  RxBool isShowPasswordOne = true.obs;
  RxBool isShowPasswordTwo = true.obs;

  List<Rx<PasswordValidEnum>> isPasswordValid = [
    PasswordValidEnum.waiting.obs,
    PasswordValidEnum.waiting.obs,
    PasswordValidEnum.waiting.obs
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    adminMyDataModel = await AdminMydataRepository().get();

    isInited.value = true;
    isLoading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
  }

  Future<void> onContinue() async {
    isLoading.value = true;

    adminPasswordModel = await AdminPasswordRepository().put(
        AdminPasswordReqPut(
            previousPassword: oldPasswordController.text,
            newPassword: newPasswordController.text));

    isLoading.value = false;

    if (adminPasswordModel.isSuccess) {
      showSimpleMessage("Saved successfully");
    } else {
      showSimpleMessage(
          "Save failed ${adminPasswordModel.getErrorMessage().tr}");
    }
  }
}

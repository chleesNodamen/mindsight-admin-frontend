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

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

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
      showSimpleMessage(Get.context!, "성공적으로 저장 되었습니다");
    } else {
      showSimpleMessage(Get.context!, "저장에 실패 하였습니다");
    }
  }
}

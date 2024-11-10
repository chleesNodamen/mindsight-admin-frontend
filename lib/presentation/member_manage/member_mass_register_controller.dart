import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';

class MemberMassRegisterController extends GetxController {
  // final id = Get.arguments[RouteArguments.id];

  final id = "YJgrEkheVCbpnIwis2gYjg%3D%3D";

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  RxString fileName = "".obs;
  RxBool enableFileError = false.obs;

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

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    isLoading.value = false;
  }
}

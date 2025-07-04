import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_signin_nouse/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_signin_nouse/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';

class CompanyMassRegisterController extends GetxController {
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

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    isLoading.value = false;
  }
}

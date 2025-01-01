import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/practice_details/practice_details_model.dart';
import 'package:mindsight_admin_page/data/practice_details/practice_details_repository.dart';

class PracticeDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  late PracticeDetailsModel practiceDetailsModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;
    isInited.value = false;

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    practiceDetailsModel = await PracticeDetailsRepository().get(id);

    isLoading.value = false;
    isInited.value = true;
  }

  void onPracticeTap() {
    Get.offAllNamed(AppRoutes.practiceEdit, arguments: {RouteArguments.id: id});
  }

  void goToPractice() {
    Get.offAllNamed(AppRoutes.contentPracticeManage);
  }
}

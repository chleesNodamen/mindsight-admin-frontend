import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/dashboard_challenge/dashboard_challenge_model.dart';
import 'package:mindsight_admin_page/data/dashboard_challenge/dashboard_challenge_repository.dart';
import 'package:mindsight_admin_page/data/dashboard_challenge/dashboard_challenge_req_get.dart';
import 'package:mindsight_admin_page/data/dashboard_practice/dashboard_practice_model.dart';
import 'package:mindsight_admin_page/data/dashboard_practice/dashboard_practice_repository.dart';
import 'package:mindsight_admin_page/data/dashboard_practice/dashboard_practice_req_get.dart';
import 'package:mindsight_admin_page/data/dashboard_registered/dashboard_registered_model.dart';
import 'package:mindsight_admin_page/data/dashboard_registered/dashboard_registered_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';

class DashboardController extends GetxController {
  late DashboardChallengeModel challengeModel;
  late DashboardPracticeModel practiceModel;
  late DashboardRegisteredModel registeredModel;
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    if (AppConstant.test) {
      await MasterSigninRepository().post(MasterSigninReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    challengeModel = await DashboardChallengeRepository()
        .get(DashboardChallengeReqGet(page: 1));
    practiceModel = await DashboardPracticeRepository()
        .get(DashboardPracticeReqGet(page: 1));
    registeredModel = await DashboardRegisteredRepository().get();

    isInited.value = true;
    isLoading.value = false;
  }

  void onPracticeTap(int index) {
    Get.offAllNamed(AppRoutes.practiceDetails,
        arguments: {RouteArguments.id: practiceModel.id![index]});
    SideMenuController.to.changeActiveItemTo(contentManagePageDisplayName);
    SideMenuController.to.changeActiveSubItem(contentPracticeDisplayName);
  }

  void onPracticeMore() {
    Get.offAllNamed(AppRoutes.contentPracticeManage);
    SideMenuController.to.changeActiveItemTo(contentManagePageDisplayName);
    SideMenuController.to.changeActiveSubItem(contentPracticeDisplayName);
  }

  void onChallengeMore() {
    Get.offAllNamed(AppRoutes.contentChallengeManage);
    SideMenuController.to.changeActiveItemTo(contentManagePageDisplayName);
    SideMenuController.to.changeActiveSubItem(contentChallengeDisplayName);
  }

  void onChallengeTap(int index) {
    Get.offAllNamed(AppRoutes.challengeDetails,
        arguments: {RouteArguments.id: challengeModel.id![index]});
    SideMenuController.to.changeActiveItemTo(contentManagePageDisplayName);
    SideMenuController.to.changeActiveSubItem(contentChallengeDisplayName);
  }
}

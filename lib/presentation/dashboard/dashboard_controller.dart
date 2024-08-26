import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/dashboard_challenge/dashboard_challenge_model.dart';
import 'package:mindsight_admin_page/data/dashboard_challenge/dashboard_challenge_repository.dart';
import 'package:mindsight_admin_page/data/dashboard_challenge/dashboard_challenge_req_get.dart';
import 'package:mindsight_admin_page/data/dashboard_practice/dashboard_practice_model.dart';
import 'package:mindsight_admin_page/data/dashboard_practice/dashboard_practice_repository.dart';
import 'package:mindsight_admin_page/data/dashboard_practice/dashboard_practice_req_get.dart';
import 'package:mindsight_admin_page/data/dashboard_registered/dashboard_registered_model.dart';
import 'package:mindsight_admin_page/data/dashboard_registered/dashboard_registered_repository.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_details/challenge_details_controller.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_details/practice_details_controller.dart';

class DashboardController extends GetxController {
  late DashboardChallengeModel challengeModel;
  late DashboardPracticeModel practiceModel;
  late DashboardRegisteredModel registeredModel;
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;
    challengeModel = await DashboardChallengeRepository()
        .get(DashboardChallengeReqGet(page: 1).toJson());
    practiceModel = await DashboardPracticeRepository()
        .get(DashboardPracticeReqGet(page: 1).toJson());
    registeredModel = await DashboardRegisteredRepository().get();
    isLoading.value = false;
    isInited.value = true;
  }

  void onPracticeTap(int index) {
    if (Get.isRegistered<PracticeDetailsController>()) {
      Get.delete<PracticeDetailsController>();
    }
    Get.toNamed(AppRoutes.practiceDetails,
        arguments: {RouteArguments.id: practiceModel.id![index]});
    menuController.changeActiveItemTo(contentManagePageDisplayName);
    menuController.changeActiveSubItem(contentPracticePlanDisplayName);
  }

  void onPracticeMore() {
    Get.toNamed(AppRoutes.contentPracticePlanManage);
    menuController.changeActiveItemTo(contentManagePageDisplayName);
    menuController.changeActiveSubItem(contentPracticePlanDisplayName);
  }

  void onChallengeMore() {
    Get.toNamed(AppRoutes.contentChallengeManage);
    menuController.changeActiveItemTo(contentManagePageDisplayName);
    menuController.changeActiveSubItem(contentChallengeDisplayName);
  }

  void onChallengeTap(int index) {
    if (Get.isRegistered<ChallengeDetailsController>()) {
      Get.delete<ChallengeDetailsController>();
    }
    Get.toNamed(AppRoutes.challengeDetails,
        arguments: {RouteArguments.id: challengeModel.id![index]});
    menuController.changeActiveItemTo(contentManagePageDisplayName);
    menuController.changeActiveSubItem(contentChallengeDisplayName);
  }
}

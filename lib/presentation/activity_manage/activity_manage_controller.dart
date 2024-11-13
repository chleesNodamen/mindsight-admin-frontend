import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/activity/activity_model.dart';
import 'package:mindsight_admin_page/data/activity/activity_repository.dart';
import 'package:mindsight_admin_page/data/activity/activity_req_get.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';

class ActivityManageController extends GetxController {
  late ActivityModel activityModel;
  late AffiliationModel affiliationModel;

  List<String> typeLabels = [
    "Practice plan",
    "Challenge",
  ];

  List<String> membershipLabels = [
    "Nodamen",
    "UNHCR",
    "UN Women",
  ];

  List<String> chatbotLabels = [
    "있음",
    "없음",
  ];

  List<String> feedbackLabels = [
    "안함",
    "완료",
  ];

  RxList<bool> membershipValues = List<bool>.filled(3, true).obs;
  RxList<bool> chatbotValues = List<bool>.filled(2, true).obs;
  RxList<bool> feedbackValues = List<bool>.filled(2, true).obs;
  Rx<ActivityType> type = ActivityType.practice.obs;
  RxInt activePage = 1.obs;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;
    searchOn = false.obs;
    chatbotValues = List<bool>.filled(2, true).obs;
    feedbackValues = List<bool>.filled(2, true).obs;
    searchValue = "".obs;
    activePage = 1.obs;

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    affiliationModel = await AffiliationRepository().get();
    membershipLabels = affiliationModel.affiliation!;
    membershipValues = List<bool>.filled(affiliationModel.length, true).obs;

    await loadPage(1);

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> toggleMembership(int index, bool value) async {
    membershipValues[index] = value;

    await loadPage(1);
  }

  Future<void> toggleChatbot(int index, bool value) async {
    chatbotValues[index] = value;

    await loadPage(1);
  }

  Future<void> toggleFeedback(int index, bool value) async {
    feedbackValues[index] = value;

    await loadPage(1);
  }

  List<String> getCheckedAffiliation() {
    List<String> affiliation = [
      for (int i = 0; i < membershipLabels.length; i++)
        if (membershipValues[i]) membershipLabels[i]
    ];

    // 모두 체크 되었을 떄..조건 주지 않음
    if (membershipValues.every((element) => element == true)) {
      affiliation = [];
    }

    // 아무것도 체크 안되었을때는..검색이 안되어야 된다..
    if (membershipValues.every((element) => element == false)) {
      affiliation = ['known'];
    }

    return affiliation;
  }

  Future<void> loadPage(int pageNum) async {
    isLoading.value = true;

    activityModel = await ActivityRepository().get(ActivityReqGet(
      page: pageNum,
      search: searchOn.value ? searchValue.value : null,
      affiliation: getCheckedAffiliation(),
      chatbot: chatbotValues[0] && chatbotValues[1] ? null : !chatbotValues[0],
      feedback:
          feedbackValues[0] && feedbackValues[1] ? null : !feedbackValues[0],
      type: type.value.name,
    ));

    activePage.value = pageNum;

    isLoading.value = false;
  }

  void onHistoryTap(int index) {
    Get.offAllNamed(AppRoutes.activityHistory, arguments: {
      RouteArguments.id: activityModel.recordId![index],
      RouteArguments.type: activityModel.type![index],
      RouteArguments.memberId: activityModel.memberId![index]
    });
  }

  void onMemberTap(int index) {
    Get.offAllNamed(AppRoutes.memberDetails,
        arguments: {RouteArguments.id: activityModel.memberId![index]});
    SideMenuController.to.changeActiveItemTo(memberManagePageDisplayName);
    SideMenuController.to.changeActiveSubItem(memberDetailsPageDisplayName);
  }

  void onSessionTap(int index) {
    if (type.value == ActivityType.practice) {
      Get.offAllNamed(AppRoutes.practiceDetails,
          arguments: {RouteArguments.id: activityModel.sessionId![index]});
      SideMenuController.to.changeActiveItemTo(contentManagePageDisplayName);
      SideMenuController.to.changeActiveSubItem(contentPracticeDisplayName);
    } else {
      Get.offAllNamed(AppRoutes.challengeDetails,
          arguments: {RouteArguments.id: activityModel.sessionId![index]});
      SideMenuController.to.changeActiveItemTo(contentManagePageDisplayName);
      SideMenuController.to.changeActiveSubItem(contentChallengeDisplayName);
    }
  }

  Future<void> onChangeType(ActivityType? newType) async {
    searchOn.value = false;
    searchValue.value = "";
    if (newType == null) {
      return;
    }
    type.value = newType;

    await loadPage(1);

    membershipValues.value =
        List.generate(membershipValues.length, (_) => true);
    feedbackValues.value = List.generate(feedbackValues.length, (_) => true);
    chatbotValues.value = List.generate(chatbotValues.length, (_) => true);
    activePage.value = 1;
    isLoading.value = false;
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;

    await loadPage(1);
  }
}

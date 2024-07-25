import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/activity/activity_model.dart';
import 'package:mindsight_admin_page/data/activity/activity_repository.dart';
import 'package:mindsight_admin_page/data/activity/activity_req_get.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_repository.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_history_controller.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_details/challenge_details_controller.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_details/practice_details_controller.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_details_controller.dart';

enum Type { practice, challenge }

class ActivityManageController extends GetxController {
  static ActivityManageController get to =>
      Get.find<ActivityManageController>();

  //  FIRST CONTAINER //
  List<String> typeLabels = [
    "Practice plan",
    "Challenge",
  ];
  // Initial list of checkbox labels
  List<String> membershipLabels = [
    "Nodamen",
    "UNHCR",
    "UN Women",
  ];
  // List of additional checkbox labels
  List<String> chatbotLabels = [
    "있음",
    "없음",
  ];
  List<String> feedbackLabels = [
    "안함",
    "완료",
  ];

  // Initial list of checkbox values
  RxList<bool> membershipValues = List<bool>.filled(3, true).obs;
  RxList<bool> chatbotValues = List<bool>.filled(2, true).obs;
  RxList<bool> feedbackValues = List<bool>.filled(2, true).obs;
  Rx<Type> type = Type.practice.obs;
  RxInt activePage = 1.obs;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

  late ActivityModel activityModel;
  late AffiliationModel affiliationModel;

  @override
  Future<void> onInit() async {
    loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;
    searchOn = false.obs;
    chatbotValues = List<bool>.filled(2, true).obs;
    feedbackValues = List<bool>.filled(2, true).obs;
    searchValue = "".obs;
    activePage = 1.obs;
    if (AppConstant.chleesTest) {
      activityModel = await ActivityRepository().get(ActivityReqGet(
        page: 1,
        type: "practice",
      ).toJson());
      affiliationModel = await AffiliationRepository().get();
      membershipLabels = affiliationModel.affiliation!;
      membershipValues = List<bool>.filled(affiliationModel.length, true).obs;
    } else {
      activityModel = ActivityModel().copyWith(
        type: List.generate(10, (_) => 'Practice plan'),
        memberId: List.generate(10, (_) => ''),
        email: List.generate(10, (_) => 'aiden@nodamen.com'),
        sessionId: List.generate(10, (_) => '3회차'),
        sessionName: List.generate(10, (_) => '3회차'),
        recordId: List.generate(10, (_) => 'Practice plan'),
        record: List.generate(10, (_) => 'Easy to follow some of them, 4'),
        feedback: List.generate(10, (_) => false),
        total: 10,
      );
    }
    activityModel.length = activityModel.recordId!.length;
    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> toggleMembership(int index, bool value) async {
    isLoading.value = true;
    membershipValues[index] = value;
    if (await loadNewData()) {
      activePage.value = 1;
      isLoading.value = false;
    }
  }

  Future<void> toggleChatbot(int index, bool value) async {
    isLoading.value = true;
    chatbotValues[index] = value;
    if (await loadNewData()) {
      activePage.value = 1;
      isLoading.value = false;
    }
  }

  Future<void> toggleFeedback(int index, bool value) async {
    isLoading.value = true;
    feedbackValues[index] = value;
    if (await loadNewData()) {
      activePage.value = 1;
      isLoading.value = false;
    }
  }

  Future<bool> loadNewData() async {
    searchOn.value = false;
    searchValue.value = "";
    if (feedbackValues.every((element) => element == false) ||
        chatbotValues.every((element) => element == false)) {
      activityModel = ActivityModel().copyWith(
        type: null,
        memberId: null,
        email: null,
        sessionId: null,
        sessionName: null,
        recordId: null,
        record: null,
        feedback: null,
        total: 0,
      );
      return true;
    }
    List<String> chosenAffiliation = [
      for (int i = 0; i < membershipLabels.length; i++)
        if (membershipValues[i]) membershipLabels[i]
    ];
    if (membershipValues.every((element) => element == true)) {
      chosenAffiliation = [];
    } //TODO remove later
    activityModel = await ActivityRepository().get(ActivityReqGet(
      page: 1,
      type: type.value.name,
      affiliation: chosenAffiliation,
      chatbot: chatbotValues.contains(false) ? chatbotValues[0] : null,
      feedback: feedbackValues.contains(false) ? feedbackValues[1] : null,
    ).toJson());
    return activityModel.isSuccess;
  }

  Future<void> loadNewPage(int pageNum) async {
    List<String> chosenAffiliation = [
      for (int i = 0; i < membershipLabels.length; i++)
        if (membershipValues[i]) membershipLabels[i]
    ];
    if (membershipValues.every((element) => element == true)) {
      chosenAffiliation = [];
    } //TODO remove later
    isLoading.value = true;
    activityModel = await ActivityRepository().get(ActivityReqGet(
      page: pageNum,
      search: searchOn.value ? searchValue.value : null,
      affiliation: chosenAffiliation,
      type: type.value.name,
    ).toJson());
    activePage.value = pageNum;
    isLoading.value = false;
  }

  void onHistoryTap(int index) {
    if (Get.isRegistered<ActivityHistoryController>()) {
      Get.delete<ActivityHistoryController>();
    }
    Get.toNamed(AppRoutes.activityHistory, arguments: {
      RouteArguments.id: activityModel.recordId![index],
      RouteArguments.type: activityModel.type![index],
      RouteArguments.memberId: activityModel.memberId![index]
    });
  }

  void onMemberTap(int index) {
    if (Get.isRegistered<MemberDetailsController>()) {
      Get.delete<MemberDetailsController>();
    }
    Get.toNamed(AppRoutes.memberDetails,
        arguments: {RouteArguments.id: activityModel.memberId![index]});
    menuController.changeActiveItemTo(memberManagePageDisplayName);
    menuController.changeActiveSubItem(memberDetailsPageDisplayName);
  }

  void onSessionTap(int index) {
    if (type.value == Type.practice) {
      if (Get.isRegistered<PracticeDetailsController>()) {
        Get.delete<PracticeDetailsController>();
      }
      Get.toNamed(AppRoutes.practiceDetails,
          arguments: {RouteArguments.id: activityModel.sessionId![index]});
      menuController.changeActiveItemTo(contentManagePageDisplayName);
      menuController.changeActiveSubItem(contentPracticePlanDisplayName);
    } else {
      if (Get.isRegistered<ChallengeDetailsController>()) {
        Get.delete<ChallengeDetailsController>();
      }
      Get.toNamed(AppRoutes.challengeDetails,
          arguments: {RouteArguments.id: activityModel.sessionId![index]});
      menuController.changeActiveItemTo(contentManagePageDisplayName);
      menuController.changeActiveSubItem(contentChallengeDisplayName);
    }
  }

  Future<void> changeType(Type? newType) async {
    searchOn.value = false;
    searchValue.value = "";
    if (newType == null) {
      return;
    }
    isLoading.value = true;
    activityModel = await ActivityRepository().get(ActivityReqGet(
      page: 1,
      type: newType.name,
    ).toJson());
    type.value = newType;
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
    isLoading.value = true;
    List<String> chosenAffiliation = [
      for (int i = 0; i < membershipLabels.length; i++)
        if (membershipValues[i]) membershipLabels[i]
    ];
    //TODO remove later
    activityModel = await ActivityRepository().get(ActivityReqGet(
            page: 1,
            type: type.value.name,
            affiliation: chosenAffiliation,
            chatbot: chatbotValues.contains(false) ? chatbotValues[0] : null,
            feedback: feedbackValues.contains(false) ? feedbackValues[1] : null,
            search: search)
        .toJson());
    isLoading.value = false;
    activePage.value = 1;
  }
}

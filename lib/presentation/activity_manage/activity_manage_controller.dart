import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/route_arguments.dart';
import 'package:mindsight_admin_page/data/activity/activity_model.dart';
import 'package:mindsight_admin_page/data/activity/activity_repository.dart';
import 'package:mindsight_admin_page/data/activity/activity_req_get.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_repository.dart';

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
  RxBool showMore = false.obs;
  RxBool isChecked = true.obs;
  RxList<bool> chatbotValues = List<bool>.filled(2, true).obs;
  RxList<bool> feedbackValues = List<bool>.filled(2, true).obs;
  Rx<Type> type = Type.practice.obs;
  RxInt activePage = 1.obs;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late ActivityModel activityModel;
  late AffiliationModel affiliationModel;

  @override
  Future<void> onInit() async {
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
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> toggleMembership(int index, bool value) async {
    List<String> chosenAffiliation = [
      for (int i = 0; i < membershipLabels.length; i++)
        if (membershipValues[i]) membershipLabels[i]
    ];
    activityModel = await ActivityRepository().get(ActivityReqGet(
      page: 1,
      type: "practice",
      affiliation: chosenAffiliation,
      chatbot: chatbotValues.contains(false) ? chatbotValues[0] : null,
      feedback: feedbackValues.contains(false) ? feedbackValues[1] : null,
    ).toJson());
    membershipValues[index] = value;
  }

  void toggleChatbot(int index, bool value) {
    chatbotValues[index] = value;
  }

  void toggleFeedback(int index, bool value) {
    feedbackValues[index] = value;
  }

  Future<void> loadNewPage(int pageNum) async {
    isLoading.value = true;
    activityModel = await ActivityRepository().get(ActivityReqGet(
      page: pageNum,
      type: type.value.name,
    ).toJson());
    activePage.value = pageNum;
  }

  void onHistoryTap(int index) {
    Get.toNamed(AppRoutes.activityHistory, arguments: {
      RouteArguments.id: activityModel.recordId![index],
      RouteArguments.type: activityModel.type![index],
      RouteArguments.memberId: activityModel.memberId![index]
    });
  }

  void onMemberTap(int index) {
    Get.toNamed(AppRoutes.memberDetails,
        arguments: {RouteArguments.id: activityModel.memberId![index]});
  }

  void onSessionTap(int index) {
    if (type.value == Type.practice) {
      Get.toNamed(AppRoutes.practiceDetails,
          arguments: {RouteArguments.id: activityModel.sessionId![index]});
    } else {
      Get.toNamed(AppRoutes.challengeDetails,
          arguments: {RouteArguments.id: activityModel.sessionId![index]});
    }
  }

  Future<void> changeType(Type? newType) async {
    if (newType == null) {
      return;
    }
    isLoading.value = true;
    activityModel = await ActivityRepository().get(ActivityReqGet(
      page: 1,
      type: newType.name,
    ).toJson());
    type.value = newType;
    activePage.value = 1;
    isLoading.value = false;
  }

  Future<void> onSearch({String? search}) async {
    isLoading.value = true;
    List<String> chosenAffiliation = [
      for (int i = 0; i < membershipLabels.length; i++)
        if (membershipValues[i]) membershipLabels[i]
    ];
    activityModel = await ActivityRepository().get(ActivityReqGet(
            page: 1,
            type: "practice",
            affiliation: chosenAffiliation,
            chatbot: chatbotValues.contains(false) ? chatbotValues[0] : null,
            feedback: feedbackValues.contains(false) ? feedbackValues[1] : null,
            search: search)
        .toJson());
    isLoading.value = false;
    activePage.value = 1;
  }
}

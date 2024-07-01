import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/route_arguments.dart';
import 'package:mindsight_admin_page/data/activity/activity_model.dart';

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

  @override
  Future<void> onInit() async {
    if (AppConstant.chleesTest) {
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

  void toggleMembership(int index, bool value) {
    membershipValues[index] = value;
  }

  void toggleChatbot(int index, bool value) {
    chatbotValues[index] = value;
  }

  void toggleFeedback(int index, bool value) {
    feedbackValues[index] = value;
  }

  void loadNewPage(int pageNum) {
    activePage.value = pageNum;
  }

  void onHistoryTap() {
    // menuController.changeActiveItemTo(activityHistoryPageDisplayName);
    // navigationController.navigateTo(activityHistoryPageRoute, arguments: {"hello": "hello"});
    Get.toNamed(AppRoutes.activityHistory,
        arguments: {RouteArguments.id: activityModel.recordId});
  }

  void onMemberTap() {
    Get.toNamed(AppRoutes.memberDetails,
        arguments: {RouteArguments.id: activityModel.memberId});
  }

  void onSessionTap() {
    Get.toNamed(AppRoutes.memberDetails,
        arguments: {RouteArguments.id: activityModel.recordId}); //TODO
  }
}

import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/activity_chat.dart/activity_chat_model.dart';
import 'package:mindsight_admin_page/data/activity_chat.dart/activity_chat_repository.dart';
import 'package:mindsight_admin_page/data/activity_chat.dart/chat_log.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_model.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_repository.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_req_get.dart';
import 'package:mindsight_admin_page/data/activity_expert/activity_expert_model.dart';
import 'package:mindsight_admin_page/data/activity_expert/activity_expert_repository.dart';
import 'package:mindsight_admin_page/data/activity_expert/activity_expert_req_put.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_details/challenge_details_controller.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_details/practice_details_controller.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_details_controller.dart';

class ActivityHistoryController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  final type = Get.arguments[RouteArguments.type];
  final memberId = Get.arguments[RouteArguments.memberId];

  // final id = "";
  // final type = "practice";

  final TextEditingController feedbackController = TextEditingController();
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  bool? chatBot;
  RxBool feedback = false.obs;
  String registrationDate = "";
  String sessionStartDate = "";
  String sessionEndDate = "";
  String expertMessageDate = "";

  late ActivityDetailsModel activityDetailsModel;
  late ActivityExpertModel activityExpertModel;
  late ActivityChatModel activityChatModel;

  @override
  Future<void> onInit() async {
    loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;
    activityDetailsModel = await ActivityDetailsRepository()
        .get(id, ActivityDetailsReqGet(type: type).toJson());

    if (activityDetailsModel.registrationDate != null) {
      registrationDate = DateFormat('yyyy-MM-dd')
          .format(activityDetailsModel.registrationDate!);
    }
    if (activityDetailsModel.sessionStartDate != null) {
      sessionStartDate = DateFormat('yyyy-MM-dd-HH:mm:ss')
          .format(activityDetailsModel.sessionStartDate!);
    }
    if (activityDetailsModel.sessionEndDate != null) {
      sessionEndDate = DateFormat('yyyy-MM-dd-HH:mm:ss')
          .format(activityDetailsModel.sessionEndDate!);
    }
    if (activityDetailsModel.expertMessageDate != null) {
      expertMessageDate = DateFormat('yyyy-MM-dd-HH:mm:ss')
          .format(activityDetailsModel.expertMessageDate!);
    }
    chatBot = activityDetailsModel.chatbot != null;
    feedback.value = activityDetailsModel.expertMessage != null;
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> onFeedback() async {
    if (AppConstant.chleesTest) {
      isLoading.value = true;
      activityExpertModel = await ActivityExpertRepository().put(
          id,
          ActivityExpertReqPut(type: type, feedback: feedbackController.text)
              .toJson());
      if (activityExpertModel.isSuccess) {
        activityDetailsModel = await ActivityDetailsRepository()
            .get(id, ActivityDetailsReqGet(type: type).toJson());
        if (activityDetailsModel.expertMessageDate != null) {
          expertMessageDate = DateFormat('yyyy-MM-dd-HH:mm:ss')
              .format(activityDetailsModel.expertMessageDate!);
        }
        feedback.value = true;
      }
      isLoading.value = false;
    }
    Get.back();
  }

  Future<void> onChat() async {
    if (AppConstant.chleesTest) {
      isLoading.value = true;
      activityChatModel = await ActivityChatRepository().get(
        activityDetailsModel.chatbot!,
      );
      isLoading.value = false;
    } else {
      activityChatModel = ActivityChatModel().copyWith(
        reaction: '만족',
        createdAt: DateTime.now(),
        chatlog: [
          ChatLog(
              role: "Chatbot",
              content: "Hi, Aiden!\nHow can I help you today?"),
          ChatLog(
              role: "User",
              content:
                  "I feel so tight in my chest. Sometimes I can't breathe. I've been stressed about work lately. I feel like my symptoms are worse when I'm sitting at my computer.")
        ],
      );
      activityChatModel.length = activityChatModel.chatlog!.length;
    }
  }

  void onMemberTap() {
    Get.toNamed(AppRoutes.memberDetails, arguments: {
      RouteArguments.id: memberId,
    });
    if (Get.isRegistered<MemberDetailsController>()) {
      Get.find<MemberDetailsController>().loadData();
    }
    menuController.changeActiveItemTo(memberManagePageDisplayName);
    menuController.changeActiveSubItem(memberDetailsPageDisplayName);
  }

  void onPracticeTap() {
    Get.toNamed(AppRoutes.practiceDetails,
        arguments: {RouteArguments.id: activityDetailsModel.sessionId});
    if (Get.isRegistered<PracticeDetailsController>()) {
      Get.find<PracticeDetailsController>().loadData();
    }
    menuController.changeActiveItemTo(contentManagePageDisplayName);
    menuController.changeActiveSubItem(contentPracticePlanDisplayName);
  }

  void onChallengeTap() {
    Get.toNamed(AppRoutes.challengeDetails,
        arguments: {RouteArguments.id: activityDetailsModel.sessionId});
    if (Get.isRegistered<ChallengeDetailsController>()) {
      Get.find<ChallengeDetailsController>().loadData();
    }
    menuController.changeActiveItemTo(contentManagePageDisplayName);
    menuController.changeActiveSubItem(contentChallengeDisplayName);
  }
}

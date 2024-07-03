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

class ActivityHistoryController extends GetxController {
  static ActivityHistoryController get to =>
      Get.find<ActivityHistoryController>();

  // final id = Get.arguments[RouteArguments.id];
  // final type = Get.arguments[RouteArguments.type];

  final id = "";
  final type = "Practice plan";

  final TextEditingController feedbackController = TextEditingController();
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  bool? chatBot;
  bool? feedback;
  String registrationDate = "";
  String sessionStartDate = "";
  String sessionEndDate = "";
  String expertMessageDate = "";

  late ActivityDetailsModel activityDetailsModel;
  late ActivityExpertModel activityExpertModel;
  late ActivityChatModel activityChatModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (AppConstant.chleesTest) {
      activityDetailsModel = await ActivityDetailsRepository()
          .get(id, ActivityDetailsReqGet(type: type).toJson());
    } else {
      activityDetailsModel = ActivityDetailsModel().copyWith(
          id: "",
          email: 'akdlsemtkdlxm@nodamen.com',
          username: 'dbwjspdla',
          // "registrationDate": '2023-04-01T12:00:00.000Z',
          registrationDate: DateTime.now(),
          level: '36회차',
          body: 'Sunrise 10-Minute Morning Yoga A',
          breath: 'Sunrise 10-Minute Morning Yoga B',
          title: '30-Day Challenge to Strengthen Your Legs',
          goal: 'Improve health',
          days: '30일',
          intro:
              'This is a 30-Day challenge to Strengthen your legs.Strengthen your legs will increase muscle mass throughout the body, which helps boost metabolism such as breathing and blood circulation.',
          type: "Practice plan",
          recordOne: 'Stressed',
          recordTwo: 'Feeling fatigued, Distracted mind',
          sessionStartDate: DateTime.now(),
          sessionEndDate: DateTime.now(),
          chatbot: 'chatbot',
          expertMessage:
              'You are shining a bit brighter now! We\'re so happy to see the positive changes in your mood! Let\'s keep this beautiful journey and uncover even more wonderful insights.',
          expertMessageDate: DateTime.now());
    }
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
    feedback = activityDetailsModel.expertMessage != null;
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
      isLoading.value = false;
    }
    Get.back();
  }

  Future<void> onChat() async {
    if (AppConstant.chleesTest) {
      isLoading.value = true;
      activityChatModel = await ActivityChatRepository().get(
        id,
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
      RouteArguments.id: id,
    });
  }

  void onPracticeTap() {
    Get.toNamed(AppRoutes.practiceDetails,
        arguments: {RouteArguments.id: activityDetailsModel.sessionId});
  }

  void onChallengeTap() {
    Get.toNamed(AppRoutes.challengeDetails,
        arguments: {RouteArguments.id: activityDetailsModel.sessionId});
  }
}

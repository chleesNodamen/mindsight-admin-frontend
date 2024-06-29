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
          registrationDate: '2023-04-01',
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
          sessionStartDate: '2024-03-13-10:09:34',
          sessionEndDate: '2024-03-13-10:09:34',
          chatbot: 'chatbot',
          expertMessage:
              'You are shining a bit brighter now! We\'re so happy to see the positive changes in your mood! Let\'s keep this beautiful journey and uncover even more wonderful insights.',
          expertMessageDate: '2024-03-13-10:09:34');
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
    //TODO
  }
  void onChallengeTap() {
    //TODO
  }
}

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/activity_chat.dart/activity_chat_model.dart';
import 'package:mindsight_admin_page/data/activity_chat.dart/activity_chat_repository.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_model.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_repository.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_req_get.dart';
import 'package:mindsight_admin_page/data/activity_expert/activity_expert_model.dart';
import 'package:mindsight_admin_page/data/activity_expert/activity_expert_repository.dart';
import 'package:mindsight_admin_page/data/activity_expert/activity_expert_req_put.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_signin_nouse/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_signin_nouse/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';

class ActivityHistoryController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  final type = Get.arguments[RouteArguments.type];
  final memberId = Get.arguments[RouteArguments.memberId];

  late ActivityDetailsModel activityDetailsModel;
  late ActivityExpertModel activityExpertModel;
  late ActivityChatModel activityChatModel;

  final TextEditingController feedbackController = TextEditingController();
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  // bool? chatBot;
  // RxBool feedback = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    activityDetailsModel = await ActivityDetailsRepository()
        .get(id, ActivityDetailsReqGet(type: type));

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onFeedback() async {
    isLoading.value = true;

    activityExpertModel = await ActivityExpertRepository().put(id,
        ActivityExpertReqPut(type: type, feedback: feedbackController.text));

    if (activityExpertModel.isSuccess) {
      activityDetailsModel = await ActivityDetailsRepository()
          .get(id, ActivityDetailsReqGet(type: type));
    }
    isLoading.value = false;

    Get.back();
  }

  Future<void> onChat() async {
    isLoading.value = true;
    activityChatModel = await ActivityChatRepository().get(
      activityDetailsModel.chatbot!,
    );
    isLoading.value = false;
  }

  void onMemberTap() {
    Get.offAllNamed(AppRoutes.memberDetails, arguments: {
      RouteArguments.id: memberId,
    });
  }

  void onPracticeTap() {
    Get.offAllNamed(AppRoutes.practiceDetails,
        arguments: {RouteArguments.id: activityDetailsModel.sessionId});
  }

  void onChallengeTap() {
    Get.offAllNamed(AppRoutes.challengeDetails,
        arguments: {RouteArguments.id: activityDetailsModel.sessionId});
  }
}

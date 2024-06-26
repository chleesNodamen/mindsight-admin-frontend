import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage/challenge_manage_controller.dart';

class ChallengeManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChallengeManageController());
  }
}

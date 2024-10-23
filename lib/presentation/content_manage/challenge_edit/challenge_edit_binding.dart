import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_edit/challenge_edit_controller.dart';

class ChallengeEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChallengeEditController());
  }
}

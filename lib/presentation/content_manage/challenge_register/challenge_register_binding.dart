import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_register/challenge_register_controller.dart';

class ChallengeRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChallengeRegisterController());
  }
}

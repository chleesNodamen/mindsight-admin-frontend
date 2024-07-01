import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_details/challenge_details_controller.dart';

class ChallengeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChallengeDetailsController());
  }
}

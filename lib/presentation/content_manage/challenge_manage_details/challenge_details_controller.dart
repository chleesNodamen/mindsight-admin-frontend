import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_edit/challenge_edit_controller.dart';

class ChallengeDetailsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> loadData() async {}

  var numbers = List.generate(30, (index) => index + 1).obs;
  var contents = <String>[
    "Sunrise 10-Minute Morning Yoga A",
    "Sunrise 10-Minute Morning Yoga B",
    "Sunrise 10-Minute Morning Yoga C"
  ].obs;

  void goToEdit() {
    if (Get.isRegistered<ChallengeEditController>()) {
      Get.delete<ChallengeEditController>();
    }
    Get.toNamed(AppRoutes.challengeEdit);
  }
}

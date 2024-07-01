import 'package:mindsight_admin_page/app_export.dart';

class ChallengeEditController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }

  var numbers = List.generate(30, (index) => index + 1).obs;
  var activeNumber = 1.obs;

  void setActiveNumber(int number) {
    activeNumber.value = number;
  }

  void goToChallenge() {
    Get.toNamed(AppRoutes.contentChallengeManage);
  }
}

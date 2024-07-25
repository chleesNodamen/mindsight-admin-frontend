import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_edit/practice_edit_controller.dart';

class PracticeDetailsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  var numbers = List.generate(30, (index) => index + 1).obs;
  var activeNumber = 1.obs;

  void setActiveNumber(int number) {
    activeNumber.value = number;
  }

  final id = "";
  final type = "Practice plan";

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> loadData() async {}

  void onPracticeTap() {
    if (Get.isRegistered<PracticeEditController>()) {
      Get.delete<PracticeEditController>();
    }
    Get.toNamed(AppRoutes.practiceEdit);
  }
}

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_model.dart';

class PracticeDetailsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  var numbers = List.generate(30, (index) => index + 1).obs;
  var activeNumber = 1.obs;

  void setActiveNumber(int number) {
    activeNumber.value = number;
  }

  late ActivityDetailsModel activityDetailsModel;
  final id = "";
  final type = "Practice plan";

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }

  void onPracticeTap() {
    Get.toNamed(AppRoutes.practiceEdit);
  }
}

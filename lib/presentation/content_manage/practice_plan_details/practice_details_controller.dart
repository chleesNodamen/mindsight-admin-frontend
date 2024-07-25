import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/practice_details/practice_details_model.dart';
import 'package:mindsight_admin_page/data/practice_details/practice_details_repository.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_edit/practice_edit_controller.dart';

class PracticeDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  late PracticeDetailsModel practiceDetailsModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;
    if (AppConstant.chleesTest) {
      practiceDetailsModel = await PracticeDetailsRepository().get(id);
    }
    if (practiceDetailsModel.isSuccess) {
      // print("initialized");
    }
    isLoading.value = false;
    isInited.value = true;
  }

  void onPracticeTap() {
    if (Get.isRegistered<PracticeEditController>()) {
      Get.delete<PracticeEditController>();
    }
    Get.toNamed(AppRoutes.practiceEdit, arguments: {RouteArguments.id: id});
  }

  void goToPractice() {
    Get.toNamed(AppRoutes.contentPracticePlanManage);
  }
}

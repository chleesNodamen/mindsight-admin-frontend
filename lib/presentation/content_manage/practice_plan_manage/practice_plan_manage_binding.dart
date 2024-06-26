import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_manage/practice_plan_manage_controller.dart';

class PracticePlanManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PracticePlanManageController());
  }
}

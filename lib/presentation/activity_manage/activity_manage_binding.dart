import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage_controller.dart';

class ActivityManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityManageController());
  }
}
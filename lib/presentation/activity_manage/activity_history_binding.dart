import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_history_controller.dart';

class ActivityHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityHistoryController());
  }
}

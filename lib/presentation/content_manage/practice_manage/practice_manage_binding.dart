import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_manage/practice_manage_controller.dart';

class PracticeManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PracticeManageController());
  }
}

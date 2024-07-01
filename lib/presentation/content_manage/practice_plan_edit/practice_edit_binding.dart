import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_edit/practice_edit_controller.dart';

class PracticeEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PracticeEditController());
  }
}

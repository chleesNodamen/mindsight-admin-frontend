import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_register/practice_register_controller.dart';

class PracticeRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PracticeRegisterController());
  }
}

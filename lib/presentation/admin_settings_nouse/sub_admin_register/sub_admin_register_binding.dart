import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/admin_settings_nouse/sub_admin_register/sub_admin_register_controller.dart';

class SubAdminRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubAdminRegisterController());
  }
}

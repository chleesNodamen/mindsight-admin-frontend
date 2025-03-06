import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/admin_settings_nouse/admin_settings_controller.dart';

class AdminSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminSettingsController());
  }
}

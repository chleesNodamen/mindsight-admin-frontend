import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings_controller.dart';

class AdminSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminSettingsController());
  }
}
import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_settings/sub_admin_settings_controller.dart';

class SubAdminSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubAdminSettingsController());
  }
}

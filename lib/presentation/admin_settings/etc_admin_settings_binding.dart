import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/etc_admin_settings_controller.dart';

class EtcAdminSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EtcAdminSettingController());
  }
}

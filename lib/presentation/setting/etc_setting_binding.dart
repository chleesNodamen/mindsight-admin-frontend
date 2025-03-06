import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/setting/etc_setting_controller.dart';

class EtcSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EtcSettingController());
  }
}

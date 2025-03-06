import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/admin_settings_nouse/sub_admin_edit/sub_admin_edit_controller.dart';

class SubAdminEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubAdminEditController());
  }
}

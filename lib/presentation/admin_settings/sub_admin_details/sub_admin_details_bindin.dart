import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_details/sub_admin_details_controller.dart';

class SubAdminDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubAdminDetailsController());
  }
}

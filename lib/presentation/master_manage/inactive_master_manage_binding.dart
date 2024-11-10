import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/master_manage/inactive_master_manage_controller.dart';

class InactiveMasterManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InactiveMasterManageController());
  }
}

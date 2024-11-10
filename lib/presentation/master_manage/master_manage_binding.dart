import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_manage_controller.dart';

class MasterManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MasterManageController());
  }
}

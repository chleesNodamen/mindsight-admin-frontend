import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/free_board_manage/free_board_manage_controller.dart';

class FreeBoardManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FreeBoardManageController());
  }
}

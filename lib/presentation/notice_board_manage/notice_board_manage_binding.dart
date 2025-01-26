import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/free_board_manage/free_board_manage_controller.dart';
import 'package:mindsight_admin_page/presentation/notice_board_manage/notice_board_manage_controller.dart';

class NoticeBoardManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoticeBoardManageController());
  }
}

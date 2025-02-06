import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/notice_board_manage/notice_board_register/notice_register_controller.dart';

class NoticeBoardRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoticeBoardRegisterController());
  }
}

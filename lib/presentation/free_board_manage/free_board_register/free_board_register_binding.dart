import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_register/practice_register_controller.dart';
import 'package:mindsight_admin_page/presentation/free_board_manage/free_board_register/free_board_register_controller.dart';

class FreeBoardRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FreeBoardRegisterController());
  }
}

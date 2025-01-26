import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_edit/practice_edit_controller.dart';
import 'package:mindsight_admin_page/presentation/free_board_manage/free_board_edit/free_board_edit_controller.dart';

class FreeBoardEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FreeBoardEditController());
  }
}

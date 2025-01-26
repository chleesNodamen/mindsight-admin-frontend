import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_edit/practice_edit_controller.dart';
import 'package:mindsight_admin_page/presentation/faq_board_manage/faq_board_edit/faq_edit_controller.dart';
import 'package:mindsight_admin_page/presentation/free_board_manage/free_board_edit/free_board_edit_controller.dart';
import 'package:mindsight_admin_page/presentation/notice_board_manage/notice_board_edit/notice_edit_controller.dart';

class FAQBoardEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FAQBoardEditController());
  }
}

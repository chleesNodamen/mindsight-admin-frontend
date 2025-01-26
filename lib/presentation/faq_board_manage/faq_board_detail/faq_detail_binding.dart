import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/faq_board_manage/faq_board_detail/faq_detail_controller.dart';
import 'package:mindsight_admin_page/presentation/notice_board_manage/notice_board_detail/notice_detail_controller.dart';

class FAQBoardDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FAQBoardDetailController());
  }
}

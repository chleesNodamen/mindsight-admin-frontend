import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/notice_board_manage/notice_board_detail/notice_detail_controller.dart';

class NoticeBoardDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoticeBoardDetailController());
  }
}

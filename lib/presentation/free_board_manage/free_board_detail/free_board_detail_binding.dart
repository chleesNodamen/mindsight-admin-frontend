import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_details/practice_details_controller.dart';
import 'package:mindsight_admin_page/presentation/free_board_manage/free_board_detail/free_board_detail_controller.dart';

class FreeBoardDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FreeBoardDetailController());
  }
}

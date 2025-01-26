import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/inquiry_board_manage/inquiry_board_manage_controller.dart';

class InquiryBoardManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InquiryBoardManageController());
  }
}

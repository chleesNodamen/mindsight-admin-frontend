import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/inquiry_board_manage/inquiry_board_register/inquiry_board_register_controller.dart';

class InquiryBoardRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InquiryBoardRegisterController());
  }
}

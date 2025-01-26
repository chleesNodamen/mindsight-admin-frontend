import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/faq_board_manage/faq_board_register/faq_register_controller.dart';

class FAQBoardRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FAQBoardRegisterController());
  }
}

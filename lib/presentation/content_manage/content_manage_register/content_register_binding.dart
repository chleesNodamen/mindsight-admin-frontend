import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_register/content_register_controller.dart';

class ContentRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContentRegisterController());
  }
}

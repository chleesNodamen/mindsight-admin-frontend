import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/verify_email/verify_email2_controller.dart';

class VerifyEmail2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyEmail2Controller());
  }
}

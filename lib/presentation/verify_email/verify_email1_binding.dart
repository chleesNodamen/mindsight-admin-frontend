import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/verify_email/verify_email1_controller.dart';

class VerifyEmail1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyEmail1Controller());
  }
}

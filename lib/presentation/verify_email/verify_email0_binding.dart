import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/verify_email/verify_email0_controller.dart';

class VerifyEmail0Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyEmail0Controller());
  }
}

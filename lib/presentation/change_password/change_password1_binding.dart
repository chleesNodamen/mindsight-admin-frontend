import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/change_password/change_password0_controller.dart';
import 'package:mindsight_admin_page/presentation/change_password/change_password1_controller.dart';

class ChangePassword1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePassword1Controller());
  }
}

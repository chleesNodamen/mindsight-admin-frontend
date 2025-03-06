import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/change_password/change_password0_controller.dart';

class ChangePassword0Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePassword0Controller());
  }
}

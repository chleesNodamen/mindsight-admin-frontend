import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_register/master_register_controller.dart';

class MasterRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MasterRegisterController());
  }
}

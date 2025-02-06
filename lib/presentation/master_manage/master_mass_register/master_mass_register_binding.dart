import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_mass_register/master_mass_register_controller.dart';

class MasterMassRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MasterMassRegisterController());
  }
}

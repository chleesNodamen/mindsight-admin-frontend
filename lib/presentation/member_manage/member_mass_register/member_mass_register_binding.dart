import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_mass_register/member_mass_register_controller.dart';

class MemberMassRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberMassRegisterController());
  }
}

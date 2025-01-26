import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_mass_register/company_mass_register_controller.dart';

class CompanyMassRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyMassRegisterController());
  }
}

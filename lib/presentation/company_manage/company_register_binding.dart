import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_register_controller.dart';

class CompanyRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyRegisterController());
  }
}

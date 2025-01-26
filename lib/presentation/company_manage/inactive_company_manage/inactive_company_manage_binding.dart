import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/company_manage/inactive_company_manage/inactive_company_manage_controller.dart';

class InactiveCompanyManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InactiveCompanyManageController());
  }
}

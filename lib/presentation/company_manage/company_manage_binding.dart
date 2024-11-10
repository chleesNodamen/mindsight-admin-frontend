import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_manage_controller.dart';

class CompanyManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyManageController());
  }
}

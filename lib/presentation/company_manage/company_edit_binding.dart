import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_edit_controller.dart';

class CompanyEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyEditController());
  }
}

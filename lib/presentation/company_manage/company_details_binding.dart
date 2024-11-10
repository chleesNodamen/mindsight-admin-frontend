import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_details_controller.dart';

class CompanyDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyDetailsController());
  }
}

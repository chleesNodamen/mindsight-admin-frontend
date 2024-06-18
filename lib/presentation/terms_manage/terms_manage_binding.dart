import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/terms_manage/terms_manage_controller.dart';

class TermsManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsManageController());
  }
}
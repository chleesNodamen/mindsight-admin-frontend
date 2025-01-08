import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/revenue_share_manage_controller_nouse.dart';

class RevenueShareManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RevenueShareManageController());
  }
}

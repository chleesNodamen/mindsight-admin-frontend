import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/settlement_manage_controller.dart';

class SettlementManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettlementManageController());
  }
}

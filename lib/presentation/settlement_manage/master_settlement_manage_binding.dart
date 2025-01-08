import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/master_settlement_manage_controller.dart';

class MasterSettlementManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MasterSettlementManageController());
  }
}

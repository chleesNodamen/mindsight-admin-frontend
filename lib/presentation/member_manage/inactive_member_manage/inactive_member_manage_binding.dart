import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/member_manage/inactive_member_manage/inactive_member_manage_controller.dart';

class InactiveMemberManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InactiveMemberManageController());
  }
}

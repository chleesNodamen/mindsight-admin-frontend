import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage_controller.dart';

class MemberManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberManageController());
  }
}
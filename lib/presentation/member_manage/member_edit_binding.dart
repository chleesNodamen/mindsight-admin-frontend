import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_edit_controller.dart';

class MemberEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberEditController());
  }
}
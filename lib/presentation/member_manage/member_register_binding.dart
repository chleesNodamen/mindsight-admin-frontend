import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_register_controller.dart';

class MemberRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberRegisterController());
  }
}

import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_details_controller.dart';

class MemberDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberDetailsController());
  }
}
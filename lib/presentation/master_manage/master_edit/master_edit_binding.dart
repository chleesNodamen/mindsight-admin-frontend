import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_edit/master_edit_controller.dart';

class MasterEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MasterEditController());
  }
}

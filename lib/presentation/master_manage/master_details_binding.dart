import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_details_controller.dart';

class MasterDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MasterDetailsController());
  }
}

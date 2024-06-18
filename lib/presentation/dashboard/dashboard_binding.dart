import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}
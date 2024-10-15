import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/controllers/menu_controller.dart'
    as menu_controller;

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.put(CustomHttpClient());
    Get.put(menu_controller.MenuController());
    Get.put(NavigationController());
  }
}

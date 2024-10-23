import 'package:mindsight_admin_page/app_export.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.put(CustomHttpClient());
    Get.put(SideMenuController());
    // Get.put(NavigationController());
  }
}

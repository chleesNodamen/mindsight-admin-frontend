import 'package:mindsight_admin_page/app_export.dart';

class AdminSettingsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }
}
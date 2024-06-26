import 'package:mindsight_admin_page/app_export.dart';

enum Type { practice, challenge }

class ActivityHistoryController extends GetxController {
  static ActivityHistoryController get to => Get.find<ActivityHistoryController>();
  final Type type = Type.practice;
  final bool chatBot = true;
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }
}
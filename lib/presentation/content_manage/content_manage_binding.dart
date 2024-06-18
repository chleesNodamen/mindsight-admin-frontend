import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_controller.dart';

class ContentManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContentManageController());
  }
}
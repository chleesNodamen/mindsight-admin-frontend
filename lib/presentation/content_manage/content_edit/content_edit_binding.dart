import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_edit/content_edit_controller.dart';

class ContentEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContentEditController());
  }
}

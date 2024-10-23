import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_details/content_details_controller.dart';

class ContentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContentDetailsController());
  }
}

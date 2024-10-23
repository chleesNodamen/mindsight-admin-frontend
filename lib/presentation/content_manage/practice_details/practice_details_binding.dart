import 'package:get/get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_details/practice_details_controller.dart';

class PracticeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PracticeDetailsController());
  }
}

import 'package:mindsight_admin_page/app_export.dart';

class ContentManageController extends GetxController {
  static ContentManageController get to => Get.find<ContentManageController>();
  RxList<bool> checkboxValues = List<bool>.filled(12, false).obs;
  RxBool showMore = false.obs;
}

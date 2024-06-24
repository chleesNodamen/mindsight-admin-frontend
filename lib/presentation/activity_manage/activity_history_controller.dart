import 'package:mindsight_admin_page/app_export.dart';

enum Type { practice, challenge }

class ActivityHistoryController extends GetxController {
  static ActivityHistoryController get to => Get.find<ActivityHistoryController>();
  final Type type = Type.practice;
  final bool chatBot = true;
}
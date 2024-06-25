import 'package:mindsight_admin_page/app_export.dart';

class InactiveMemberManageController extends GetxController {
  static InactiveMemberManageController get to => Get.find<InactiveMemberManageController>();
  List<String> membershipLabels = [
    "Nodamen",
    "UNHCR",
    "UN Women",
  ];
  RxInt activePage = 1.obs;
  RxList<bool> membershipValues = List<bool>.filled(3, true).obs;
  void toggleMembership(int index, bool value) {
    membershipValues[index] = value;
  }

  void loadNewPage(int pageNum) {
    activePage.value = pageNum;
  }

  void onMemberTap() {
    menuController.changeActiveItemTo(activityHistoryPageDisplayName);
    navigationController.navigateTo(activityHistoryPageRoute);
  }
}

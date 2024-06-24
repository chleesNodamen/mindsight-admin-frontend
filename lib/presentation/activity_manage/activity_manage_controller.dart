import 'package:mindsight_admin_page/app_export.dart';

enum Type { practice, challenge }

class ActivityManageController extends GetxController {
  static ActivityManageController get to => Get.find<ActivityManageController>();
 //  FIRST CONTAINER //
  List<String> typeLabels = [
    "Practice plan",
    "Challenge",
  ];
  // Initial list of checkbox labels
  List<String> membershipLabels = [
    "Nodamen",
    "UNHCR",
    "UN Women",
  ];
  // List of additional checkbox labels
  List<String> chatbotLabels = [
    "있음",
    "없음",
  ];
  List<String> feedbackLabels = [
    "안함",
    "완료",
  ];

  // Initial list of checkbox values
  RxList<bool> membershipValues = List<bool>.filled(3, true).obs;
  RxBool showMore = false.obs;
  RxBool isChecked = true.obs;
  RxList<bool> chatbotValues = List<bool>.filled(2, true).obs;
  RxList<bool> feedbackValues = List<bool>.filled(2, true).obs;
  Rx<Type> type = Type.practice.obs;
  RxInt activePage = 1.obs;

  void toggleMembership(int index, bool value) {
    membershipValues[index] = value;
  }

  void toggleChatbot(int index, bool value) {
    chatbotValues[index] = value;
  }
  void toggleFeedback(int index, bool value) {
    feedbackValues[index] = value;
  }

  void loadNewPage(int pageNum){
    activePage.value = pageNum;
  }

  void onHistoryTap(){

                          menuController.changeActiveItemTo(activityHistoryPageDisplayName);
                          navigationController.navigateTo(activityHistoryPageRoute);

                      
  }
}

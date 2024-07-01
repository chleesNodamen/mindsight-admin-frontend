import 'package:mindsight_admin_page/app_export.dart';

class ChallengeManageController extends GetxController {
  static ChallengeManageController get to =>
      Get.find<ChallengeManageController>();

  //  FIRST CONTAINER //

  // Initial list of checkbox labels
  RxList<String> checkboxLabels = [
    "Improve health",
    "Relaxing stretching",
    "Welness at work",
    "Regulate emotions",
    "Fall asleep easily",
  ].obs;

  // List of additional checkbox labels
  List<String> periodLabels = ["7일", "14일", "21일", "30일"];
  RxList<bool> periodValues = List<bool>.filled(4, true).obs;
  // Initial list of checkbox values
  RxList<bool> checkboxValues = List<bool>.filled(5, true).obs;

  RxBool showMore = false.obs;
  RxBool isChecked = true.obs;
  RxList<bool> secondCheckboxValues = List<bool>.filled(2, true).obs;

  void toggleCheckbox(int index, bool value) {
    checkboxValues[index] = value;
  }

  void toggleSecondCheckbox(int index, bool value) {
    secondCheckboxValues[index] = value;
  }

  //DROPDOWN BUTTON
  RxString selectedOrder = '등록순'.obs;
  void updateSelectedOrder(String newOrder) {
    selectedOrder.value = newOrder;
  }

  //DATA TABLE
  RxString dataTableButtonText = '정상'.obs;
  void updateDTText(String newText) {
    dataTableButtonText.value = newText;
  }

  RxInt activePage = 1.obs;
  void loadNewPage(int pageNum) {
    activePage.value = pageNum;
  }

  var data = [].obs;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
    isLoading.value = false;
    isInited.value = true;
  }

  RxBool selected = false.obs;
  void updateValue() {
    selected.value = !selected.value;
  }

  void fetchData() async {
    try {
      isLoading(true);
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      var fetchedData = [
        {
          "type": "Improve health",
          "title": "7-Day Challenge to Strengthen Your Legs",
          "views": "999,999",
          "likes": "9,999",
          "preview": "9,999",
          "status": "정상"
        },
        {
          "type": "Improve health",
          "title": "7-Day Challenge to Strengthen Your Legs",
          "views": "999,999",
          "likes": "9,999",
          "preview": "9,999",
          "status": "정상"
        },
        {
          "type": "Improve health",
          "title": "7-Day Challenge to Strengthen Your Legs",
          "views": "999,999",
          "likes": "9,999",
          "preview": "9,999",
          "status": "정상"
        },
        // Add more items as needed
      ];
      data.assignAll(fetchedData);
    } finally {
      isLoading(false);
    }
  }

  void goToEdit() {
    Get.toNamed(AppRoutes.challengeDetails);
  }
}

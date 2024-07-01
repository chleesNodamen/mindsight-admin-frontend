import 'package:mindsight_admin_page/app_export.dart';

class PracticePlanManageController extends GetxController {
  static PracticePlanManageController get to =>
      Get.find<PracticePlanManageController>();

//REGISTER BUTTON
  void onRegisterTap() {
    Get.toNamed(AppRoutes.practiceRegister);
  }

  //DROPDOWN BUTTON
  RxString selectedOrder = '회차순'.obs;
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
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
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
          "level": "1회차",
          "completed": "3,456",
          "participated": "9,999",
          "ratio": "99,9%",
          "likes": "9,999",
        },
        {
          "level": "1회차",
          "completed": "3,456",
          "participated": "9,999",
          "ratio": "99,9%",
          "likes": "9,999",
        },
        {
          "level": "1회차",
          "completed": "3,456",
          "participated": "9,999",
          "ratio": "99,9%",
          "likes": "9,999",
        },
        // Add more items as needed
      ];
      data.assignAll(fetchedData);
    } finally {
      isLoading(false);
    }
  }
}

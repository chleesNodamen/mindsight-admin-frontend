import 'package:mindsight_admin_page/app_export.dart';

class PracticeRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }

  void goToEdit() {
    Get.toNamed(AppRoutes.challengeEdit);
  }

  var data = [].obs; // Your data list
  var selected = false.obs; // Selection state
  var activePage = 1.obs; // Active page state

  // Method to update the value
  void updateValue() {
    selected.value = !selected.value;
  }

  // Method to load new data for the page
  void loadNewPage(int pageNum) {
    activePage.value = pageNum;
    // Fetch new data based on the page number
  }

  // Method to simulate data fetch
  void fetchData() {
    data.value = [
      {'type': 'Type A', 'title': 'Title A', 'status': 'Active'},
      {'type': 'Type B', 'title': 'Title B', 'status': 'Inactive'},
      // Add more data as needed
    ];
  }
}

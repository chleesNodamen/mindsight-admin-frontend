import 'package:mindsight_admin_page/app_export.dart';

class SubAdminSettingsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
    isLoading.value = false;
    isInited.value = true;
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

  RxBool selected = false.obs;
  void updateValue() {
    selected.value = !selected.value;
  }

  void onRegisterTap() {
    Get.toNamed(AppRoutes.subAdminRegister);
  }

  void fetchData() async {
    try {
      isLoading(true);
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      var fetchedData = [
        {
          "email": "ms_content@nodamen.com",
          "department": "Mindsight Content Dept.",
          "id": "이진아",
          "role": "마스터 (변경불가)",
        },
        {
          "email": "ms_content@nodamen.com",
          "department": "Mindsight Content Dept.",
          "id": "이진아",
          "role": "마스터 (변경불가)",
        },
        {
          "email": "ms_content@nodamen.com",
          "department": "Mindsight Content Dept.",
          "id": "이진아",
          "role": "마스터 (변경불가)",
        },
        {
          "email": "ms_content@nodamen.com",
          "department": "Mindsight Content Dept.",
          "id": "이진아",
          "role": "마스터 (변경불가)",
        },
      ];
      data.assignAll(fetchedData);
    } finally {
      isLoading(false);
    }
  }

  void goToEdit() {
    Get.toNamed(AppRoutes.subAdminDetails);
  }
}

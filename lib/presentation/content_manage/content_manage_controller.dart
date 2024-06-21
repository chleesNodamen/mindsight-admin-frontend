import 'package:mindsight_admin_page/app_export.dart';

class ContentManageController extends GetxController {
  static ContentManageController get to => Get.find<ContentManageController>();

  //  FIRST CONTAINER //

  // Initial list of checkbox labels
  RxList<String> checkboxLabels = [
    "Basic body",
    "Intermediate body",
    "Advance body",
    "Relax breathing",
    "Focus breathing",
    "Energy breathing",
    "Nature breathing",
    "Guided breathing"
  ].obs;

  // List of additional checkbox labels
  List<String> additionalCheckboxLabels = [
    "Mindful Art",
    "Art with music",
    "Nature",
    "K-ASMR"
  ];

  // Initial list of checkbox values
  RxList<bool> checkboxValues = List<bool>.filled(8, true).obs;
  RxBool showMore = false.obs;
  RxBool isChecked = true.obs;
  RxList<bool> secondCheckboxValues = List<bool>.filled(2, true).obs;

  void toggleCheckbox(int index, bool value) {
    checkboxValues[index] = value;
  }

  void toggleSecondCheckbox(int index, bool value) {
    secondCheckboxValues[index] = value;
  }

  void addMoreCheckboxes() {
    if (showMore.value) {
      checkboxLabels.addAll(additionalCheckboxLabels);
      checkboxValues
          .addAll(List<bool>.filled(additionalCheckboxLabels.length, true));
    } else {
      checkboxLabels.removeRange(8, checkboxLabels.length);
      checkboxValues.removeRange(8, checkboxValues.length);
    }
  }

  //DROPDOWN BUTTON
  RxString selectedOrder = '등록순'.obs;
  void updateSelectedOrder(String newOrder) {
    selectedOrder.value = newOrder;
  }
}

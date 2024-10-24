import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_model.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_req_get.dart';
import 'package:mindsight_admin_page/data/practices_data/practices_data_model.dart';
import 'package:mindsight_admin_page/data/practices_data/practices_data_repository.dart';
import 'package:mindsight_admin_page/data/practices_data/practices_data_req_post.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_manage/practice_manage_controller.dart';

class PracticeRegisterController extends GetxController {
  RxBool fetchedData = false.obs;

  late ContentListModel contentListModel;
  late PracticesDataModel practicesDataModel;

  final TextEditingController textController = TextEditingController();

  var selectedIndex = (-1).obs; // Initialize with -1 indicating no selection
  RxString selectedBodyName = "".obs;
  String selectedBodyId = "";
  RxString selectedBreathName = "".obs;
  String selectedBreathId = "";

  List<String> contentType = [];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
    // loadData();
  }

  // Future<void>initData() async {
  //   isLoading.value = true;
  //   isInited.value = false;
  //   isLoading.value = false;
  //   isInited.value = true;
  // }

  void goToEdit() {
    Get.offAllNamed(AppRoutes.challengeEdit);
  }

  var data = [].obs;
  var selected = false.obs;
  var activePage = 1.obs;

  // Method to update the value
  // void updateBodyValue(int index) {
  //   selectedContent[index] = !selectedContent[index];
  // }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  // Method to load new data for the page
  Future<void> loadNewPage(int pageNum) async {
    selectedIndex.value = (-1);

    isLoading.value = true;
    contentListModel = await ContentListRepository().get(ContentListReqGet(
      page: pageNum,
      type: contentType,
      search: textController.text,
      status: true,
      pageSize: 5,
    ));

    activePage.value = pageNum;
    isLoading.value = false;
  }

  // Method to simulate data fetch
  Future<void> fetchBodyData(String? search) async {
    selectedIndex.value = (-1);
    contentType = [
      "Basic body",
      "Intermediate body",
      "Advance body",
    ];

    contentListModel = await ContentListRepository().get(ContentListReqGet(
      page: 1,
      type: contentType,
      search: textController.text,
      pageSize: 5,
      status: true,
    ));

    fetchedData.value = true;
  }

  Future<void> fetchBreathData(String? search) async {
    selectedIndex.value = (-1);
    contentType = [
      "Relax breathing",
      "Focus breathing",
      "Energy breathing",
      "Nature breathing",
      "Guided breathing"
    ];

    contentListModel = await ContentListRepository().get(ContentListReqGet(
      page: 1,
      type: contentType,
      search: textController.text,
      pageSize: 5,
      status: true,
    ));

    fetchedData.value = true;
  }

  void goToPractice() {
    Get.offAllNamed(AppRoutes.contentPracticeManage);
  }

  void resetData() {
    contentListModel = ContentListModel();
    contentType = [];
    fetchedData.value = false;
    selected.value = false;
    activePage.value = 1;
    textController.clear();
  }

  void onBodyButtonPressed() {
    selectedBodyName.value = contentListModel.name![selectedIndex.value];
    selectedBodyId = contentListModel.id![selectedIndex.value];
  }

  void onBreathButtonPressed() {
    selectedBreathName.value = contentListModel.name![selectedIndex.value];
    selectedBreathId = contentListModel.id![selectedIndex.value];
  }

  Future<void> saveChanges() async {
    practicesDataModel = await PracticesDataRepository().post(
        PracticesDataReqPost(
            bodyId: selectedBodyId, breathId: selectedBreathId));
    if (practicesDataModel.isSuccess) {
      Get.offAllNamed(AppRoutes.contentPracticeManage);
    }
  }
}

//   RxBool isLoading = true.obs;
//   RxBool isInited = false.obs;
//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     isLoading.value = false;
//     isInited.value = true;
//   }

//   void goToEdit() {
//     Get.offAllNamed(AppRoutes.challengeEdit);
//   }

//   var data = [].obs; // Your data list
//   var selected = false.obs; // Selection state
//   var activePage = 1.obs; // Active page state

//   // Method to update the value
//   void updateValue() {
//     selected.value = !selected.value;
//   }

//   // Method to load new data for the page
//   void loadNewPage(int pageNum) {
//     activePage.value = pageNum;
//     // Fetch new data based on the page number
//   }

//   // Method to simulate data fetch
//   void fetchData() {
//     data.value = [
//       {'type': 'Type A', 'title': 'Title A', 'status': 'Active'},
//       {'type': 'Type B', 'title': 'Title B', 'status': 'Inactive'},
//       // Add more data as needed
//     ];
//   }
// }

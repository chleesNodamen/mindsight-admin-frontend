import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_model.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_req_get.dart';
import 'package:mindsight_admin_page/data/practice_details/practice_details_model.dart';
import 'package:mindsight_admin_page/data/practice_details/practice_details_repository.dart';
import 'package:mindsight_admin_page/data/practice_edit/practice_edit_model.dart';
import 'package:mindsight_admin_page/data/practice_edit/practice_edit_repository.dart';
import 'package:mindsight_admin_page/data/practice_edit/practice_edit_req_put.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_details/practice_details_controller.dart';

class PracticeEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool fetchedData = false.obs;

  late ContentListModel contentListModel;
  late PracticeDetailsModel practiceDetailsModel;
  late PracticeEditModel practiceEditModel;

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
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;

    if (AppConstant.chleesTest) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.chleesTestEmail,
          password: AppConstant.chleesTestPassword));
    }
    if (AppConstant.chleesTest) {
      practiceDetailsModel = await PracticeDetailsRepository().get(id);
    }
    if (practiceDetailsModel.isSuccess) {
      selectedBodyName.value = practiceDetailsModel.body!;
      selectedBreathName.value = practiceDetailsModel.breath!;
      // print("initialized");
    }
    isLoading.value = false;
    isInited.value = true;
  }

  void goToEdit() {
    Get.toNamed(AppRoutes.challengeEdit);
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
    if (AppConstant.chleesTest) {
      isLoading.value = true;
      contentListModel = await ContentListRepository().get(ContentListReqGet(
        page: pageNum,
        type: contentType,
        search: textController.text,
        status: true,
        pageSize: 5,
      ).toJson());
    }
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
    if (AppConstant.chleesTest) {
      contentListModel = await ContentListRepository().get(ContentListReqGet(
        page: 1,
        type: contentType,
        search: textController.text,
        pageSize: 5,
        status: true,
      ).toJson());
    }
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
    if (AppConstant.chleesTest) {
      contentListModel = await ContentListRepository().get(ContentListReqGet(
        page: 1,
        type: contentType,
        search: textController.text,
        pageSize: 5,
        status: true,
      ).toJson());
    }
    fetchedData.value = true;
  }

  void goToPractice() {
    Get.toNamed(AppRoutes.contentPracticePlanManage);
  }

  void goToDetails() {
    Get.toNamed(AppRoutes.practiceDetails, arguments: {RouteArguments.id: id});
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
    practiceEditModel = await PracticeEditRepository().put(
        id,
        PracticeEditReqPut(bodyId: selectedBodyId, breathId: selectedBreathId)
            .toJson());
    if (practiceEditModel.isSuccess) {
      if (Get.isRegistered<PracticeDetailsController>()) {
        Get.delete<PracticeDetailsController>();
      }
      Get.toNamed(AppRoutes.practiceDetails,
          arguments: {RouteArguments.id: id});
    }
  }
}

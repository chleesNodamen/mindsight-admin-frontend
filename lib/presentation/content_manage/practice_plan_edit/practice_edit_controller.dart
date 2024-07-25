import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_model.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_req_get.dart';
import 'package:mindsight_admin_page/data/practice_details/practice_details_model.dart';
import 'package:mindsight_admin_page/data/practice_details/practice_details_repository.dart';
import 'package:mindsight_admin_page/data/practices/practices_model.dart';

class PracticeEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool fetchedData = false.obs;
  late ContentListModel contentListModel;
  late PracticeDetailsModel practiceDetailsModel;
  // contentListModel = await ContentListRepository().get(id);
  final TextEditingController textController = TextEditingController();
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
      practiceDetailsModel = await PracticeDetailsRepository().get(id);
    }
    if (practiceDetailsModel.isSuccess) {
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
  void updateValue() {
    selected.value = !selected.value;
  }

  // Method to load new data for the page
  void loadNewPage(int pageNum) {
    activePage.value = pageNum;
  }

  // Method to simulate data fetch
  Future<void> fetchBodyData(String? search) async {
    if (AppConstant.chleesTest) {
      contentListModel = await ContentListRepository().get(ContentListReqGet(
        page: 1,
        type: [
          "Basic body",
          "Intermediate body",
          "Advance body",
        ],
        search: textController.text,
        pageSize: 5,
        status: true,
      ).toJson());
    }
    fetchedData.value = true;
  }

  Future<void> fetchBreathData(String? search) async {
    if (AppConstant.chleesTest) {
      contentListModel = await ContentListRepository().get(ContentListReqGet(
        page: 1,
        type: [
          "Relax breathing",
          "Focus breathing",
          "Energy breathing",
          "Nature breathing",
          "Guided breathing"
        ],
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
    fetchedData.value = false;
    selected.value = false;
    activePage.value = 1;
    textController.clear();
  }
}

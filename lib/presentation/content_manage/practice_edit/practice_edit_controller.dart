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

class PracticeEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool fetchedData = false.obs;

  late ContentListModel contentListModel;
  late PracticeDetailsModel practiceDetailsModel;
  late PracticeEditModel practiceEditModel;

  final TextEditingController textController = TextEditingController();

  var selectedIndex = (-1).obs; // Initialize with -1 indicating no selection
  RxString selectedBodyName = "".obs;
  String? selectedBodyId;
  RxString selectedBreathName = "".obs;
  String? selectedBreathId;

  List<String> contentType = [];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  RxInt activePage = 1.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;
    isInited.value = false;

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    practiceDetailsModel = await PracticeDetailsRepository().get(id);

    if (practiceDetailsModel.isSuccess) {
      selectedBodyName.value = practiceDetailsModel.body!;
      selectedBreathName.value = practiceDetailsModel.breath!;
      // print("initialized");
    }
    isLoading.value = false;
    isInited.value = true;
  }

  void onEdit() {
    Get.offAllNamed(AppRoutes.challengeEdit);
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

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

  Future<void> fetchBodyData(String? search) async {
    Logger.info("바디");

    selectedIndex.value = (-1);
    contentType = [
      "Basic body",
      "Intermediate body",
      "Advance body",
    ];

    isLoading.value = true;
    fetchedData.value = false;

    contentListModel = await ContentListRepository().get(ContentListReqGet(
      page: 1,
      type: contentType,
      search: textController.text,
      pageSize: 5,
      status: true,
    ));

    isLoading.value = false;
    fetchedData.value = true;
  }

  Future<void> fetchBreathData(String? search) async {
    Logger.info("fetchBreathData");

    selectedIndex.value = (-1);
    contentType = [
      "Relax breathing",
      "Focus breathing",
      "Energy breathing",
      "Nature breathing",
      "Guided breathing"
    ];

    isLoading.value = true;
    fetchedData.value = false;

    contentListModel = await ContentListRepository().get(ContentListReqGet(
      page: 1,
      type: contentType,
      search: textController.text,
      pageSize: 5,
      status: true,
    ));

    isLoading.value = false;
    fetchedData.value = true;
  }

  void onDetails() {
    Get.offAllNamed(AppRoutes.practiceDetails,
        arguments: {RouteArguments.id: id});
  }

  Future<void> initSearchDialogData(bool isBody) async {
    contentListModel = ContentListModel();
    contentType = [];
    fetchedData.value = false;
    activePage.value = 1;
    textController.clear();

    if (isBody) {
      await fetchBodyData(textController.text);
    } else {
      await fetchBreathData(textController.text);
    }
  }

  void onBodyButtonPressed() {
    selectedBodyName.value = contentListModel.name![selectedIndex.value];
    selectedBodyId = contentListModel.id![selectedIndex.value];
  }

  void onBreathButtonPressed() {
    selectedBreathName.value = contentListModel.name![selectedIndex.value];
    selectedBreathId = contentListModel.id![selectedIndex.value];
  }

  Future<void> onSave() async {
    practiceEditModel = await PracticeEditRepository().put(id,
        PracticeEditReqPut(bodyId: selectedBodyId, breathId: selectedBreathId));
    if (practiceEditModel.isSuccess) {
      Get.offAllNamed(AppRoutes.practiceDetails,
          arguments: {RouteArguments.id: id});
    } else {
      showSimpleMessage(Get.context!, "저장에 실패 하였습니다");
    }
  }
}

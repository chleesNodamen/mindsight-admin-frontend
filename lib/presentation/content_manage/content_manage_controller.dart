import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/content_delete/content_delete_model.dart';
import 'package:mindsight_admin_page/data/content_delete/content_delete_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_model.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_req_get.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_model.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_repository.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_req_put.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_details/content_details_controller.dart';

class ContentManageController extends GetxController {
  RxMap<String, bool> selectedIds = <String, bool>{}.obs;

  RxBool showMore = false.obs;

  var data = [].obs;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  RxList<bool> selectedContent = List.generate(20, (_) => false).obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

  Rx<ContentListModel> contentListModel = ContentListModel().obs;
  late ContentStatusModel contentStatusModel;
  late ContentDeleteModel contentDeleteModel;
  RxList<bool>? contentState;

  RxList<String> bodyLabels = [
    "Basic body",
    "Intermediate body",
    "Advance body",
  ].obs;
  RxList<String> breathingLabels = [
    // "Relax breathing",
    // "Focus breathing",
    // "Energy breathing",
    "Nature breathing",
    "Guided meditation"
  ].obs;
  List<String> otherLabels = [
    "Mindful Art",
    "Art with music",
    "Nature",
    "K-ASMR"
  ];

  RxList<bool> bodyValues = List<bool>.filled(3, true).obs;
  RxList<bool> breathingValues = List<bool>.filled(2, true).obs;
  RxList<bool> otherValues = List<bool>.filled(4, true).obs;
  RxList<bool> serviceValues = List<bool>.filled(2, true).obs;

  Future<void> toggleBodyCheckbox(int index, bool value) async {
    bodyValues[index] = value;
    isLoading.value = true;
    if (await loadNewData()) {
      activePage.value = 1;
      isLoading.value = false;
    }
  }

  Future<void> toggleBreathingCheckbox(int index, bool value) async {
    breathingValues[index] = value;
    isLoading.value = true;
    if (await loadNewData()) {
      activePage.value = 1;
      isLoading.value = false;
    }
  }

  Future<void> toggleOtherCheckbox(int index, bool value) async {
    otherValues[index] = value;
    isLoading.value = true;
    if (await loadNewData()) {
      activePage.value = 1;
      isLoading.value = false;
    }
  }

  Future<void> toggleServiceValues(int index, bool value) async {
    //정상, 서비스 안함
    serviceValues[index] = value;
    isLoading.value = true;
    if (await loadNewData()) {
      activePage.value = 1;
      isLoading.value = false;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    loadData();
  }

  //DROPDOWN BUTTON
  RxString selectedOrder = '등록순'.obs;
  Future<void> updateSelectedOrder(String newOrder) async {
    selectedOrder.value = newOrder;
    isLoading.value = true;
    if (await loadNewData()) {
      activePage.value = 1;
      isLoading.value = false;
    }
  }

  Future<bool> loadNewData() async {
    searchOn.value = false;
    searchValue.value = "";
    selectedContent = List.generate(20, (_) => false).obs;
    if (bodyValues.every((element) => element == false) &&
            breathingValues.every((element) => element == false) &&
            otherValues.every((element) => element == false) ||
        serviceValues.every((element) => element == false)) {
      contentListModel.value = ContentListModel().copyWith(
        id: null,
        type: null,
        name: null,
        seen: null,
        liked: null,
        status: null,
        total: 0,
      );
      return true;
    }
    List<String> chosenTypes = bodyValues.every((a) => a == true) &&
            breathingValues.every((a) => a == true) &&
            otherValues.every((a) => a == true)
        ? []
        : [
            for (int i = 0; i < bodyLabels.length; i++)
              if (bodyValues[i]) bodyLabels[i],
            for (int i = 0; i < otherLabels.length; i++)
              if (otherValues[i]) otherLabels[i],
            for (int i = 0; i < breathingLabels.length; i++)
              if (breathingValues[i]) breathingLabels[i],
          ];
    contentListModel.value =
        await ContentListRepository().get(ContentListReqGet(
      type: chosenTypes,
      page: 1,
      status: serviceValues.contains(false) ? serviceValues[0] : null,
      sortBy: selectedOrder.value,
      pageSize: 20,
    ));
    contentState =
        (contentListModel.value.status!.map((status) => status).toList()).obs;
    return contentListModel.value.isSuccess;
  }

  //DATA TABLE
  RxString dataTableButtonText = '정상'.obs;
  void updateDTText(String newText) {
    dataTableButtonText.value = newText;
  }

  RxInt activePage = 1.obs;

  Future<void> loadNewPage(int pageNum) async {
    selectedContent = List.generate(20, (_) => false).obs;
    List<String> chosenTypes = bodyValues.every((a) => a == true) &&
            breathingValues.every((a) => a == true) &&
            otherValues.every((a) => a == true)
        ? []
        : [
            for (int i = 0; i < bodyLabels.length; i++)
              if (bodyValues[i]) bodyLabels[i],
            for (int i = 0; i < otherLabels.length; i++)
              if (otherValues[i]) otherLabels[i],
            for (int i = 0; i < breathingLabels.length; i++)
              if (breathingValues[i]) breathingLabels[i],
          ];

    isLoading.value = true;
    contentListModel.value =
        await ContentListRepository().get(ContentListReqGet(
      type: chosenTypes,
      page: pageNum,
      search: searchOn.value == true ? searchValue.value : null,
      status: serviceValues.contains(false) ? serviceValues[0] : null,
      sortBy: selectedOrder.value,
      pageSize: 20,
    ));
    contentState =
        (contentListModel.value.status!.map((status) => status).toList()).obs;

    isLoading.value = false;
    activePage.value = pageNum;
    isLoading.value = false;
  }

  void updateValue(int index) {
    selectedContent[index] = !selectedContent[index];
  }

  Future<void> loadData() async {
    isLoading.value = true;

    searchOn.value = false;
    searchValue.value = "";
    bodyValues = List<bool>.filled(3, true).obs;
    breathingValues = List<bool>.filled(2, true).obs;
    otherValues = List<bool>.filled(4, true).obs;
    serviceValues = List<bool>.filled(2, true).obs;
    selectedContent = List.generate(20, (_) => false).obs;

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    contentListModel.value =
        await ContentListRepository().get(ContentListReqGet(
      page: 1,
      sortBy: selectedOrder.value,
      pageSize: 20,
    ));

    contentState = contentListModel.value.status!.obs;

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onStatusChange(int index) async {
    contentStatusModel = await ContentStatusRepository().put(
        ContentStatusReqPut(
            contentIds: [contentListModel.value.id![index]],
            status: contentState![index]));
  }

  Future<void> onStatusChangeForAll() async {
    List<String> contentIds = [
      for (int i = 0; i < selectedContent.length; i++)
        if (selectedContent[i]) contentListModel.value.id![i],
    ];
    List<bool> contentStatus = [
      for (int i = 0; i < selectedContent.length; i++)
        if (selectedContent[i]) contentState![i],
    ];
    List<String> positiveIds = [
      for (int i = 0; i < contentIds.length; i++)
        if (contentStatus[i]) contentIds[i],
    ];
    List<String> negativeIds = [
      for (int i = 0; i < contentIds.length; i++)
        if (!contentStatus[i]) contentIds[i],
    ];
    contentStatusModel = await ContentStatusRepository()
        .put(ContentStatusReqPut(contentIds: positiveIds, status: false));
    contentStatusModel = await ContentStatusRepository()
        .put(ContentStatusReqPut(contentIds: negativeIds, status: true));
    if (contentStatusModel.isSuccess) {
      selectedContent = List.generate(20, (_) => false).obs;
      loadNewPage(1);
    }
  }

  // SEARCH BAR

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;
    isLoading.value = true;
    selectedContent = List.generate(20, (_) => false).obs;
    List<String> chosenTypes = bodyValues.every((a) => a == true) &&
            breathingValues.every((a) => a == true) &&
            otherValues.every((a) => a == true)
        ? []
        : [
            for (int i = 0; i < bodyLabels.length; i++)
              if (bodyValues[i]) bodyLabels[i],
            for (int i = 0; i < otherLabels.length; i++)
              if (otherValues[i]) otherLabels[i],
            for (int i = 0; i < breathingLabels.length; i++)
              if (breathingValues[i]) breathingLabels[i],
          ];
    contentListModel.value =
        await ContentListRepository().get(ContentListReqGet(
      type: chosenTypes,
      page: 1,
      status: serviceValues.contains(false) ? serviceValues[0] : null,
      sortBy: selectedOrder.value,
      search: search,
      pageSize: 20,
    ));
    contentState =
        (contentListModel.value.status!.map((status) => status).toList()).obs;
    isLoading.value = false;
    activePage.value = 1;
  }

  Future<void> onDeleteButton() async {
    List<String> contentIds = [
      for (int i = 0; i < selectedContent.length; i++)
        if (selectedContent[i]) contentListModel.value.id![i],
    ];
    for (int i = 0; i < contentIds.length; i++) {
      contentDeleteModel =
          await ContentDeleteRepository().delete(contentIds[i]);
      if (contentDeleteModel.type != null) {
        Get.snackbar('Error',
            '${contentDeleteModel.type}으로 사용되는 콘텐츠 입니다. 삭제할 수 없습니다. ${contentDeleteModel.type}: ${contentDeleteModel.id}');
        await Future.delayed(const Duration(seconds: 3));
      }
    }
    loadNewPage(activePage.value);
  }

  void goToDetails(int index) {
    if (Get.isRegistered<ContentDetailsController>()) {
      Get.delete<ContentDetailsController>();
    }
    Get.offAllNamed(AppRoutes.contentDetails, arguments: {
      RouteArguments.id: Uri.encodeComponent(contentListModel.value.id![index])
    });
  }
}

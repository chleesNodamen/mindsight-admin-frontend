import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/content_delete/content_delete_model.dart';
import 'package:mindsight_admin_page/data/content_delete/content_delete_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_model.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_req_get.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_model.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_repository.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_req_put.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_details/content_details_controller.dart';

class ContentManageController extends GetxController {
  RxMap<String, bool> selectedIds = <String, bool>{}.obs;

  RxBool showMore = false.obs;

  var data = [].obs;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  RxList<bool> selectedContent = List.generate(20, (_) => false).obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

  late ContentListModel contentListModel;
  late ContentStatusModel contentStatusModel;
  late ContentDeleteModel contentDeleteModel;
  RxList<bool>? contentState;

  RxList<String> bodyLabels = [
    "Basic body",
    "Intermediate body",
    "Advance body",
  ].obs;
  RxList<String> breathingLabels = [
    "Relax breathing",
    "Focus breathing",
    "Energy breathing",
    "Nature breathing",
    "Guided breathing"
  ].obs;
  List<String> otherLabels = [
    "Mindful Art",
    "Art with music",
    "Nature",
    "K-ASMR"
  ];

  RxList<bool> bodyValues = List<bool>.filled(3, true).obs;
  RxList<bool> breathingValues = List<bool>.filled(5, true).obs;
  RxList<bool> otherValues = List<bool>.filled(4, true).obs;
  RxList<bool> serviceValues = List<bool>.filled(2, true).obs;

  void toggleBodyCheckbox(int index, bool value) {
    bodyValues[index] = value;
  }

  void toggleBreathingCheckbox(int index, bool value) {
    breathingValues[index] = value;
  }

  void toggleOtherCheckbox(int index, bool value) {
    otherValues[index] = value;
  }

  void toggleServiceValues(int index, bool value) {
    //정상, 서비스 안함
    serviceValues[index] = value;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    loadData();
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
    if (AppConstant.chleesTest) {
      isLoading.value = true;
      contentListModel = await ContentListRepository().get(ContentListReqGet(
        type: chosenTypes,
        page: pageNum,
        search: searchOn.value == true ? searchValue.value : null,
        status: serviceValues.contains(false) ? serviceValues[0] : null,
      ).toJson());
      contentState =
          (contentListModel.status!.map((status) => status).toList()).obs;
    }
    isLoading.value = false;
    activePage.value = pageNum;
    isLoading.value = false;
  }

  void updateValue(int index) {
    selectedContent[index] = !selectedContent[index];
  }

  void loadData() async {
    searchOn.value = false;
    searchValue.value = "";
    bodyValues = List<bool>.filled(3, true).obs;
    breathingValues = List<bool>.filled(5, true).obs;
    otherValues = List<bool>.filled(4, true).obs;
    serviceValues = List<bool>.filled(2, true).obs;
    selectedContent = List.generate(20, (_) => false).obs;
    if (AppConstant.chleesTest) {
      contentListModel = await ContentListRepository().get(ContentListReqGet(
        page: 1,
      ).toJson());
    } else {
      contentListModel = ContentListModel().copyWith(
        id: List.generate(10, (_) => ""),
        type: List.generate(10, (_) => 'Nodamen'),
        name: List.generate(10, (_) => 'akdlsemtkdlxm@nodamen.com'),
        seen: List.generate(10, (_) => 111),
        liked: List.generate(10, (_) => 111),
        status: List.generate(10, (_) => true),
        total: 10,
      );
      contentListModel.length = contentListModel.id!.length;
    }
    print("Content list initialized");
    contentState = contentListModel.status!.obs;
    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> onStatusChange(int index) async {
    contentStatusModel = await ContentStatusRepository().put(
        ContentStatusReqPut(
                contentIds: [contentListModel.id![index]],
                status: contentState![index])
            .toJson());
  }

  Future<void> onStatusChangeForAll() async {
    List<String> contentIds = [
      for (int i = 0; i < selectedContent.length; i++)
        if (selectedContent[i]) contentListModel.id![i],
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
    contentStatusModel = await ContentStatusRepository().put(
        ContentStatusReqPut(contentIds: positiveIds, status: false).toJson());
    contentStatusModel = await ContentStatusRepository().put(
        ContentStatusReqPut(contentIds: negativeIds, status: true).toJson());
    if (contentStatusModel.isSuccess) {
      selectedContent = List.generate(20, (_) => false).obs;
      loadNewPage(1);
    }
  }

  // SEARCH BAR

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;
    loadNewPage(activePage.value);
  }

  Future<void> onDeleteButton() async {
    List<String> contentIds = [
      for (int i = 0; i < selectedContent.length; i++)
        if (selectedContent[i]) contentListModel.id![i],
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
    Get.toNamed(AppRoutes.contentDetails, arguments: {
      RouteArguments.id: Uri.encodeComponent(contentListModel.id![index])
    });
  }
}

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/sort_condition.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/content_delete/content_delete_model.dart';
import 'package:mindsight_admin_page/data/content_delete/content_delete_repository.dart';
import 'package:mindsight_admin_page/data/content_exposure/content_exposure_repository.dart';
import 'package:mindsight_admin_page/data/content_exposure/content_exposure_req_put.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_model.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_req_get.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_repository.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_req_put.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';

class ContentManageController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  Rx<ContentListModel> contentListModel = ContentListModel().obs;
  late ContentDeleteModel contentDeleteModel;

  RxMap<String, bool> selectedIds = <String, bool>{}.obs;
  RxBool showMore = false.obs;

  RxList<bool> selectedContent = List.generate(20, (_) => false).obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

  RxList<ContentType> bodyLabels = [
    ContentType.basicBody,
    ContentType.intermediateBody,
    ContentType.advanceBody,
  ].obs;

  RxList<ContentType> breathingLabels =
      [ContentType.natureBreathing, ContentType.guidedMeditation].obs;

  List<ContentType> otherLabels = [
    ContentType.mindfulArt,
    ContentType.artWithMusic,
    ContentType.nature,
    ContentType.kAsmr
  ];

  List<ContentType> theoryLabels = [
    ContentType.emotionManagement,
    ContentType.philosophy,
    ContentType.selfDevelopment
  ];

  RxList<bool> bodyValues = List<bool>.filled(3, true).obs;
  RxList<bool> breathingValues = List<bool>.filled(2, true).obs;
  RxList<bool> otherValues = List<bool>.filled(4, true).obs;
  RxList<bool> theoryValues = List<bool>.filled(3, true).obs;
  RxList<bool> serviceValues = List<bool>.filled(2, true).obs;

  RxInt activePage = 1.obs;
  Rx<SortCondition?> selectedSort = SortCondition.registration.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    // await ReloadHandler.handleReload();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    await loadPage(1);

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> toggleBodyCheckbox(int index, bool value) async {
    bodyValues[index] = value;

    await loadPage(1);
  }

  Future<void> toggleBreathingCheckbox(int index, bool value) async {
    breathingValues[index] = value;

    await loadPage(1);
  }

  Future<void> toggleTheoryCheckbox(int index, bool value) async {
    theoryValues[index] = value;

    await loadPage(1);
  }

  Future<void> toggleOtherCheckbox(int index, bool value) async {
    otherValues[index] = value;

    await loadPage(1);
  }

  Future<void> toggleServiceValues(int index, bool value) async {
    serviceValues[index] = value;

    await loadPage(1);
  }

  Future<void> updateSelectedOrder(SortCondition newOrder) async {
    selectedSort.value = newOrder;

    await loadPage(1);
  }

  Future<void> loadPage(int pageNum) async {
    selectedContent = List.generate(20, (_) => false).obs;

    isLoading.value = true;

    contentListModel.value =
        await ContentListRepository().get(ContentListReqGet(
      type: getChosenType(),
      page: pageNum,
      search: searchOn.value == true ? searchValue.value : null,
      status: (serviceValues.contains(false) ? serviceValues[0] : null),
      sortBy: selectedSort.value?.keywordName,
      pageSize: 20,
    ));

    isLoading.value = false;

    activePage.value = pageNum;
  }

  Future<void> onStatusChange(int index) async {
    isLoading.value = true;

    BaseModel model = await ContentStatusRepository().put(ContentStatusReqPut(
      contentIds: [contentListModel.value.id![index]],
      status: !contentListModel.value.status![index],
    ));

    if (model.isSuccess) {
      contentListModel.value.status![index] =
          !contentListModel.value.status![index];
    }

    isLoading.value = false;
  }

  Future<void> onExposureChange(int index) async {
    isLoading.value = true;

    BaseModel model = await ContentExposureRepository().put(
        ContentExposureReqPut(
            contentIds: [contentListModel.value.id![index]],
            exposure: !contentListModel.value.exposure![index]));

    if (model.isSuccess) {
      contentListModel.value.exposure![index] =
          !contentListModel.value.exposure![index];
    }

    isLoading.value = false;
  }

  Future<void> onStatusChangeForAll() async {
    List<String> contentIds = [
      for (int i = 0; i < selectedContent.length; i++)
        if (selectedContent[i]) contentListModel.value.id![i],
    ];

    isLoading.value = true;

    List<bool> contentStatus = [
      for (int i = 0; i < selectedContent.length; i++)
        if (selectedContent[i]) contentListModel.value.status![i],
    ];

    List<String> positiveIds = [
      for (int i = 0; i < contentIds.length; i++)
        if (contentStatus[i]) contentIds[i],
    ];
    List<String> negativeIds = [
      for (int i = 0; i < contentIds.length; i++)
        if (!contentStatus[i]) contentIds[i],
    ];

    await ContentStatusRepository()
        .put(ContentStatusReqPut(contentIds: positiveIds, status: false));

    await ContentStatusRepository()
        .put(ContentStatusReqPut(contentIds: negativeIds, status: true));

    isLoading.value = false;

    loadPage(activePage.value);
  }

  Future<void> onExposureChangeForAll(bool isStatusChange) async {
    List<String> contentIds = [
      for (int i = 0; i < selectedContent.length; i++)
        if (selectedContent[i]) contentListModel.value.id![i],
    ];

    isLoading.value = true;

    List<bool> contentExposure = [
      for (int i = 0; i < selectedContent.length; i++)
        if (selectedContent[i]) contentListModel.value.exposure![i],
    ];

    List<String> positiveIds = [
      for (int i = 0; i < contentIds.length; i++)
        if (contentExposure[i]) contentIds[i],
    ];
    List<String> negativeIds = [
      for (int i = 0; i < contentIds.length; i++)
        if (!contentExposure[i]) contentIds[i],
    ];

    await ContentExposureRepository()
        .put(ContentExposureReqPut(contentIds: positiveIds, exposure: false));

    await ContentExposureRepository()
        .put(ContentExposureReqPut(contentIds: negativeIds, exposure: true));

    isLoading.value = false;

    loadPage(activePage.value);
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;

    loadPage(1);
  }

  List<String> getChosenType() {
    if (bodyValues.every((a) => a == false) &&
        breathingValues.every((a) => a == false) &&
        theoryValues.every((a) => a == false) &&
        otherValues.every((a) => a == false)) {
      return [];
    }
    return bodyValues.every((a) => a == true) &&
            breathingValues.every((a) => a == true) &&
            theoryValues.every((a) => a == true) &&
            otherValues.every((a) => a == true)
        ? []
        : [
            for (int i = 0; i < bodyLabels.length; i++)
              if (bodyValues[i]) bodyLabels[i].keywordName,
            for (int i = 0; i < otherLabels.length; i++)
              if (otherValues[i]) otherLabels[i].keywordName,
            for (int i = 0; i < theoryLabels.length; i++)
              if (theoryValues[i]) theoryLabels[i].keywordName,
            for (int i = 0; i < breathingLabels.length; i++)
              if (breathingValues[i]) breathingLabels[i].keywordName,
          ];
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
            '${contentDeleteModel.type}으로 사용되는 Content 입니다. Delete할 수 없습니다. ${contentDeleteModel.type}: ${contentDeleteModel.id}');
        await Future.delayed(const Duration(seconds: 3));
      }
    }
    loadPage(activePage.value);
  }

  void onDetails(int index) {
    Get.offAllNamed(AppRoutes.contentDetails, arguments: {
      RouteArguments.id: Uri.encodeComponent(contentListModel.value.id![index])
    });
  }
}

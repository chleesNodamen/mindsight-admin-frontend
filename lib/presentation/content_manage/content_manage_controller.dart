import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/content_type.dart';
import 'package:mindsight_admin_page/constants/sort_condition.dart';
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

class ContentManageController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  Rx<ContentListModel> contentListModel = ContentListModel().obs;
  late ContentStatusModel contentStatusModel;
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
  Rx<SortCondition?> selectedOrder = SortCondition.registration.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    // searchOn.value = false;
    // searchValue.value = "";
    // bodyValues = List<bool>.filled(3, true).obs;
    // breathingValues = List<bool>.filled(2, true).obs;
    // otherValues = List<bool>.filled(4, true).obs;
    // theoryValues = List<bool>.filled(3, true).obs;
    // serviceValues = List<bool>.filled(2, true).obs;
    // selectedContent = List.generate(20, (_) => false).obs;

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

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
    selectedOrder.value = newOrder;

    await loadPage(1);
  }

  Future<void> loadPage(int pageNum) async {
    selectedContent = List.generate(20, (_) => false).obs;

    isLoading.value = true;

    Logger.info(serviceValues.contains(false) ? serviceValues[0] : null);

    contentListModel.value =
        await ContentListRepository().get(ContentListReqGet(
      type: getChosenType(),
      page: pageNum,
      search: searchOn.value == true ? searchValue.value : null,
      status: (serviceValues.contains(false) ? serviceValues[0] : null),
      sortBy: selectedOrder.value?.keywordName,
      pageSize: 20,
    ));

    isLoading.value = false;

    activePage.value = pageNum;
  }

  Future<void> onStatusChange(int index) async {
    isLoading.value = true;

    contentStatusModel = await ContentStatusRepository().put(
        ContentStatusReqPut(
            contentIds: [contentListModel.value.id![index]],
            status: !contentListModel.value.status![index]));

    if (contentStatusModel.isSuccess) {
      contentListModel.value.status![index] =
          !contentListModel.value.status![index];
    }

    isLoading.value = false;
  }

  Future<void> onStatusChangeForAll() async {
    List<String> contentIds = [
      for (int i = 0; i < selectedContent.length; i++)
        if (selectedContent[i]) contentListModel.value.id![i],
    ];
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

    isLoading.value = true;

    contentStatusModel = await ContentStatusRepository()
        .put(ContentStatusReqPut(contentIds: positiveIds, status: false));
    contentStatusModel = await ContentStatusRepository()
        .put(ContentStatusReqPut(contentIds: negativeIds, status: true));

    isLoading.value = false;

    if (contentStatusModel.isSuccess) {
      loadPage(1);
    }
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
      return [ContentType.unknown.keywordName];
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
            '${contentDeleteModel.type}으로 사용되는 콘텐츠 입니다. 삭제할 수 없습니다. ${contentDeleteModel.type}: ${contentDeleteModel.id}');
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

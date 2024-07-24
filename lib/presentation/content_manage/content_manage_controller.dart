import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_model.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_req_get.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_model.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_repository.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_req_put.dart';

class ContentManageController extends GetxController {
  RxMap<String, bool> selectedIds = <String, bool>{}.obs;

  RxBool showMore = false.obs;
  RxBool isChecked = true.obs;

  var data = [].obs;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  RxBool selected = false.obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

  late ContentListModel contentListModel;
  late ContentStatusModel contentStatusModel;
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

  void updateSelected(String id, bool isSelected) {
    selectedIds[id] = isSelected;
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
    if (AppConstant.chleesTest) {
      isLoading.value = true;
      // List<String> type = [
      //   for (int i = 0; i < membershipLabels.length; i++)
      //     if (membershipValues[i]) membershipLabels[i]
      // ];
      // if (membershipValues.every((element) => element == true)) {
      //   type = [];
      // } //TODO remove later
      contentListModel = await ContentListRepository().get(ContentListReqGet(
        // type: type,
        page: pageNum,
        search: searchOn.value == true ? searchValue.value : null,
        // status: false,
      ).toJson());
      contentState =
          (contentListModel.status!.map((status) => !status).toList()).obs;
    }
    isLoading.value = false;
    activePage.value = pageNum;
  }

  void updateValue() {
    selected.value = !selected.value;
  }

  void loadData() async {
    if (AppConstant.chleesTest) {
      contentListModel = await ContentListRepository().get(ContentListReqGet(
        page: 1,
        status: true,
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
                status: !contentState![index])
            .toJson());
    // if (membersStatusModel.isSuccess) {
    //   isLoading.value = true;
    //   selectedMembers = [
    //     false,
    //     false,
    //     false,
    //     false,
    //     false,
    //     false,
    //     false,
    //     false,
    //     false,
    //     false,
    //   ].obs;
    //   membersModel = await MembersRepository().get(MembersReqGet(
    //     page: 1,
    //     disabled: false,
    //   ).toJson());
    //   memberState = membersModel.status!.obs;
    //   isLoading.value = false;
    //   isInited.value = true;
    // }
  }

  // SEARCH BAR

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;
    if (AppConstant.chleesTest) {
      isLoading.value = true;
      //   List<String> type = [
      //     for (int i = 0; i < checkboxLabels.length; i++)
      //       if (membershipValues[i]) membershipLabels[i]
      //   ];
      //   if (membershipValues.every((element) => element == true)) {
      //     type = [];
      //   } //TODO remove later
      //   membersModel = await MembersRepository().get(MembersReqGet(
      //     page: 1,
      //     type: type,
      //     search: search,
      //     disabled: false,
      //   ).toJson());
      //   memberState =
      //       (membersModel.status!.map((status) => !status).toList()).obs;
      // }
      activePage.value = 1;
      isLoading.value = false;
    }
  }

  void goToDetails(int index) {
    Get.toNamed(AppRoutes.contentDetails, arguments: {
      RouteArguments.id: Uri.encodeComponent(contentListModel.id![index])
    });
  }
}

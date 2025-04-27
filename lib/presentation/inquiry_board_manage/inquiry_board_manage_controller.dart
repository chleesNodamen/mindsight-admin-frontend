import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/sort_condition.dart';
import 'package:mindsight_admin_page/data/inquiry_board_list/inquiry_board_list_model.dart';
import 'package:mindsight_admin_page/data/inquiry_board_list/inquiry_board_list_repository.dart';
import 'package:mindsight_admin_page/data/inquiry_board_list/inquiry_board_list_req_get.dart';

class InquiryBoardManageController extends GetxController {
  RxBool isInited = false.obs;
  RxBool isLoading = true.obs;

  late InquiryBoardListModel inquiryBoardModel;

  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

  Rx<SortCondition> selectedOrder = SortCondition.registration.obs;
  RxInt activePage = 1.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    await loadPage(1);

    isLoading.value = false;
    isInited.value = true;
  }

  void onRegister() {
    Get.offAllNamed(AppRoutes.inquiryBoardRegister);
  }

  void onChangedSelectedOrder(SortCondition newOrder) {
    selectedOrder.value = newOrder;
  }

  Future<void> loadPage(int pageNum) async {
    isLoading.value = true;

    inquiryBoardModel =
        await InquiryBoardListRepository().get(InquiryBoardListReqGet(
      page: pageNum,
      search: searchOn.value == true ? searchValue.value : null,
    ));

    isLoading.value = false;
    activePage.value = pageNum;
  }

  void onDetail(int index) {
    Get.offAllNamed(AppRoutes.inquiryBoardDetail, arguments: {
      RouteArguments.id: Uri.encodeComponent(inquiryBoardModel.id![index])
    });
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;

    loadPage(1);
  }
}

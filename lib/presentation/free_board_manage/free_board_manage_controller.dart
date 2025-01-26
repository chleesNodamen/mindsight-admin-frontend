import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/sort_condition.dart';
import 'package:mindsight_admin_page/data/free_board_list/free_board_list_model.dart';
import 'package:mindsight_admin_page/data/free_board_list/free_board_list_repository.dart';
import 'package:mindsight_admin_page/data/free_board_list/free_board_list_req_get.dart';

class FreeBoardManageController extends GetxController {
  RxBool isInited = false.obs;
  RxBool isLoading = true.obs;

  late FreeBoardListModel freeBoardModel;

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
    Get.offAllNamed(AppRoutes.freeBoardRegister);
  }

  void onChangedSelectedOrder(SortCondition newOrder) {
    selectedOrder.value = newOrder;
  }

  Future<void> loadPage(int pageNum) async {
    isLoading.value = true;

    freeBoardModel = await FreeBoardListRepository().get(FreeBoardListReqGet(
      page: pageNum,
      search: searchOn.value == true ? searchValue.value : null,
    ));

    isLoading.value = false;
    activePage.value = pageNum;
  }

  void onDetail(int index) {
    Get.offAllNamed(AppRoutes.freeBoardDetail, arguments: {
      RouteArguments.id: Uri.encodeComponent(freeBoardModel.id![index])
    });
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;

    loadPage(1);
  }
}

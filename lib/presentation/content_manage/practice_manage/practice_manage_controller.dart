import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/sort_condition.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/practices/practices_model.dart';
import 'package:mindsight_admin_page/data/practices/practices_repository.dart';
import 'package:mindsight_admin_page/data/practices/practices_req_get.dart';

class PracticeManageController extends GetxController {
  RxBool isInited = false.obs;
  RxBool isLoading = true.obs;

  late PracticesModel practicesModel;

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

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    await loadPage(1);

    isLoading.value = false;
    isInited.value = true;
  }

  void onRegisterTap() {
    Get.offAllNamed(AppRoutes.practiceRegister);
  }

  void updateSelectedOrder(SortCondition newOrder) {
    selectedOrder.value = newOrder;
  }

  Future<void> loadPage(int pageNum) async {
    isLoading.value = true;

    practicesModel = await PracticesRepository().get(PracticesReqGet(
      page: pageNum,
      search: searchOn.value == true ? searchValue.value : null,
      sortBy: selectedOrder.value.keywordName,
    ));

    isLoading.value = false;
    activePage.value = pageNum;
  }

  void onDetails(int index) {
    Get.offAllNamed(AppRoutes.practiceDetails, arguments: {
      RouteArguments.id: Uri.encodeComponent(practicesModel.id![index])
    });
  }
}

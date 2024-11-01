import 'package:mindsight_admin_page/app_export.dart';
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

  RxString selectedOrder = '회차순'.obs;
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

    await loadNewPage(1);

    isLoading.value = false;
    isInited.value = true;
  }

  void onRegisterTap() {
    Get.offAllNamed(AppRoutes.practiceRegister);
  }

  void updateSelectedOrder(String newOrder) {
    selectedOrder.value = newOrder;
  }

  Future<void> loadNewPage(int pageNum) async {
    isLoading.value = true;

    practicesModel = await PracticesRepository().get(PracticesReqGet(
      page: pageNum,
      search: searchOn.value == true ? searchValue.value : null,
      sortBy: selectedOrder.value,
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

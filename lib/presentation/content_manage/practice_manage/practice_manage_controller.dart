import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/practices/practices_model.dart';
import 'package:mindsight_admin_page/data/practices/practices_repository.dart';
import 'package:mindsight_admin_page/data/practices/practices_req_get.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_details/practice_details_controller.dart';

class PracticeManageController extends GetxController {
  late PracticesModel practicesModel;
  RxBool isInited = false.obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

//REGISTER BUTTON
  void onRegisterTap() {
    Get.offAllNamed(AppRoutes.practiceRegister);
  }

  //DROPDOWN BUTTON
  RxString selectedOrder = '회차순'.obs;
  void updateSelectedOrder(String newOrder) {
    selectedOrder.value = newOrder;
  }

  //DATA TABLE
  // RxString dataTableButtonText = '정상'.obs;
  // void updateDTText(String newText) {
  //   dataTableButtonText.value = newText;
  // }

  RxInt activePage = 1.obs;
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

  var data = [].obs;
  var isLoading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadData();
  }

  RxBool selected = false.obs;
  void updateValue() {
    selected.value = !selected.value;
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    practicesModel = await PracticesRepository().get(PracticesReqGet(
      page: 1,
    ));

    if (!practicesModel.isSuccess) {
      practicesModel = PracticesModel().copyWith(
        id: List.generate(10, (_) => ""),
        level: List.generate(10, (_) => 111),
        ratio: List.generate(10, (_) => "88%"),
        participated: List.generate(10, (_) => 111),
        finished: List.generate(10, (_) => 111),
        liked: List.generate(10, (_) => 111),
        total: 10,
      );
      practicesModel.length = practicesModel.id!.length;
    }
    isLoading.value = false;
    isInited.value = true;
  }

  void goToDetails(int index) {
    if (Get.isRegistered<PracticeDetailsController>()) {
      Get.delete<PracticeDetailsController>();
    }
    Get.offAllNamed(AppRoutes.practiceDetails, arguments: {
      RouteArguments.id: Uri.encodeComponent(practicesModel.id![index])
    });
  }
}

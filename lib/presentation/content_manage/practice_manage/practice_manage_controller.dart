import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/sort_condition.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/practice_exposure/practice_exposure_repository.dart';
import 'package:mindsight_admin_page/data/practice_exposure/practice_exposure_req_put.dart';
import 'package:mindsight_admin_page/data/practice_list/practice_list_model.dart';
import 'package:mindsight_admin_page/data/practice_list/practice_list_repository.dart';
import 'package:mindsight_admin_page/data/practice_list/practice_list_req_get.dart';
import 'package:mindsight_admin_page/data/practice_status/practice_status_repository.dart';
import 'package:mindsight_admin_page/data/practice_status/practice_status_req_put.dart';

class PracticeManageController extends GetxController {
  RxBool isInited = false.obs;
  RxBool isLoading = true.obs;

  late PracticeListModel practicesModel;

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
      await MasterSigninRepository().post(MasterSigninReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    await loadPage(1);

    isLoading.value = false;
    isInited.value = true;
  }

  void onPressedRegister() {
    Get.offAllNamed(AppRoutes.practiceRegister);
  }

  void onChangedSelectedOrder(SortCondition newOrder) {
    selectedOrder.value = newOrder;
  }

  Future<void> loadPage(int pageNum) async {
    isLoading.value = true;

    practicesModel = await PracticeListRepository().get(PracticeListReqGet(
      page: pageNum,
      search: searchOn.value == true ? searchValue.value : null,
      sortBy: selectedOrder.value.keywordName,
    ));

    isLoading.value = false;
    activePage.value = pageNum;
  }

  void onTapDetail(int index) {
    Get.offAllNamed(AppRoutes.practiceDetails, arguments: {
      RouteArguments.id: Uri.encodeComponent(practicesModel.id![index])
    });
  }

  Future<void> onStatusChange(int index) async {
    if (!Account.isAdminWithMsg) {
      return;
    }

    isLoading.value = true;

    BaseModel model = await PracticeStatusRepository().put(PracticeStatusReqPut(
      ids: [practicesModel.id![index]],
      status: !practicesModel.status![index],
    ));

    if (model.isSuccess) {
      practicesModel.status![index] = !practicesModel.status![index];
    }

    isLoading.value = false;
  }

  Future<void> onExposureChange(int index) async {
    isLoading.value = true;

    BaseModel model =
        await PracticeExposureRepository().put(PracticeExposureReqPut(
      ids: [practicesModel.id![index]],
      exposure: !practicesModel.exposure![index],
    ));

    if (model.isSuccess) {
      practicesModel.exposure![index] = !practicesModel.exposure![index];
    }

    isLoading.value = false;
  }
}

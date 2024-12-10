import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/master_list/master_list_model.dart';
import 'package:mindsight_admin_page/data/master_list/master_list_repository.dart';
import 'package:mindsight_admin_page/data/master_list/master_list_req_get.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/master_verified/master_verified_repository.dart';
import 'package:mindsight_admin_page/data/master_verified/master_verified_req_put.dart';
import 'package:mindsight_admin_page/data/members_status/members_status_model.dart';

class InactiveMasterManageController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late MasterListModel masterListModel;

  RxInt activePage = 1.obs;
  RxList<bool> membershipValues = List<bool>.filled(3, true).obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;
  RxList<bool> selectedMaster = List.generate(20, (_) => false).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    searchOn = false.obs;
    searchValue = "".obs;
    activePage = 1.obs;

    if (AppConstant.test) {
      await MasterSigninRepository().post(MasterSigninReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    await loadPage(1);

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;

    await loadPage(1);
  }

  Future<void> loadPage(int pageNum) async {
    isLoading.value = true;

    selectedMaster = List.generate(20, (_) => false).obs;

    masterListModel = await MasterListRepository().get(MasterListReqGet(
      page: pageNum,
      search: searchOn.value == true ? searchValue.value : null,
      verified: false,
    ));

    activePage.value = pageNum;
    isLoading.value = false;
  }

  void onMasterTap(String id) {
    Get.offAllNamed(AppRoutes.masterDetails,
        arguments: {RouteArguments.id: id});
  }

  void onMasterSelectChanged(int index) {
    selectedMaster[index] = !selectedMaster[index];
  }

  Future<void> onVerifiedChanged(int index) async {
    if (!Account.isAdminWithMsg) {
      return;
    }

    isLoading.value = true;

    masterListModel.verified![index] = !masterListModel.verified![index];

    BaseModel model = await MasterVerifiedRepository().put(MasterVerifiedReqPut(
        ids: [masterListModel.id![index]],
        verified: masterListModel.verified![index]));

    if (model.isSuccess) {
      await loadPage(activePage.value);
    }

    isLoading.value = false;
  }

  Future<void> onVerfiedButtonPressed() async {
    if (!Account.isAdminWithMsg) {
      return;
    }

    isLoading.value = true;

    List<String> ids = [
      for (int i = 0; i < masterListModel.length; i++)
        if (selectedMaster[i]) masterListModel.id![i]
    ];

    BaseModel model = await MasterVerifiedRepository()
        .put(MasterVerifiedReqPut(ids: ids, verified: true));

    if (model.isSuccess) {
      await loadPage(activePage.value);
    }

    isLoading.value = false;
  }
}

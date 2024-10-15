import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_list/master_profit_rate_list_model.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_list/master_profit_rate_list_repository.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_list/master_profit_rate_list_req_get.dart';

enum Type { all, notIssued, notSettled }

class RevenueShareManageController extends GetxController {
  static RevenueShareManageController get to =>
      Get.find<RevenueShareManageController>();

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late MasterProfitRateListModel masterProfitRateListModel;

  RxInt activePage = 1.obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

  @override
  Future<void> onInit() async {
    loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;
    searchOn = false.obs;
    searchValue = "".obs;
    activePage = 1.obs;

    if (AppConstant.chleesTest) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.chleesTestEmail,
          password: AppConstant.chleesTestPassword));
    }

    if (AppConstant.chleesTest) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.chleesTestEmail,
          password: AppConstant.chleesTestPassword));
    }

    masterProfitRateListModel =
        await MasterProfitRateListRepository().get(MasterProfitRateListReqGet(
      page: 1,
      search: '',
    ).toJson());

    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> onSearch(String? search) async {}

  onChangeProfitRate() {}
}

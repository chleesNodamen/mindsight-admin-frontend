import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_change/master_profit_rate_change_model.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_change/master_profit_rate_change_repository.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_change/master_profit_rate_change_req_patch.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_list/master_profit_rate_list_model.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_list/master_profit_rate_list_repository.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_list/master_profit_rate_list_req_get.dart';

enum Type { all, notIssued, notSettled }

class RevenueShareManageController extends GetxController {
  static RevenueShareManageController get to =>
      Get.find<RevenueShareManageController>();

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  Rx<MasterProfitRateListModel> masterProfitRateListModel =
      MasterProfitRateListModel().obs;

  RxInt activePage = 1.obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

  TextEditingController profitChangeController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;
    isInited.value = false;
    searchOn = false.obs;
    searchValue = "".obs;
    activePage = 1.obs;

    // settlementSummaryModel =
    //     await SettlementSummaryRepository().get(SettlementSummaryReqGet(
    //   month: 10,
    //   search: '',
    // ).toJson());

    masterProfitRateListModel.value =
        await MasterProfitRateListRepository().get(MasterProfitRateListReqGet(
      page: 1,
      search: '',
    ));

    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> onSearch(String? search) async {}

  onProfitChange(int index) async {
    if (profitChangeController.text.isEmpty ||
        !profitChangeController.text.isNum) {
      return;
    }

    isLoading.value = true;

    MasterProfitRateChangeModel model = await MasterProfitRateChangeRepository()
        .put(MasterProfitRateChangeReqPatch(
      masterId: masterProfitRateListModel.value.id![index],
      rate: double.parse(profitChangeController.text),
    ));

    if (model.isSuccess) {
      masterProfitRateListModel.value.currentProfitRate![index] =
          model.currentProfitRate!;
      masterProfitRateListModel.value.previousProfitRate![index] =
          model.previousProfitRate!;
    }

    isLoading.value = false;

    Get.back();
  }
}

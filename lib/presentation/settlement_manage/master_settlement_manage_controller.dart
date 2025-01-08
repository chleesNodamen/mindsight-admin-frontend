import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/master_settlement_list/master_settlement_list_model.dart';
import 'package:mindsight_admin_page/data/master_settlement_list/master_settlement_list_repository.dart';
import 'package:mindsight_admin_page/data/master_settlement_list/master_settlement_list_req_get.dart';
import 'package:mindsight_admin_page/data/purchase_list/purchase_list_model.dart';
import 'package:mindsight_admin_page/data/purchase_list/purchase_list_repository.dart';
import 'package:mindsight_admin_page/data/purchase_list/purchase_list_req_get.dart';
import 'package:mindsight_admin_page/data/settlement_summary/settlement_summary_model.dart';
import 'package:mindsight_admin_page/data/settlement_summary/settlement_summary_repository.dart';
import 'package:mindsight_admin_page/data/settlement_summary/settlement_summary_req_get.dart';

enum Type { all, notIssued, notSettled }

enum MonthType { lastMonth, thisMonth, selectedMonth }

class MasterSettlementManageController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late MasterSettlementListModel masterSettlementListModel;
  late SettlementSummaryModel settlementSummaryModel;

  // Rx<Type> type = Type.all.obs;
  RxInt activePage = 1.obs;
  // RxInt activePageMasterContentSettlementList = 1.obs;
  Rx<MonthType> selectedMonthType = MonthType.thisMonth.obs;
  RxString dateRange = ''.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxInt selectedMonth = 1.obs;

  @override
  Future<void> onInit() async {
    await loadPage(1);
    await changeMonth(MonthType.thisMonth);

    super.onInit();
  }

  Future<void> changeMonth(MonthType monthType,
      {int? year, int? monthNumber}) async {
    selectedMonthType.value = monthType;
    DateTime now = DateTime.now();
    DateTime firstDay;
    DateTime lastDay;

    if (monthType == MonthType.lastMonth) {
      // Handle January to December transition
      if (now.month == 1) {
        firstDay = DateTime(now.year - 1, 12, 1);
      } else {
        firstDay = DateTime(now.year, now.month - 1, 1);
      }
      lastDay = DateTime(firstDay.year, firstDay.month + 1, 0);
      // displayedMonth.value = DateFormat('MM').format(firstDay);
      selectedMonth.value = int.parse(DateFormat('MM').format(firstDay));
    } else if (monthType == MonthType.thisMonth) {
      firstDay = DateTime(now.year, now.month, 1);
      lastDay = DateTime(now.year, now.month + 1, 0);
      // displayedMonth.value = DateFormat('MM').format(firstDay);
      selectedMonth.value = now.month;
    } else {
      // selectedMonth case
      if (year == null || monthNumber == null) {
        // year 또는 monthNumber가 null일 경우 기본값 Settings 또는 에러 처리
        firstDay = DateTime(now.year, now.month, 1);
        lastDay = DateTime(now.year, now.month + 1, 0);
        selectedMonth.value = now.month;
      } else {
        firstDay = DateTime(year, monthNumber, 1);
        lastDay = DateTime(year, monthNumber + 1, 0);
        selectedDate.value = DateTime(year, monthNumber, 1);
        selectedMonth.value = monthNumber;
      }
    }

    String formattedFirstDay =
        DateFormat('yyyy-MM-dd 00:00:00').format(firstDay);
    String formattedLastDay = DateFormat('yyyy-MM-dd 23:59:59').format(lastDay);
    dateRange.value = '$formattedFirstDay ~ $formattedLastDay';

    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;
    activePage.value = 1;

    settlementSummaryModel =
        await SettlementSummaryRepository().get(SettlementSummaryReqGet(
      month: selectedMonth.value,
      search: '',
    ));

    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> loadPage(int page) async {
    isLoading.value = true;
    activePage.value = page;

    masterSettlementListModel =
        await MasterSettlementListRepository().get(MasterSettlementListReqGet(
      masterId: Account.id,
      page: page,
      month: selectedMonth.value,
    ));

    isLoading.value = false;
  }

  String getViewRate(int index) {
    int playCount = masterSettlementListModel.playCount![index];
    int totalPlayCount = settlementSummaryModel.playCount!;

    if (totalPlayCount == 0) {
      return "0";
    }
    return ((playCount / totalPlayCount) * 100).toStringAsFixed(1);
  }

  String getSettlementAmount(int index) {
    int playCount = masterSettlementListModel.playCount![index];
    int totalPlayCount = settlementSummaryModel.playCount!;
    double profitRate = masterSettlementListModel.currentProfitRate![index];
    double finalSales = settlementSummaryModel.finalSales!;

    if (totalPlayCount == 0) {
      return "0";
    }

    return "${(finalSales * (((playCount / totalPlayCount) * 100) / 100) * (profitRate / 100))}";
  }
}

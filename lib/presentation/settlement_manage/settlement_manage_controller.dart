import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/master_settlement_list/master_settlement_list_model.dart';
import 'package:mindsight_admin_page/data/master_settlement_list/master_settlement_list_repository.dart';
import 'package:mindsight_admin_page/data/master_settlement_list/master_settlement_list_req_get.dart';

enum Type { all, notIssued, notSettled }

enum MonthType { lastMonth, thisMonth, selectedMonth }

class SettlementManageController extends GetxController {
  static SettlementManageController get to =>
      Get.find<SettlementManageController>();

  List<String> typeLabels = [
    "전체",
    "미발행",
    "미정산",
  ];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late MasterSettlementListModel masterSettlementListModel;

  Rx<Type> type = Type.all.obs;
  RxInt activePage = 1.obs;
  Rx<MonthType> selectedMonth = MonthType.thisMonth.obs;
  RxString dateRange = ''.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString displayedMonth = ''.obs;

  @override
  Future<void> onInit() async {
    loadData();
    changeMonth(MonthType.thisMonth);
    super.onInit();
  }

  void changeMonth(MonthType month, {int? year, int? monthNumber}) {
    selectedMonth.value = month;
    DateTime now = DateTime.now();
    DateTime firstDay;
    DateTime lastDay;

    if (month == MonthType.lastMonth) {
      // Handle January to December transition
      if (now.month == 1) {
        firstDay = DateTime(now.year - 1, 12, 1);
      } else {
        firstDay = DateTime(now.year, now.month - 1, 1);
      }
      lastDay = DateTime(firstDay.year, firstDay.month + 1, 0);
      displayedMonth.value = DateFormat('yyyy-MM').format(firstDay);
    } else if (month == MonthType.thisMonth) {
      firstDay = DateTime(now.year, now.month, 1);
      lastDay = DateTime(now.year, now.month + 1, 0);
      displayedMonth.value = DateFormat('yyyy-MM').format(firstDay);
    } else {
      // selectedMonth case
      if (year == null || monthNumber == null) {
        // year 또는 monthNumber가 null일 경우 기본값 설정 또는 에러 처리
        firstDay = DateTime(now.year, now.month, 1);
        lastDay = DateTime(now.year, now.month + 1, 0);
      } else {
        firstDay = DateTime(year, monthNumber, 1);
        lastDay = DateTime(year, monthNumber + 1, 0);
        selectedDate.value = DateTime(year, monthNumber, 1);
        displayedMonth.value = DateFormat('yyyy-MM').format(firstDay);
      }
    }

    String formattedFirstDay =
        DateFormat('yyyy-MM-dd 00:00:00').format(firstDay);
    String formattedLastDay = DateFormat('yyyy-MM-dd 23:59:59').format(lastDay);
    dateRange.value = '$formattedFirstDay ~ $formattedLastDay';
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;
    activePage = 1.obs;

    if (AppConstant.chleesTest) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.chleesTestEmail,
          password: AppConstant.chleesTestPassword));
    }

    masterSettlementListModel =
        await MasterSettlementListRepository().get(MasterSettlementListReqGet(
      page: 1,
      search: '',
    ).toJson());

    isLoading.value = false;
    isInited.value = true;
  }

  Future<bool> loadNewData() async {
    return false;
  }

  Future<void> loadNewPage(int pageNum) async {}

  Future<void> changeType(Type? newType) async {
    if (newType == null) {
      return;
    }
    isLoading.value = true;

    // activityModel = await ActivityRepository().get(ActivityReqGet(
    //   page: 1,
    //   type: newType.name,
    // ).toJson());

    type.value = newType;

    activePage.value = 1;
    isLoading.value = false;
  }

  Future<void> onSearch(String? search) async {}
}

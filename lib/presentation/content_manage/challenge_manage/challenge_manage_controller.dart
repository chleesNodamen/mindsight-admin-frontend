import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/goal.dart';
import 'package:mindsight_admin_page/constants/enum/sort_condition.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/challenges_exposure/challenges_exposure_repository.dart';
import 'package:mindsight_admin_page/data/challenges_exposure/challenges_exposure_req_put.dart';
import 'package:mindsight_admin_page/data/challenges_list/challenges_list_model.dart';
import 'package:mindsight_admin_page/data/challenges_list/challenges_list_repository.dart';
import 'package:mindsight_admin_page/data/challenges_list/challenges_list_req_get.dart';
import 'package:mindsight_admin_page/data/challenges_status/challenges_status_repository.dart';
import 'package:mindsight_admin_page/data/challenges_status/challenges_status_req_put.dart';

class ChallengeManageController extends GetxController {
  RxBool isInited = false.obs;
  RxBool isLoading = true.obs;

  late ChallengesListModel challengesModel;

  RxMap<String, bool> selectedIds = <String, bool>{}.obs;

  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

  RxList<Goal> goalLabels = [
    Goal.improveHealth,
    Goal.relaxingStretching,
    Goal.welnessAtWork,
    Goal.regulateEmotions,
    Goal.fallAsleepEasily
  ].obs;

  RxList<bool> goalValues = List<bool>.filled(5, true).obs;

  List<String> periodLabels = ["7", "14", "21", "30"];
  RxList<bool> periodValues = List<bool>.filled(4, true).obs;

  RxList<bool> statusValues = List<bool>.filled(2, true).obs;

  RxBool isChecked = true.obs;

  Rx<SortCondition> selectedOrder = SortCondition.registration.obs;
  RxInt activePage = 1.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    await loadPage(1);

    isLoading.value = false;
    isInited.value = true;
  }

  void toggleGoalCheckbox(int index, bool value) {
    goalValues[index] = value;

    loadPage(1);
  }

  void togglePeriodCheckbox(int index, bool value) {
    periodValues[index] = value;

    loadPage(1);
  }

  void toggleStatusCheckbox(int index, bool value) {
    statusValues[index] = value;

    loadPage(1);
  }

  void updateSelectedOrder(SortCondition newOrder) {
    selectedOrder.value = newOrder;

    loadPage(1);
  }

  void updateSelected(String id, bool isSelected) {
    selectedIds[id] = isSelected;
  }

  Future<void> loadPage(int pageNum) async {
    isLoading.value = true;

    List<String> goal = [
      for (int i = 0; i < goalLabels.length; i++)
        if (goalValues[i]) goalLabels[i].keywordName
    ];
    if (goalValues.every((element) => element == true)) {
      goal = [];
    }
    if (goalValues.every((element) => element == false)) {
      goal = ['known'];
    }

    List<int> days = [
      for (int i = 0; i < periodLabels.length; i++)
        if (periodValues[i]) int.parse(periodLabels[i])
    ];
    if (periodValues.every((element) => element == true)) {
      days = [];
    }
    if (periodValues.every((element) => element == false)) {
      days = [0];
    }

    challengesModel = await ChallengesListRepository().get(
      ChallengesListReqGet(
        page: pageNum,
        goal: goal,
        days: days,
        search: searchOn.value == true ? searchValue.value : null,
        status: (statusValues.contains(false) ? statusValues[0] : null),
        sortBy: selectedOrder.value.keywordName,
      ),
    );

    isLoading.value = false;
    activePage.value = pageNum;
  }

  Future<void> onStatusChange(int index) async {
    isLoading.value = true;

    BaseModel model = await ChallengesStatusRepository().put(
        ChallengesStatusReqPut(
            challengeIds: [challengesModel.id![index]],
            status: !challengesModel.status![index]));

    isLoading.value = false;

    if (model.isSuccess) {
      challengesModel.status![index] = !challengesModel.status![index];
    }
  }

  Future<void> onExposureChange(int index) async {
    isLoading.value = true;

    BaseModel model = await ChallengesExposureRepository().put(
        ChallengesExposureReqPut(
            challengeIds: [challengesModel.id![index]],
            exposure: !challengesModel.exposure![index]));

    if (model.isSuccess) {
      challengesModel.exposure![index] = !challengesModel.exposure![index];
    }

    isLoading.value = false;
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;

    await loadPage(1);
  }

  void onDetail(int index) {
    Get.offAllNamed(AppRoutes.challengeDetails, arguments: {
      RouteArguments.id: Uri.encodeComponent(challengesModel.id![index])
    });
  }
}

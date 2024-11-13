import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/goal.dart';
import 'package:mindsight_admin_page/constants/sort_condition.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/challenges/challenges_model.dart';
import 'package:mindsight_admin_page/data/challenges/challenges_repository.dart';
import 'package:mindsight_admin_page/data/challenges/challenges_req_get.dart';
import 'package:mindsight_admin_page/data/challenges_status/challenges_status_model.dart';
import 'package:mindsight_admin_page/data/challenges_status/challenges_status_repository.dart';
import 'package:mindsight_admin_page/data/challenges_status/challenges_status_req_put.dart';

class ChallengeManageController extends GetxController {
  RxBool isInited = false.obs;
  RxBool isLoading = true.obs;

  late ChallengesModel challengesModel;
  late ChallengesStatusModel challengesStatusModel;

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

  List<String> periodLabels = ["7일", "14일", "21일", "30일"];
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

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

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
        if (periodValues[i])
          periodLabels[i] == "7일"
              ? 7
              : periodLabels[i] == "14일"
                  ? 14
                  : periodLabels[i] == "21일"
                      ? 21
                      : 30
    ];
    if (periodValues.every((element) => element == true)) {
      days = [];
    }
    if (periodValues.every((element) => element == false)) {
      days = [0];
    }

    challengesModel = await ChallengesRepository().get(
      ChallengesReqGet(
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

    challengesStatusModel = await ChallengesStatusRepository().put(
        ChallengesStatusReqPut(
            challengeIds: [challengesModel.id![index]],
            status: !challengesModel.status![index]));

    isLoading.value = false;

    if (challengesStatusModel.isSuccess) {
      challengesModel.status![index] = !challengesModel.status![index];
    }
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;

    await loadPage(1);
  }

  void goToEdit(int index) {
    Get.offAllNamed(AppRoutes.challengeDetails, arguments: {
      RouteArguments.id: Uri.encodeComponent(challengesModel.id![index])
    });
  }
}

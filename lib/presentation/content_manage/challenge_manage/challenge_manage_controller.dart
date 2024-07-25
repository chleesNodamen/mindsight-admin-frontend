import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_details/challenge_details_controller.dart';
import 'package:mindsight_admin_page/data/challenges/challenges_model.dart';
import 'package:mindsight_admin_page/data/challenges/challenges_repository.dart';
import 'package:mindsight_admin_page/data/challenges/challenges_req_get.dart';
import 'package:mindsight_admin_page/data/challenges_status/challenges_status_model.dart';
import 'package:mindsight_admin_page/data/challenges_status/challenges_status_repository.dart';
import 'package:mindsight_admin_page/data/challenges_status/challenges_status_req_put.dart';

class ChallengeManageController extends GetxController {
  RxMap<String, bool> selectedIds = <String, bool>{}.obs;

  late ChallengesModel challengesModel;
  late ChallengesStatusModel challengesStatusModel;

  RxBool isInited = false.obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;
  var data = [].obs;
  RxList<bool>? challengesState;

  RxBool isLoading = true.obs;
  //  FIRST CONTAINER //

  // Initial list of checkbox labels
  RxList<String> checkboxLabels = [
    "Improve health",
    "Relaxing stretching",
    "Welness at work",
    "Regulate emotions",
    "Fall asleep easily",
  ].obs;

  // List of additional checkbox labels
  List<String> periodLabels = ["7일", "14일", "21일", "30일"];
  RxList<bool> periodValues = List<bool>.filled(4, true).obs;
  // Initial list of checkbox values
  RxList<bool> checkboxValues = List<bool>.filled(5, true).obs;

  RxBool showMore = false.obs;
  RxBool isChecked = true.obs;
  RxList<bool> secondCheckboxValues = List<bool>.filled(2, true).obs;

  void toggleCheckbox(int index, bool value) {
    checkboxValues[index] = value;
  }

  void toggleSecondCheckbox(int index, bool value) {
    secondCheckboxValues[index] = value;
  }

  //DROPDOWN BUTTON
  RxString selectedOrder = '등록순'.obs;
  void updateSelectedOrder(String newOrder) {
    selectedOrder.value = newOrder;
  }

  //DATA TABLE
  void updateSelected(String id, bool isSelected) {
    selectedIds[id] = isSelected;
  }

  RxInt activePage = 1.obs;
  void loadNewPage(int pageNum) {
    activePage.value = pageNum;
  }

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
    if (AppConstant.chleesTest) {
      challengesModel = await ChallengesRepository().get(
        ChallengesReqGet(
          page: 1,
          // sortBy: selectedOrder.value,
        ).toJson(),
      );
      challengesState =
          (challengesModel.status!.map((status) => !status).toList()).obs;
    }
    if (!challengesModel.isSuccess) {
      challengesModel = ChallengesModel().copyWith(
        id: List.generate(10, (_) => ""),
        goal: List.generate(10, (_) => ""),
        name: List.generate(10, (_) => 'akdlsemtkdlxm@nodamen.com'),
        participants: List.generate(10, (_) => 111),
        finished: List.generate(10, (_) => 111),
        liked: List.generate(10, (_) => 111),
        status: List.generate(10, (_) => true),
        total: 10,
      );
      challengesModel.length = challengesModel.id!.length;
      challengesState =
          (challengesModel.status!.map((status) => status).toList()).obs;
    }
    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> onStatusChange(int index) async {
    challengesStatusModel = await ChallengesStatusRepository().put(
        ChallengesStatusReqPut(
                challengesId: [challengesModel.id![index]],
                status: !challengesState![index])
            .toJson());
    // if (membersStatusModel.isSuccess) {
    //   isLoading.value = true;
    //   selectedMembers = [
    //     false,
    //     false,
    //     false,
    //     false,
    //     false,
    //     false,
    //     false,
    //     false,
    //     false,
    //     false,
    //   ].obs;
    //   membersModel = await MembersRepository().get(MembersReqGet(
    //     page: 1,
    //     disabled: false,
    //   ).toJson());
    //   memberState = membersModel.status!.obs;
    //   isLoading.value = false;
    //   isInited.value = true;
    // }
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;
    if (AppConstant.chleesTest) {
      isLoading.value = true;
      // List<String> affiliation = [
      //   for (int i = 0; i < membershipLabels.length; i++)
      //     if (membershipValues[i]) membershipLabels[i]
      // ];
      // if (membershipValues.every((element) => element == true)) {
      //   affiliation = [];
      // } //TODO remove later
      // membersModel = await MembersRepository().get(MembersReqGet(
      //   page: 1,
      //   affiliation: affiliation,
      //   search: search,
      //   disabled: false,
      // ).toJson());
      // memberState =
      //     (membersModel.status!.map((status) => !status).toList()).obs;
    }
    activePage.value = 1;
    isLoading.value = false;
  }

  void goToEdit() {
    if (Get.isRegistered<ChallengeDetailsController>()) {
      Get.delete<ChallengeDetailsController>();
    }
    Get.toNamed(AppRoutes.challengeDetails);
  }
}

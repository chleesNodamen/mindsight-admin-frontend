import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/members/members_model.dart';
import 'package:mindsight_admin_page/data/members/members_repository.dart';
import 'package:mindsight_admin_page/data/members/members_req_get.dart';
import 'package:mindsight_admin_page/data/members_status/members_status_model.dart';
import 'package:mindsight_admin_page/data/members_status/members_status_repository.dart';
import 'package:mindsight_admin_page/data/members_status/members_status_req_put.dart';

class MasterManageController extends GetxController {
  List<String> membershipLabels = [
    "Nodamen",
    "UNHCR",
    "UN Women",
  ];
  RxInt activePage = 1.obs;
  RxList<bool> membershipValues = List<bool>.filled(3, true).obs;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

  late MembersModel membersModel;
  late MembersStatusModel membersStatusModel;
  late AffiliationModel affiliationModel;

  RxList<bool> selectedMembers = List.generate(20, (_) => false).obs;
  RxList<bool>? memberState;

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
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    affiliationModel = await AffiliationRepository().get();
    membershipLabels = affiliationModel.affiliation!;

    await loadNewPage(1);

    isInited.value = true;
    isLoading.value = false;
  }

  List<String> getCheckedAffiliation() {
    List<String> affiliation = [
      for (int i = 0; i < membershipLabels.length; i++)
        if (membershipValues[i]) membershipLabels[i]
    ];

    // 모두 체크 되었을 떄..조건 주지 않음
    if (membershipValues.every((element) => element == true)) {
      affiliation = [];
    }

    // 아무것도 체크 안되었을때는..검색이 안되어야 된다..
    if (membershipValues.every((element) => element == false)) {
      affiliation = ['known'];
    }

    return affiliation;
  }

  Future<void> onCheckMembership(int index, bool value) async {
    searchOn.value = false;
    searchValue.value = "";

    membershipValues[index] = value;

    await loadNewPage(1);
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;

    await loadNewPage(1);
  }

  Future<void> loadNewPage(int pageNum) async {
    isLoading.value = true;

    selectedMembers = List.generate(20, (_) => false).obs;

    membersModel = await MembersRepository().get(MembersReqGet(
      affiliation: getCheckedAffiliation(),
      page: pageNum,
      search: searchOn.value == true ? searchValue.value : null,
      disabled: false,
    ));
    memberState = (membersModel.status!.map((status) => !status).toList()).obs;

    activePage.value = pageNum;
    isLoading.value = false;
  }

  void onMasterTap(String id) {
    Get.offAllNamed(AppRoutes.masterDetails,
        arguments: {RouteArguments.id: id});
  }

  void updateValue(int index) {
    selectedMembers[index] = !selectedMembers[index];
  }

  Future<void> onStatusChange(int index) async {
    isLoading.value = true;

    membersStatusModel = await MembersStatusRepository().put(
        MembersStatusReqPut(
            ids: [membersModel.id![index]], status: !memberState![index]));

    if (membersStatusModel.isSuccess) {
      await loadNewPage(activePage.value);
    }

    isLoading.value = false;
  }

  Future<void> onButtonPressed() async {
    isLoading.value = true;

    List<String> ids = [
      for (int i = 0; i < membersModel.length; i++)
        if (selectedMembers[i]) membersModel.id![i]
    ];
    membersStatusModel = await MembersStatusRepository()
        .put(MembersStatusReqPut(ids: ids, status: true));

    if (membersStatusModel.isSuccess) {
      await loadNewPage(activePage.value);
    }

    isLoading.value = false;
  }
}

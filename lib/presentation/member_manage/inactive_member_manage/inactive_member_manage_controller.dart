import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_repository.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/member_delete/member_status_repository.dart';
import 'package:mindsight_admin_page/data/member_delete/member_status_req_put.dart';
import 'package:mindsight_admin_page/data/member_list/member_list_model.dart';
import 'package:mindsight_admin_page/data/member_list/member_list_repository.dart';
import 'package:mindsight_admin_page/data/member_list/member_list_req_get.dart';
import 'package:mindsight_admin_page/data/member_status/member_status_repository.dart';
import 'package:mindsight_admin_page/data/member_status/member_status_req_put.dart';

class InactiveMemberManageController extends GetxController {
  static InactiveMemberManageController get to =>
      Get.find<InactiveMemberManageController>();
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

  late MemberListModel membersModel;
  late AffiliationModel affiliationModel;

  RxList<bool> selectedMembers = List.generate(20, (_) => false).obs;
  RxList<bool>? memberState;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  List<String> getCheckedAffiliation() {
    List<String> affiliation = [
      for (int i = 0; i < membershipLabels.length; i++)
        if (membershipValues[i]) membershipLabels[i]
    ];

    // 모두 체크 되었을 떄..조건 주지 않음..
    if (membershipValues.every((element) => element == true)) {
      affiliation = [];
    }

    // 아무것도 체크 안되었을때는..Search이 안되어야 된다..
    if (membershipValues.every((element) => element == false)) {
      affiliation = ['known'];
    }

    return affiliation;
  }

  Future<void> initData() async {
    isLoading.value = true;

    searchOn = false.obs;
    searchValue = "".obs;
    activePage = 1.obs;

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }
    affiliationModel = await AffiliationRepository().get();
    membershipLabels = affiliationModel.affiliation!;

    await loadPage(1);

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onCheckMembership(int index, bool value) async {
    searchOn.value = false;
    searchValue.value = "";
    membershipValues[index] = value;

    await loadPage(1);
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;

    await loadPage(1);
  }

  Future<void> loadPage(int pageNum) async {
    isLoading.value = true;

    selectedMembers = List.generate(20, (_) => false).obs;

    membersModel = await MemberListRepository().get(MemberListReqGet(
        page: pageNum,
        disabled: true,
        search: searchOn.value == true ? searchValue.value : null,
        affiliation: getCheckedAffiliation()));

    memberState = (membersModel.status!.map((status) => !status).toList()).obs;
    activePage.value = pageNum;

    isLoading.value = false;
  }

  void onMemberTap(String id) {
    Get.offAllNamed(AppRoutes.memberDetails,
        arguments: {RouteArguments.id: id});
  }

  void updateValue(int index) {
    selectedMembers[index] = !selectedMembers[index];
  }

  Future<void> onStatusChange(int index, bool newState) async {
    memberState![index] = newState;
    isLoading.value = true;

    await MemberStatusRepository().put(MemberStatusReqPut(
        ids: [membersModel.id![index]], status: !memberState![index]));

    await loadPage(1);

    isLoading.value = false;
  }

  Future<void> onActivePressed() async {
    isLoading.value = true;

    List<String> ids = [
      for (int i = 0; i < membersModel.length; i++)
        if (selectedMembers[i]) membersModel.id![i]
    ];
    BaseModel model = await MemberStatusRepository()
        .put(MemberStatusReqPut(ids: ids, status: false));

    if (model.isSuccess) {
      await loadPage(1);
    }

    isLoading.value = false;
  }

  Future<void> onDeletePressed() async {
    isLoading.value = true;

    List<String> ids = [
      for (int i = 0; i < membersModel.length; i++)
        if (selectedMembers[i]) membersModel.id![i]
    ];
    BaseModel model = await MemberDeleteRepository()
        .put(MemberDeleteReqPut(ids: ids, delete: true));

    if (model.isSuccess) {
      await loadPage(1);

      showSimpleMessage("Delete 되었습니다");
    } else {
      showSimpleMessage("Delete에 실패 하였습니다. ${model.getErrorMessage()}");
    }

    isLoading.value = false;
  }
}

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
import 'package:mindsight_admin_page/presentation/member_manage/member_details_controller.dart';

class MemberManageController extends GetxController {
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
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;

    searchOn = false.obs;
    searchValue = "".obs;
    activePage = 1.obs;

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    membersModel = await MembersRepository().get(MembersReqGet(
      page: 1,
      disabled: false,
    ));
    affiliationModel = await AffiliationRepository().get();
    membershipLabels = affiliationModel.affiliation!;
    membershipValues = List<bool>.filled(affiliationModel.length, true).obs;

    memberState = (membersModel.status!.map((status) => !status).toList()).obs;

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> toggleMembership(int index, bool value) async {
    searchOn.value = false;
    searchValue.value = "";

    isLoading.value = true;
    membershipValues[index] = value;
    List<String> affiliation = [
      for (int i = 0; i < membershipLabels.length; i++)
        if (membershipValues[i]) membershipLabels[i]
    ];
    membersModel = await MembersRepository().get(MembersReqGet(
      page: 1,
      affiliation: affiliation,
      disabled: false,
    ));
    memberState = (membersModel.status!.map((status) => !status).toList()).obs;

    activePage.value = 1;
    isLoading.value = false;
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;

    isLoading.value = true;
    List<String> affiliation = [
      for (int i = 0; i < membershipLabels.length; i++)
        if (membershipValues[i]) membershipLabels[i]
    ];
    if (membershipValues.every((element) => element == true)) {
      affiliation = [];
    }
    membersModel = await MembersRepository().get(MembersReqGet(
      page: 1,
      affiliation: affiliation,
      search: search,
      disabled: false,
    ));
    memberState = (membersModel.status!.map((status) => !status).toList()).obs;

    activePage.value = 1;
    isLoading.value = false;
  }

  Future<void> loadNewPage(int pageNum) async {
    selectedMembers = List.generate(20, (_) => false).obs;

    isLoading.value = true;
    List<String> affiliation = [
      for (int i = 0; i < membershipLabels.length; i++)
        if (membershipValues[i]) membershipLabels[i]
    ];
    if (membershipValues.every((element) => element == true)) {
      affiliation = [];
    }
    membersModel = await MembersRepository().get(MembersReqGet(
      affiliation: affiliation,
      page: pageNum,
      search: searchOn.value == true ? searchValue.value : null,
      disabled: false,
    ));
    memberState = (membersModel.status!.map((status) => !status).toList()).obs;

    activePage.value = pageNum;
    isLoading.value = false;
  }

  void onMemberTap(String id) {
    if (Get.isRegistered<MemberDetailsController>()) {
      Get.delete<MemberDetailsController>();
    }
    Get.offAllNamed(AppRoutes.memberDetails,
        arguments: {RouteArguments.id: id});
  }

  void updateValue(int index) {
    selectedMembers[index] = !selectedMembers[index];
  }

  Future<void> onStatusChange(int index) async {
    membersStatusModel = await MembersStatusRepository().put(
        MembersStatusReqPut(
            ids: [membersModel.id![index]], status: !memberState![index]));
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

  Future<void> onButtonPressed() async {
    List<String> ids = [
      for (int i = 0; i < membersModel.length; i++)
        if (selectedMembers[i]) membersModel.id![i]
    ];
    membersStatusModel = await MembersStatusRepository()
        .put(MembersStatusReqPut(ids: ids, status: true));
    if (membersStatusModel.isSuccess) {
      isLoading.value = true;
      selectedMembers = List.generate(20, (_) => false).obs;
      membersModel = await MembersRepository().get(MembersReqGet(
        page: 1,
        disabled: false,
      ));
      memberState =
          (membersModel.status!.map((status) => !status).toList()).obs;
      isLoading.value = false;
      isInited.value = true;
    }
  }
}

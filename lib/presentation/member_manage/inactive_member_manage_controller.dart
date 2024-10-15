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
      membersModel = await MembersRepository().get(MembersReqGet(
        page: 1,
        disabled: true,
      ).toJson());
      affiliationModel = await AffiliationRepository().get();
      membershipLabels = affiliationModel.affiliation!;
      membershipValues = List<bool>.filled(affiliationModel.length, true).obs;
    } else {
      membersModel = MembersModel().copyWith(
        id: [
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
        ],
        affiliation: List.generate(10, (_) => 'Nodamen'),
        email: List.generate(10, (_) => 'akdlsemtkdlxm@nodamen.com'),
        username: List.generate(10, (_) => 'dbwjspdla'),
        createdAt: List.generate(10, (_) => DateTime.now()),
        status: List.generate(10, (_) => false),
        total: 10,
      );
      membersModel.length = membersModel.id!.length;
    }
    memberState = (membersModel.status!.map((status) => !status).toList()).obs;
    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> toggleMembership(int index, bool value) async {
    searchOn.value = false;
    searchValue.value = "";
    isLoading.value = true;
    membershipValues[index] = value;
    if (AppConstant.chleesTest) {
      List<String> affiliation = [
        for (int i = 0; i < membershipLabels.length; i++)
          if (membershipValues[i]) membershipLabels[i]
      ];
      membersModel = await MembersRepository().get(MembersReqGet(
        page: 1,
        affiliation: affiliation,
        disabled: true,
      ).toJson());
    }
    memberState = (membersModel.status!.map((status) => !status).toList()).obs;
    activePage.value = 1;
    isLoading.value = false;
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;
    isLoading.value = true;
    if (AppConstant.chleesTest) {
      List<String> affiliation = [
        for (int i = 0; i < membershipLabels.length; i++)
          if (membershipValues[i]) membershipLabels[i]
      ];
      if (membershipValues.every((element) => element == true)) {
        affiliation = [];
      } //TODO remove later
      membersModel = await MembersRepository().get(MembersReqGet(
        page: 1,
        affiliation: affiliation,
        search: search,
        disabled: true,
      ).toJson());
    }
    memberState = (membersModel.status!.map((status) => !status).toList()).obs;
    activePage.value = 1;
    isLoading.value = false;
  }

  Future<void> loadNewPage(int pageNum) async {
    selectedMembers = List.generate(20, (_) => false).obs;
    List<String> affiliation = [
      for (int i = 0; i < membershipLabels.length; i++)
        if (membershipValues[i]) membershipLabels[i]
    ];
    if (membershipValues.every((element) => element == true)) {
      affiliation = [];
    } //TODO remove later
    if (AppConstant.chleesTest) {
      isLoading.value = true;
      membersModel = await MembersRepository().get(MembersReqGet(
              page: pageNum,
              disabled: true,
              search: searchOn.value == true ? searchValue.value : null,
              affiliation: affiliation)
          .toJson());
    }
    memberState = (membersModel.status!.map((status) => !status).toList()).obs;
    activePage.value = pageNum;
    isLoading.value = false;
  }

  void onMemberTap(String id) {
    if (Get.isRegistered<MemberDetailsController>()) {
      Get.delete<MemberDetailsController>();
    }
    Get.toNamed(AppRoutes.memberDetails, arguments: {RouteArguments.id: id});
  }

  void updateValue(int index) {
    selectedMembers[index] = !selectedMembers[index];
  }

  Future<void> onStatusChange(int index) async {
    isLoading.value = true;
    membersStatusModel = await MembersStatusRepository().put(
        MembersStatusReqPut(
                ids: [membersModel.id![index]], status: !memberState![index])
            .toJson());
    isLoading.value = false;
  }

  Future<void> onButtonPressed() async {
    List<String> ids = [
      for (int i = 0; i < membersModel.length; i++)
        if (selectedMembers[i]) membersModel.id![i]
    ];
    membersStatusModel = await MembersStatusRepository()
        .put(MembersStatusReqPut(ids: ids, status: false).toJson());
    if (membersStatusModel.isSuccess) {
      isLoading.value = true;
      selectedMembers = List.generate(20, (_) => false).obs;
      membersModel = await MembersRepository().get(MembersReqGet(
        page: 1,
        disabled: true,
      ).toJson());
      memberState =
          (membersModel.status!.map((status) => !status).toList()).obs;
      isLoading.value = false;
      isInited.value = true;
    }
  }
}

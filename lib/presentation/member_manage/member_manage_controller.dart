import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/members/members_model.dart';
import 'package:mindsight_admin_page/data/members/members_repository.dart';
import 'package:mindsight_admin_page/data/members/members_req_get.dart';
import 'package:mindsight_admin_page/data/members_status/members_status_model.dart';
import 'package:mindsight_admin_page/data/members_status/members_status_repository.dart';
import 'package:mindsight_admin_page/data/members_status/members_status_req_put.dart';

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

  late MembersModel membersModel;
  late MembersStatusModel membersStatusModel;

  RxList<bool> selectedMembers = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ].obs;
  RxList<bool>? memberState;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (AppConstant.chleesTest) {
      membersModel = await MembersRepository().get(MembersReqGet(
        page: 1,
        disabled: false,
      ).toJson());
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
        status: List.generate(10, (_) => true),
        number: 10,
      );
      membersModel.length = membersModel.id!.length;
    }
    memberState = membersModel.status!.obs;
    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> toggleMembership(int index, bool value) async {
    if (AppConstant.chleesTest) {
      List<String> affiliation = [
        for (int i = 0; i < membershipLabels.length; i++)
          if (membershipValues[i]) membershipLabels[i]
      ];
      membersModel = await MembersRepository().get(MembersReqGet(
        page: 1,
        affiliation: affiliation,
        disabled: false,
      ).toJson());
      memberState = membersModel.status!.obs;
    }
    activePage.value = 1;
    membershipValues[index] = value;
  }

  Future<void> onSearch({String? search}) async {
    if (AppConstant.chleesTest) {
      List<String> affiliation = [
        for (int i = 0; i < membershipLabels.length; i++)
          if (membershipValues[i]) membershipLabels[i]
      ];
      membersModel = await MembersRepository().get(MembersReqGet(
        page: 1,
        affiliation: affiliation,
        search: search,
        disabled: false,
      ).toJson());
      memberState = membersModel.status!.obs;
    }
    activePage.value = 1;
  }

  Future<void> loadNewPage(int pageNum) async {
    if (AppConstant.chleesTest) {
      membersModel = await MembersRepository().get(MembersReqGet(
        page: pageNum,
        disabled: false,
      ).toJson());
      memberState = membersModel.status!.obs;
    }
    activePage.value = pageNum;
  }

  void onMemberTap(String id) {
    Get.toNamed(AppRoutes.memberDetails, arguments: {RouteArguments.id: id});
  }

  void updateValue(int index) {
    selectedMembers[index] = !selectedMembers[index];
  }

  Future<void> onStatusChange(int index) async {
    membersStatusModel = await MembersStatusRepository().put(
        MembersStatusReqPut(
                ids: [membersModel.id![index]], status: memberState![index])
            .toJson());
    if (membersStatusModel.isSuccess) {
      isLoading.value = true;
      selectedMembers = [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
      ].obs;
      membersModel = await MembersRepository().get(MembersReqGet(
        page: 1,
        disabled: false,
      ).toJson());
      memberState = membersModel.status!.obs;
      isLoading.value = false;
      isInited.value = true;
    }
  }

  Future<void> onButtonPressed() async {
    List<String> ids = [
      for (int i = 0; i < membersModel.length; i++)
        if (selectedMembers[i]) membersModel.id![i]
    ];
    membersStatusModel = await MembersStatusRepository()
        .put(MembersStatusReqPut(ids: ids, status: false).toJson());
  }
}

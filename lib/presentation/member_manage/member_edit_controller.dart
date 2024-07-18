import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_repository.dart';
import 'package:mindsight_admin_page/data/members_data/members_data_model.dart';
import 'package:mindsight_admin_page/data/members_data/members_data_repository.dart';
import 'package:mindsight_admin_page/data/members_edit/members_edit_model.dart';
import 'package:mindsight_admin_page/data/members_edit/members_edit_repository.dart';
import 'package:mindsight_admin_page/data/members_edit/members_edit_req_put.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_details_controller.dart';

class MemberEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  List<String> membershipLabels = [
    "affiliation",
    "Nodamen",
    "UNHCR",
    "UN Women",
  ]; //TODO
  RxString affiliation = "".obs;
  RxString gender = "".obs;

  final TextEditingController yearController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  late MembersDataModel membersDataModel;
  late MembersEditModel membersEditModel;
  late AffiliationModel affiliationModel;

  MemberDetailsController memberDetailsController =
      Get.find<MemberDetailsController>();

  @override
  Future<void> onInit() async {
    super.onInit();
    if (AppConstant.chleesTest) {
      membersDataModel = await MembersDataRepository().get(id);
    } else {
      membersDataModel = MembersDataModel().copyWith(
        id: "",
        affiliation: "Nodamen",
        department: "Product Biz Dept.",
        position: "Team leader",
        firstName: "Aiden",
        lastName: "Kim",
        gender: "Male",
        yearOfBirth: 1992,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        username: "dbwjspdla",
        email: "akdlsemtkdlxm@nodamen.com",
        mindfulStreak: 16,
        mindfulDays: 421,
        sessionsCompleted: 34,
        minutesMeditated: 421,
      );
    }
    if (membersDataModel.affiliation == null) {
      affiliation = "".obs;
    } else {
      affiliation = membersDataModel.affiliation!.obs;
    }
    if (membersDataModel.gender == null) {
      gender = "".obs;
    } else {
      gender = membersDataModel.gender!.obs;
    }
    if (membersDataModel.firstName == null) {
      firstNameController.text = "";
    } else {
      firstNameController.text = membersDataModel.firstName!;
    }
    if (membersDataModel.lastName == null) {
      lastNameController.text = "";
    } else {
      lastNameController.text = membersDataModel.lastName!;
    }
    if (membersDataModel.department == null) {
      departmentController.text = "";
    } else {
      departmentController.text = membersDataModel.department!;
    }
    if (membersDataModel.position == null) {
      positionController.text = "";
    } else {
      positionController.text = membersDataModel.position!;
    }
    if (membersDataModel.yearOfBirth == null) {
      yearController.text = "";
    } else {
      yearController.text = membersDataModel.yearOfBirth!.toString();
    }
    affiliationModel = await AffiliationRepository().get(); //TODO
    membershipLabels = affiliationModel.affiliation!;

    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> saveChanges() async {
    if (AppConstant.chleesTest) {
      membersEditModel = await MembersEditRepository().put(
          id,
          MembersEditReqPut(
            affiliation: affiliation.value,
            department: departmentController.text,
            position: positionController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            gender: gender.value,
            yearOfBirth: int.parse(yearController.text),
          ).toJson());
    }
    memberDetailsController.loadData();
  }
}

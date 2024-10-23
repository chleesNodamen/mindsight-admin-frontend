import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
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
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    membersDataModel = await MembersDataRepository().get(id);
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
    affiliationModel = await AffiliationRepository().get();
    membershipLabels = affiliationModel.affiliation!;

    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> saveChanges() async {
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
        ));

    memberDetailsController.loadData();
  }
}

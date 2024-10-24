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
import 'package:mindsight_admin_page/function/show_simple_message.dart';

class MemberEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  List<String> membershipLabels = [
    "Nodamen",
    "UNHCR",
    "UN Women",
  ];
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

    membersDataModel = await MembersDataRepository().get(id);
    affiliation.value = membersDataModel.affiliation ?? "";
    gender.value = membersDataModel.gender ?? "";
    firstNameController.text = membersDataModel.firstName ?? "";
    lastNameController.text = membersDataModel.lastName ?? "";
    departmentController.text = membersDataModel.department ?? "";
    positionController.text = membersDataModel.position ?? "";
    yearController.text = membersDataModel.yearOfBirth?.toString() ?? "";

    affiliationModel = await AffiliationRepository().get();
    membershipLabels = affiliationModel.affiliation!;

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSaveChanges() async {
    isLoading.value = true;
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

    if (membersEditModel.isSuccess) {
      showSimpleMessage(Get.context!, "저장 되었습니다");
    } else {
      showSimpleMessage(Get.context!, "저장에 실패 하였습니다");
    }

    isLoading.value = false;
  }

  void goMemberDatailPage() {
    Get.offAllNamed(AppRoutes.memberDetails,
        arguments: {RouteArguments.id: id});
  }
}

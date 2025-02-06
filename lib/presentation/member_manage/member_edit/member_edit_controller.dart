import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/gender.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/member_detail/member_detail_model.dart';
import 'package:mindsight_admin_page/data/member_detail/member_detail_repository.dart';
import 'package:mindsight_admin_page/data/member_edit/member_edit_model.dart';
import 'package:mindsight_admin_page/data/member_edit/member_edit_repository.dart';
import 'package:mindsight_admin_page/data/member_edit/member_edit_req_put.dart';

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
  Rx<Gender?> gender = Rx<Gender?>(null);

  final TextEditingController yearController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  late MemberDetailModel membersDataModel;
  late MemberEditModel membersEditModel;
  late AffiliationModel affiliationModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  @override
  void onClose() {
    yearController.dispose();
    positionController.dispose();
    departmentController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    nicknameController.dispose();
  }

  Future<void> initData() async {
    isLoading.value = true;

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    membersDataModel = await MemberDetailRepository().get(id);
    affiliation.value = membersDataModel.affiliation ?? "";
    gender.value = Gender.fromKeyword(membersDataModel.gender);
    firstNameController.text = membersDataModel.firstName ?? "";
    lastNameController.text = membersDataModel.lastName ?? "";
    nicknameController.text = membersDataModel.username ?? "";
    departmentController.text = membersDataModel.department ?? "";
    positionController.text = membersDataModel.position ?? "";
    yearController.text = membersDataModel.yearOfBirth?.toString() ?? "";

    affiliationModel = await AffiliationRepository().get();
    membershipLabels = affiliationModel.affiliation!;

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;
    membersEditModel = await MemberEditRepository().put(
        id,
        MemberEditReqPut(
          affiliation: affiliation.value,
          department: departmentController.text,
          position: positionController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          username: nicknameController.text,
          gender: gender.value?.keywordName,
          yearOfBirth: int.parse(yearController.text),
        ));

    if (membersEditModel.isSuccess) {
      await showSimpleMessage("Saved successfully");
      Get.offAllNamed(AppRoutes.memberDetails,
          arguments: {RouteArguments.id: id});
    } else {
      showSimpleMessage("Save failed ${membersEditModel.getErrorMessage().tr}");
    }

    isLoading.value = false;
  }

  void goMemberDatailPage() {
    Get.offAllNamed(AppRoutes.memberDetails,
        arguments: {RouteArguments.id: id});
  }
}

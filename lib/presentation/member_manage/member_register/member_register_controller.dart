import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/gender.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_repository.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/member_register/member_register_repository.dart';
import 'package:mindsight_admin_page/data/member_register/member_register_req_post.dart';

class MemberRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late AffiliationModel affiliationModel;

  // late List<String> membershipLabels;

  RxString affiliation = "".obs;
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  Rx<Gender?> gender = Rx<Gender?>(Gender.nonbinary);
  final TextEditingController yearController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    yearController.dispose();
    positionController.dispose();
    departmentController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    affiliationModel = await AffiliationRepository().get();
    if (affiliationModel.affiliation != null) {
      affiliation.value = affiliationModel.affiliation![0];
    }

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    BaseModel model = await MemberRegisterRepository().post(
        MemberRegisterReqPost(
            affiliation: affiliation.value,
            department: departmentController.text,
            position: positionController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            gender: gender.value?.keywordName,
            yearOfBirth: int.parse(yearController.text),
            email: emailController.text));

    if (model.isSuccess) {
      // await showSimpleMessage("Saved successfully");
      Get.offAllNamed(AppRoutes.memberManage);
      SideMenuController.to
          .changeActiveSubItem(memberManagePageSubMenuDisplayName);
    } else {
      showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
    }

    isLoading.value = false;
  }
}

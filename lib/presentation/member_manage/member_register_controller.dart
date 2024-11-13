import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/gender.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/members_register/members_register_model.dart';
import 'package:mindsight_admin_page/data/members_register/members_register_repository.dart';
import 'package:mindsight_admin_page/data/members_register/members_register_req_post.dart';

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
  Rx<Gender?> gender = Rx<Gender?>(null);
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

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    affiliationModel = await AffiliationRepository().get();
    // membershipLabels = affiliationModel.affiliation!;

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    MembersRegisterModel model = await MembersRegisterRepository().post(
        MembersRegisterReqPost(
            affiliation: affiliation.value,
            department: departmentController.text,
            position: positionController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            gender: gender.value?.keywordName,
            yearOfBirth: int.parse(yearController.text),
            email: emailController.text));

    if (model.isSuccess) {
      showSimpleMessage(Get.context!, "저장 되었습니다");
    } else {
      showSimpleMessage(Get.context!, "저장에 실패 하였습니다");
    }

    isLoading.value = false;
  }
}

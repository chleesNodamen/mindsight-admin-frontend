import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/gender.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';

class MemberRegisterController extends GetxController {
  // final id = Get.arguments[RouteArguments.id];

  final id = "YJgrEkheVCbpnIwis2gYjg%3D%3D";

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  // late MembersDataModel membersDataModel;
  // late MembersEditModel membersEditModel;
  late AffiliationModel affiliationModel;

  late List<String> membershipLabels;
  RxString affiliation = "".obs;
  Rx<Gender?> gender = Rx<Gender?>(null);

  final TextEditingController yearController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
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

    // membersDataModel = await MembersDataRepository().get(id);
    // affiliation.value = membersDataModel.affiliation ?? "";
    // gender.value = membersDataModel.gender ?? "";
    // firstNameController.text = membersDataModel.firstName ?? "";
    // lastNameController.text = membersDataModel.lastName ?? "";
    // departmentController.text = membersDataModel.department ?? "";
    // positionController.text = membersDataModel.position ?? "";
    // yearController.text = membersDataModel.yearOfBirth?.toString() ?? "";
    // emailController.text = membersDataModel.email?.toString() ?? "";

    affiliationModel = await AffiliationRepository().get();
    membershipLabels = affiliationModel.affiliation!;

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;
    // membersEditModel = await MembersEditRepository().put(
    //     id,
    //     MembersEditReqPut(
    //       affiliation: affiliation.value,
    //       department: departmentController.text,
    //       position: positionController.text,
    //       firstName: firstNameController.text,
    //       lastName: lastNameController.text,
    //       gender: gender.value,
    //       yearOfBirth: int.parse(yearController.text),
    //     ));

    // if (membersEditModel.isSuccess) {
    //   showSimpleMessage(Get.context!, "저장 되었습니다");
    // } else {
    //   showSimpleMessage(Get.context!, "저장에 실패 하였습니다");
    // }

    isLoading.value = false;
  }
}

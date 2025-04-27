// import 'package:mindsight_admin_page/app_export.dart';
// import 'package:mindsight_admin_page/data/base_model.dart';
// import 'package:mindsight_admin_page/data/master_register/master_register_repository.dart';
// import 'package:mindsight_admin_page/data/master_register/master_register_req_post.dart';

// class MasterRegisterArgs {
//   final String email;

//   MasterRegisterArgs({required this.email});
// }

// class MasterRegisterController extends GetxController {
//   MasterRegisterArgs args = Get.arguments;

//   RxBool isLoading = true.obs;
//   RxBool isInited = false.obs;

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController primaryNicknameController =
//       TextEditingController();
//   final TextEditingController secodaryNicknameController =
//       TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController passwordCofirmController =
//       TextEditingController();
//   Rx<ContentLanguage?> selectedPrimaryLanguage =
//       Rx<ContentLanguage?>(ContentLanguage.english);
//   Rx<ContentLanguage?> selectedSecondaryLanguage = Rx<ContentLanguage?>(null);

//   List<ContentLanguage> languageLabels = ContentLanguage.values;

//   @override
//   void onClose() {
//     super.onClose();
//     emailController.dispose();
//     primaryNicknameController.dispose();
//     secodaryNicknameController.dispose();
//     passwordController.dispose();
//     passwordCofirmController.dispose();
//   }

//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     await initData();
//   }

//   Future<void> initData() async {
//     emailController.text = args.email;

//     isInited.value = true;
//     isLoading.value = false;
//   }

//   Future<void> onSignupComplete() async {
//     isLoading.value = true;

//     BaseModel model =
//         await MasterRegisterRepository().post(MasterRegisterReqPost(
//       email: emailController.text,
//       nickname: primaryNicknameController.text,
//       password: passwordController.text,
//       primaryLanguage: selectedPrimaryLanguage.value?.keywordName,
//       secondaryLanguage: selectedSecondaryLanguage.value?.keywordName,
//     ));

//     if (model.isSuccess) {
//       await showSimpleMessage("Success".tr);

//       if (Account.isLogined) {
//         Get.offAllNamed(AppRoutes.inactiveMasterManage);
//       } else {
//         Get.offAllNamed(AppRoutes.auth);
//       }
//     } else {
//       showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
//     }

//     isLoading.value = false;
//   }
// }

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_register/admin_register_model.dart';
import 'package:mindsight_admin_page/data/admin_register/admin_register_repository.dart';
import 'package:mindsight_admin_page/data/admin_register/admin_register_req_post.dart';

enum PasswordValidEnum { waiting, valid, invalid }

class SubAdminRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
  }

  // dropdown  button
  RxString selectedOrder = 'Select Option'.obs;
  void updateSelectedOrder(String newOrder) {
    selectedOrder.value = newOrder;
  }

  //
  RxBool isShowPasswordOne = true.obs;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController managerController = TextEditingController();
  final TextEditingController adminEmailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  late AdminRegisterModel adminRegisterModel;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Rx<PasswordValidEnum>> isPasswordValid = [
    PasswordValidEnum.waiting.obs,
    PasswordValidEnum.waiting.obs,
    PasswordValidEnum.waiting.obs
  ];

  // bool checkPasswordValid(String value, bool showInvalidRedColor) {
  //   _wordChecker.check(value);

  //   Logger.log("$value ${_wordChecker.is8Characters}");

  //   if (_wordChecker.is8Characters) {
  //     isPasswordValid[0].value = PasswordValidEnum.valid;
  //   } else {
  //     if (showInvalidRedColor) {
  //       isPasswordValid[0].value = PasswordValidEnum.invalid;
  //     } else {
  //       isPasswordValid[0].value = PasswordValidEnum.waiting;
  //     }
  //   }

  //   if (_wordChecker.isUpperLowerLetter) {
  //     isPasswordValid[1].value = PasswordValidEnum.valid;
  //   } else {
  //     if (showInvalidRedColor) {
  //       isPasswordValid[1].value = PasswordValidEnum.invalid;
  //     } else {
  //       isPasswordValid[1].value = PasswordValidEnum.waiting;
  //     }
  //   }

  //   if (_wordChecker.is1Symbol) {
  //     isPasswordValid[2].value = PasswordValidEnum.valid;
  //   } else {
  //     if (showInvalidRedColor) {
  //       isPasswordValid[2].value = PasswordValidEnum.invalid;
  //     } else {
  //       isPasswordValid[2].value = PasswordValidEnum.waiting;
  //     }
  //   }

  //   return _wordChecker.is8Characters &&
  //       _wordChecker.isUpperLowerLetter &&
  //       _wordChecker.is1Symbol;
  // }

  Future<void> saveChanges() async {
    adminRegisterModel =
        await AdminRegisterRepository().post(AdminRegisterReqPost(
      id: 'id',
      email: idController.text,
      password: passwordController.text,
      department: departmentController.text,
      role: selectedOrder.value,
      manager: managerController.text,
      phone: phoneController.text,
      adminEmail: adminEmailController.text,
    ).toJson());

    if (adminRegisterModel.isSuccess) {
      Get.toNamed(AppRoutes.subAdminSettings);
    }
  }
}

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_register/admin_register_model.dart';
import 'package:mindsight_admin_page/data/admin_register/admin_register_repository.dart';
import 'package:mindsight_admin_page/data/admin_register/admin_register_req_post.dart';

enum PasswordValidEnum { waiting, valid, invalid }

class SubAdminRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late AdminRegisterModel adminRegisterModel;

  RxBool isShowPasswordOne = true.obs;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController managerController = TextEditingController();
  final TextEditingController adminEmailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Rx<PasswordValidEnum>> isPasswordValid = [
    PasswordValidEnum.waiting.obs,
    PasswordValidEnum.waiting.obs,
    PasswordValidEnum.waiting.obs
  ];

  RxString selectedOrder = 'Select Option'.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    isInited.value = true;
    isLoading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
  }

  void updateSelectedOrder(String newOrder) {
    selectedOrder.value = newOrder;
  }

  Future<void> onSave() async {
    isLoading.value = true;

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
    ));

    isLoading.value = false;

    if (adminRegisterModel.isSuccess) {
      showSimpleMessage(Get.context!, "저장 되었습니다");
    } else {
      showSimpleMessage(Get.context!, "저장에 실패 하였습니다");
    }
  }
}

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/route_arguments.dart';
import 'package:mindsight_admin_page/data/admin_details/admin_details_model.dart';
import 'package:mindsight_admin_page/data/admin_details/admin_details_repository.dart';

class SubAdminEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late AdminDetailsModel adminDetailsModel;
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController managerController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController adminEmailController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    if (AppConstant.chleesTest) {
      adminDetailsModel = await AdminDetailsRepository().get(id);
    }
    departmentController.text = adminDetailsModel.department!;
    managerController.text = adminDetailsModel.manager!;
    phoneController.text = adminDetailsModel.phone!;
    adminEmailController.text = adminDetailsModel.adminEmail!;

    isLoading.value = false;
    isInited.value = true;
  }
}

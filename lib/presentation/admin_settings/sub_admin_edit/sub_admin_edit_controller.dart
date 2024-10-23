import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/route_arguments.dart';
import 'package:mindsight_admin_page/data/admin_details/admin_details_model.dart';
import 'package:mindsight_admin_page/data/admin_details/admin_details_repository.dart';
import 'package:mindsight_admin_page/data/admin_edit/admin_edit_model.dart';
import 'package:mindsight_admin_page/data/admin_edit/admin_edit_repository.dart';
import 'package:mindsight_admin_page/data/admin_edit/admin_edit_req_put.dart';

class SubAdminEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late AdminEditModel adminEditModel;
  late AdminDetailsModel adminDetailsModel;

  final TextEditingController departmentController = TextEditingController();
  final TextEditingController managerController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController adminEmailController = TextEditingController();

  RxString selectedOrder = ''.obs;
  void updateSelectedOrder(String newOrder) {
    selectedOrder.value = newOrder;
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    adminDetailsModel = await AdminDetailsRepository().get(id);

    departmentController.text = adminDetailsModel.department!;
    managerController.text = adminDetailsModel.manager!;
    phoneController.text = adminDetailsModel.phone!;
    adminEmailController.text = adminDetailsModel.adminEmail!;
    selectedOrder.value = adminDetailsModel.role!;

    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> saveChanges() async {
    adminEditModel = await AdminEditRepository().put(
        id,
        AdminEditReqPut(
          department: departmentController.text,
          role: selectedOrder.value,
          manager: managerController.text,
          phone: phoneController.text,
          adminEmail: adminEmailController.text,
        ));

    if (adminEditModel.isSuccess) {
      Get.offAllNamed(AppRoutes.subAdminSettings);
    }
  }
}

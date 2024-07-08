import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_details/admin_details_model.dart';
import 'package:mindsight_admin_page/data/admin_details/admin_details_repository.dart';

class SubAdminDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late AdminDetailsModel adminDetailsModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (AppConstant.chleesTest) {
      adminDetailsModel = await AdminDetailsRepository().get(id);
    }

    isLoading.value = false;
    isInited.value = true;
  }

  void goToEdit() {
    Get.toNamed(AppRoutes.subAdminEdit, arguments: {
      RouteArguments.id: adminDetailsModel.id,
    });
  }
}

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

    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    adminDetailsModel = await AdminDetailsRepository().get(id);

    isInited.value = true;
    isLoading.value = false;
  }

  void onEdit() {
    Get.offAllNamed(AppRoutes.subAdminEdit, arguments: {
      RouteArguments.id: id,
    });
  }
}

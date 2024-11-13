import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/company_data/company_data_model.dart';
import 'package:mindsight_admin_page/data/company_data/company_data_repository.dart';

class CompanyDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late CompanyDataModel companyDataModel;

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

    companyDataModel = await CompanyDataRepository().get(id);

    isLoading.value = false;
    isInited.value = true;
  }

  void onEdit() {
    Get.offAllNamed(AppRoutes.companyEdit, arguments: {RouteArguments.id: id});
  }

  void onList() {
    if (SideMenuController.to.isActiveSubItem("회사 목록")) {
      Get.offAllNamed(AppRoutes.companyManage);
    } else {
      Get.offAllNamed(AppRoutes.inactiveCompanyManage);
    }
  }
}

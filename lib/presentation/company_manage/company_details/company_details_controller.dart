import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/company_detail/company_detail_model.dart';
import 'package:mindsight_admin_page/data/company_detail/company_detail_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';

class CompanyDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late CompanyDetailModel companyDetailModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    companyDetailModel = await CompanyDetailRepository().get(id);

    isLoading.value = false;
    isInited.value = true;
  }

  void onEdit() {
    Get.offAllNamed(AppRoutes.companyEdit, arguments: {RouteArguments.id: id});
  }

  void onList() {
    if (Account.isAdmin) {
      if (SideMenuController.to.isActiveSubItem("Company list")) {
        Get.offAllNamed(AppRoutes.companyManage);
      } else {
        Get.offAllNamed(AppRoutes.inactiveCompanyManage);
      }
    } else {
      Get.offAllNamed(AppRoutes.companyManage);
    }
  }
}

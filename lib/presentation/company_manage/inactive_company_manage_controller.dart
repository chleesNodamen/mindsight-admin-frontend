import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/company_list/company_list_model.dart';
import 'package:mindsight_admin_page/data/company_list/company_list_repository.dart';
import 'package:mindsight_admin_page/data/company_list/company_list_req_get.dart';
import 'package:mindsight_admin_page/data/company_verified/company_verified_repository.dart';
import 'package:mindsight_admin_page/data/company_verified/company_verified_req_put.dart';

class InactiveCompanyManageController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late CompanyListModel companyListModel;

  RxInt activePage = 1.obs;
  RxBool searchOn = false.obs;
  RxString searchValue = "".obs;

  RxList<bool> selectedCompany = List.generate(20, (_) => false).obs;
  RxList<bool>? companyVerified;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    searchOn = false.obs;
    searchValue = "".obs;
    activePage = 1.obs;

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    await loadPage(1);

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSearch(String? search) async {
    searchOn.value = true;
    searchValue.value = search!;

    await loadPage(1);
  }

  Future<void> loadPage(int pageNum) async {
    isLoading.value = true;

    selectedCompany = List.generate(20, (_) => false).obs;

    companyListModel = await CompanyListRepository().get(CompanyListReqGet(
      page: pageNum,
      verified: false,
      search: searchOn.value == true ? searchValue.value : null,
    ));

    companyVerified =
        (companyListModel.verified!.map((verified) => verified).toList()).obs;
    activePage.value = pageNum;

    isLoading.value = false;
  }

  void onCompanyTap(String id) {
    Get.offAllNamed(AppRoutes.memberDetails,
        arguments: {RouteArguments.id: id});
  }

  void onSelectedCompany(int index) {
    selectedCompany[index] = !selectedCompany[index];
  }

  Future<void> onVerifiedChange(int index) async {
    isLoading.value = true;

    Logger.info(companyVerified![index]);

    BaseModel model = await CompanyVerifiedRepository().put(
        CompanyVerifiedReqPut(
            ids: [companyListModel.id![index]],
            verified: companyVerified![index]));

    if (model.isSuccess) {
      await loadPage(1);
    }

    isLoading.value = false;
  }

  Future<void> onVerifiedButton() async {
    isLoading.value = true;

    List<String> ids = [
      for (int i = 0; i < companyListModel.total!; i++)
        if (selectedCompany[i]) companyListModel.id![i]
    ];
    BaseModel model = await CompanyVerifiedRepository()
        .put(CompanyVerifiedReqPut(ids: ids, verified: true));

    if (model.isSuccess) {
      await loadPage(1);
    }

    isLoading.value = false;
  }
}

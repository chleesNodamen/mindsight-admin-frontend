import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/contry.dart';
import 'package:mindsight_admin_page/data/master_detail/master_detail_model.dart';
import 'package:mindsight_admin_page/data/master_detail/master_detail_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';

class MasterDetailsController extends GetxController {
  // final id = Get.arguments[RouteArguments.id];
  late String id;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late MasterDetailModel masterDetailModel;

  late Contry contry;
  late ContentLanguage primaryLanguage;
  ContentLanguage secondaryLanguage = ContentLanguage.english;

  @override
  Future<void> onInit() async {
    super.onInit();

    if (Get.arguments == null) {
      id = Account.id;
    } else {
      id = Get.arguments[RouteArguments.id];
    }

    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    masterDetailModel = await MasterDetailRepository().get(id);

    contry = Contry.fromKeyword(masterDetailModel.country);
    primaryLanguage =
        ContentLanguage.fromKeyword(masterDetailModel.primaryLanguage);
    if (masterDetailModel.secondaryLanguage != null) {
      secondaryLanguage =
          ContentLanguage.fromKeyword(masterDetailModel.secondaryLanguage!);
    }

    isLoading.value = false;
    isInited.value = true;
  }

  void onMasterEdit() {
    Get.offAllNamed(AppRoutes.masterEdit, arguments: {RouteArguments.id: id});
  }

  void onMasterList() {
    if (SideMenuController.to.isActiveSubItem("Master list")) {
      Get.offAllNamed(AppRoutes.masterManage);
    } else {
      Get.offAllNamed(AppRoutes.inactiveMasterManage);
    }
  }
}

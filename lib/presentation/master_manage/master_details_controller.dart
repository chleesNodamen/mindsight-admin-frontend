import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/members_data/members_data_model.dart';
import 'package:mindsight_admin_page/data/members_data/members_data_repository.dart';

class MasterDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  final String dash = "-";
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  RxString lastName = "".obs;

  late MembersDataModel membersDataModel;

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

    membersDataModel = await MembersDataRepository().get(id);
    lastName.value = membersDataModel.lastName ?? dash;
    isLoading.value = false;
    isInited.value = true;
  }

  void onMasterEdit() {
    Get.offAllNamed(AppRoutes.masterEdit, arguments: {RouteArguments.id: id});
  }

  void onMasterList() {
    if (SideMenuController.to.isActiveSubItem("마스터 목록")) {
      Get.offAllNamed(AppRoutes.masterManage);
    } else {
      Get.offAllNamed(AppRoutes.inactiveMasterManage);
    }
  }
}

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_signin_nouse/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_signin_nouse/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/member_detail/member_detail_model.dart';
import 'package:mindsight_admin_page/data/member_detail/member_detail_repository.dart';

class MemberDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  final String dash = "";
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  RxString lastName = "".obs;

  late MemberDetailModel membersDataModel;

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

    membersDataModel = await MemberDetailRepository().get(id);
    lastName.value = membersDataModel.lastName ?? dash;
    isLoading.value = false;
    isInited.value = true;
  }

  void onMemberEdit() {
    Get.offAllNamed(AppRoutes.memberEdit, arguments: {RouteArguments.id: id});
  }

  void onMemberList() {
    if (SideMenuController.to.isActiveSubItem("Member list")) {
      Get.offAllNamed(AppRoutes.memberManage);
    } else {
      Get.offAllNamed(AppRoutes.inactiveMemberManage);
    }
  }
}

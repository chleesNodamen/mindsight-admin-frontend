import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/members_detail/members_detail_model.dart';
import 'package:mindsight_admin_page/data/members_detail/members_detail_repository.dart';

class MemberDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  final String dash = "-";
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  RxString lastName = "".obs;

  late MembersDetailModel membersDataModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    if (AppConstant.test) {
      await MasterSigninRepository().post(MasterSigninReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    membersDataModel = await MembersDetailRepository().get(id);
    lastName.value = membersDataModel.lastName ?? dash;
    isLoading.value = false;
    isInited.value = true;
  }

  void onMemberEdit() {
    Get.offAllNamed(AppRoutes.memberEdit, arguments: {RouteArguments.id: id});
  }

  void onMemberList() {
    if (SideMenuController.to.isActiveSubItem("회원 목록")) {
      Get.offAllNamed(AppRoutes.memberManage);
    } else {
      Get.offAllNamed(AppRoutes.inactiveMemberManage);
    }
  }
}

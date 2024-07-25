import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/members_data/members_data_model.dart';
import 'package:mindsight_admin_page/data/members_data/members_data_repository.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_edit_controller.dart';

class MemberDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  String dash = "-";
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  RxString lastName = "".obs;

  late MembersDataModel membersDataModel;

  @override
  Future<void> onInit() async {
    loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;
    membersDataModel = await MembersDataRepository().get(id);
    lastName.value =
        (membersDataModel.lastName == null || membersDataModel.lastName == "")
            ? "-"
            : membersDataModel.lastName!;
    isLoading.value = false;
    isInited.value = true;
  }

  void onMemberEdit() {
    if (Get.isRegistered<MemberEditController>()) {
      Get.delete<MemberEditController>();
    }
    Get.toNamed(AppRoutes.memberEdit, arguments: {RouteArguments.id: id});
  }
}

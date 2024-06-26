import 'package:mindsight_admin_page/app_export.dart';

class MemberManageController extends GetxController {
  static MemberManageController get to => Get.find<MemberManageController>();
  List<String> membershipLabels = [
    "Nodamen",
    "UNHCR",
    "UN Women",
  ];
  RxInt activePage = 1.obs;
  RxList<bool> membershipValues = List<bool>.filled(3, true).obs;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }

  void toggleMembership(int index, bool value) {
    membershipValues[index] = value;
  }

  void loadNewPage(int pageNum) {
    activePage.value = pageNum;
  }

  void onMemberTap() {
    Get.toNamed(AppRoutes.memberDetails);
  }
}

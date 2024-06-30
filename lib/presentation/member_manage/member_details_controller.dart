import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/members_data/members_data_model.dart';
import 'package:mindsight_admin_page/data/members_data/members_data_repository.dart';

class MemberDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late MembersDataModel membersDataModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (AppConstant.chleesTest) {
      membersDataModel = await MembersDataRepository().get(id);
    } else {
      membersDataModel = MembersDataModel().copyWith(
        id: "",
        affiliation: "Nodamen",
        department: "Product Biz Dept.",
        position: "Team leader",
        firstName: "Aiden",
        lastName: "Kim",
        gender: "Male",
        yearOfBirth: "1992",
        createdAt: "2024-04-25",
        lastLogin: "2024-03-13-10:09:34",
        username: "dbwjspdla",
        email: "akdlsemtkdlxm@nodamen.com",
        mindfulStreak: 16,
        mindfulDays: 421,
        sessionsCompleted: 34,
        minutesMeditated: 421,
      );
    }

    isLoading.value = false;
    isInited.value = true;
  }

  void onMemberEdit() {
    Get.toNamed(AppRoutes.memberEdit, arguments: {RouteArguments.id: id});
  }
}

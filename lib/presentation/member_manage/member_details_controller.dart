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
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        username: "dbwjspdla",
        email: "akdlsemtkdlxm@nodamen.com",
        mindfulStreak: 16,
        mindfulDays: 421,
        sessionsCompleted: 34,
        minutesMeditated: 421,
      );
    }
    print(membersDataModel.email!);
    print(membersDataModel.id!);
    super.onInit();
    isLoading.value = false;
    isInited.value = true;
  }

  void onMemberEdit() {
    Get.toNamed(AppRoutes.memberEdit, arguments: {RouteArguments.id: id});
  }
}

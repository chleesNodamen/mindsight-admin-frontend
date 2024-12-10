import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_details_model.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_details_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';

class ChallengeDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late ChallengeDetailsModel challengeDetailsModel;

  RxInt selectedDay = 1.obs;

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

    challengeDetailsModel = await ChallengeDetailsRepository().get(id);

    isLoading.value = false;
    isInited.value = true;
  }

  void onEdit() {
    Get.offAllNamed(AppRoutes.challengeEdit, arguments: {
      RouteArguments.id: id,
    });
  }

  void updateSelectedDay(int day) {
    selectedDay.value = day;
  }
}

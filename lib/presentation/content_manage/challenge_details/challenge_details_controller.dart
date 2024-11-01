import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_details_model.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_details_repository.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class ChallengeDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late ChallengeDetailsModel challengeDetailsModel;

  // RxString thumbnailLink = "".obs;
  RxInt selectedDay = 1.obs;

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

  void downloadFile(String url) {
    // url = Uri.parse(url);
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }
}

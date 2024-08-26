import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_details_model.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_details_repository.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_edit/challenge_edit_controller.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class ChallengeDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  RxString thumbnailLink = "".obs;
  late ChallengeDetailsModel challengeDetailsModel;
  RxInt selectedDay = 1.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;
    if (AppConstant.chleesTest) {
      challengeDetailsModel = await ChallengeDetailsRepository().get(id);
    }
    if (challengeDetailsModel.isSuccess) {
      thumbnailLink.value = challengeDetailsModel.thumbnail ?? "";
      print(challengeDetailsModel.days);
      // print("initialized");
    }
    isLoading.value = false;
    isInited.value = true;
  }

  var numbers = List.generate(30, (index) => index + 1).obs;

  void goToEdit() {
    if (Get.isRegistered<ChallengeEditController>()) {
      Get.delete<ChallengeEditController>();
    }
    Get.toNamed(AppRoutes.challengeEdit, arguments: {
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

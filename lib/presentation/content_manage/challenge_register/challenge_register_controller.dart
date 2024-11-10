// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';

class ChallengeRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  RxInt selectedDay = 1.obs;
  File? thumbnailFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController introController = TextEditingController();

  RxString selectedGoal = "".obs;

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

    isLoading.value = false;
    isInited.value = true;
  }

  void updateSelectedDay(int day) {
    selectedDay.value = day;
  }

  Future<void> onSave() async {}

  void pickFile(String type) async {}
}

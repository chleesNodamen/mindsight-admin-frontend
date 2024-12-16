import 'dart:html';

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/goal.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/challenge_register/challenge_register_repository.dart';
import 'package:mindsight_admin_page/data/challenge_register/challenge_register_req_put.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';

class ChallengeRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController introController = TextEditingController();
  TextEditingController dayNameController = TextEditingController();

  Rx<Goal> selectedGoal = Rx<Goal>(Goal.improveHealth);
  RxInt selectedPeriod = 7.obs;
  RxInt selectedDay = 1.obs;
  List<String> dayName = List.generate(31, (_) => '');
  List<String> dayContentName0 = List.generate(31, (_) => '');
  List<String> dayContentName1 = List.generate(31, (_) => '');
  List<String> dayContentId0 = List.generate(31, (_) => '');
  List<String> dayContentId1 = List.generate(31, (_) => '');
  Rx<File?> thumbnailFile = Rx<File?>(null);
  RxString seletedDayContentName0 = "".obs;
  RxString seletedDayContentName1 = "".obs;

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

    isLoading.value = false;
    isInited.value = true;
  }

  void updateSelectedDay(int day) {
    dayName[selectedDay.value] = dayNameController.text;

    selectedDay.value = day;
    dayNameController.text = dayName[day];
    seletedDayContentName0.value = dayContentName0[day];
    seletedDayContentName1.value = dayContentName1[day];
  }

  Future<void> onSave() async {
    isLoading.value = true;

    String? thumbUrl;

    if (thumbnailFile.value != null) {
      thumbUrl =
          (await UploadRepository().uploadFile(thumbnailFile.value!)).url;
    }

    if (thumbUrl == null) {
      isLoading.value = false;
      showSimpleMessage("썸네일 파일이 잘못되었습니다.");
      return;
    }

    List<ChallengeRegisterDay> challengeDays =
        List.generate(selectedPeriod.value, (index) {
      return ChallengeRegisterDay(
        day: index + 1,
        name: dayName[index + 1],
        contentIds: [dayContentId0[index + 1], dayContentId1[index + 1]],
      );
    });

    BaseModel model = await ChallengeRegisterRepository().post(
        ChallengeRegisterReqPost(
            name: nameController.text,
            goal: selectedGoal.value.keywordName,
            intro: introController.text,
            image: thumbUrl,
            days: selectedPeriod.value,
            challengeDays: challengeDays));

    isLoading.value = false;

    if (model.isSuccess) {
      await showSimpleMessage("저장 되었습니다");
      Get.offAllNamed(AppRoutes.contentPracticeManage);
    } else {
      showSimpleMessage("저장에 실패 하였습니다. ${model.getErrorMessage().tr}");
    }
  }

  void onPickThumbnail(File? pickedFile) {
    if (pickedFile != null) {
      thumbnailFile.value = pickedFile;
    }
  }

  void onSelectBody(String? name, String? id) {
    if (name != null && id != null) {
      dayContentName0[selectedDay.value] = name;
      dayContentId0[selectedDay.value] = id;
    }
  }

  void onSelectBreath(String? name, String? id) {
    if (name != null && id != null) {
      dayContentName1[selectedDay.value] = name;
      dayContentId1[selectedDay.value] = id;
    }
  }
}

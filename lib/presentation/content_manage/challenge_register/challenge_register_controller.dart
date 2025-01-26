import 'dart:html';

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/goal.dart';
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
  RxInt selectedDay = 0.obs;
  List<String> dayName = List.generate(30, (_) => '');
  List<String> dayContentName0 = List.generate(30, (_) => '');
  List<String> dayContentName1 = List.generate(30, (_) => '');
  List<String> dayContentId0 = List.generate(30, (_) => '');
  List<String> dayContentId1 = List.generate(30, (_) => '');
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

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

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
    dayName[selectedDay.value] = dayNameController.text;

    List<ChallengeRegisterDay> challengeDays =
        List.generate(selectedPeriod.value, (index) {
      return ChallengeRegisterDay(
        day: index + 1,
        name: dayName[index],
        contentIds: [dayContentId0[index], dayContentId1[index]],
      );
    });

    for (int i = 0; i < challengeDays.length; i++) {
      if (challengeDays[i].name.isEmpty) {
        showSimpleMessage("Settings 되지 않은 Content title이 있습니다.");
        return;
      }
    }
    for (int i = 0; i < challengeDays.length; i++) {
      Logger.info(challengeDays[i].contentIds);

      if (!challengeDays[i].isValidContentIds()) {
        showSimpleMessage("Settings 되지 않은 Content가 있습니다.");
        return;
      }
    }

    isLoading.value = true;

    String? thumbUrl;

    if (thumbnailFile.value != null) {
      thumbUrl = BlobNameGenerator.generateBlobName(thumbnailFile.value!);
    }

    BaseModel model = await ChallengeRegisterRepository().post(
        ChallengeRegisterReqPost(
            name: nameController.text,
            goal: selectedGoal.value.keywordName,
            intro: introController.text,
            image: thumbUrl!,
            days: selectedPeriod.value,
            challengeDays: challengeDays));

    isLoading.value = false;

    if (model.isSuccess) {
      if (thumbnailFile.value != null) {
        await UploadRepository()
            .uploadFile(thumbnailFile.value!, blobName: thumbUrl);
      }

      await showSimpleMessage("Saved successfully");
      Get.offAllNamed(AppRoutes.contentChallengeManage);
    } else {
      showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
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

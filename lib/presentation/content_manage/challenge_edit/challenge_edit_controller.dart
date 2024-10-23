// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:file_picker/file_picker.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_detail_days.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_details_model.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_details_repository.dart';
import 'package:mindsight_admin_page/data/challenge_edit/challenge_edit_model.dart';
import 'package:mindsight_admin_page/data/challenge_edit/challenge_edit_repository.dart';
import 'package:mindsight_admin_page/data/challenge_edit/challenge_edit_req_put.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage/challenge_manage_controller.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_details/challenge_details_controller.dart';

class ChallengeEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  RxInt selectedDay = 1.obs;

  File? thumbnailFile;
  String? thumbnailUrl;
  RxString thumbnailName = "".obs;

  late ChallengeEditModel challengeEditModel;
  late ChallengeDetailsModel challengeDetailsModel;

  TextEditingController nameController = TextEditingController();
  TextEditingController introController = TextEditingController();

  var selectedGoal = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    isInited.value = false;

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    challengeDetailsModel = await ChallengeDetailsRepository().get(id);

    if (challengeDetailsModel.isSuccess) {
      nameController.text = challengeDetailsModel.name ?? "";
      introController.text = challengeDetailsModel.intro ?? "";
      selectedGoal.value = challengeDetailsModel.goal ?? "";
    }
    isLoading.value = false;
    isInited.value = true;
  }

  ChallengeDetailDays get selectedDayDetails {
    return challengeDetailsModel.days!
        .firstWhere((dayDetail) => dayDetail.day == selectedDay.value);
  }

  void updateSelectedDay(int day) {
    selectedDay.value = day;
  }

  void goToChallenge() {
    Get.offAllNamed(AppRoutes.contentChallengeManage);
    if (Get.isRegistered<ChallengeManageController>()) {
      Get.find<ChallengeManageController>().loadData();
    }
  }

  Future<void> saveChanges() async {
    if (thumbnailFile != null) {
      thumbnailUrl = await UploadRepository().uploadFile(thumbnailFile!);
    }
    challengeEditModel = await ChallengeEditRepository().put(
        id,
        ChallengeEditReqPut(
          name: nameController.text,
          goal: selectedGoal.value,
          intro: introController.text,
          // days: challengeDetailsModel.days, //TODO update names for daysr
          thumbnail: thumbnailUrl ?? challengeDetailsModel.thumbnail,
        ));
    if (challengeEditModel.isSuccess) {
      if (Get.isRegistered<ChallengeDetailsController>()) {
        Get.delete<ChallengeDetailsController>();
      }
      Get.offAllNamed(AppRoutes.practiceDetails,
          arguments: {RouteArguments.id: id});
    }
  }

  void pickFile(String type) async {
    List<String> extensions = ['jpg'];

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      thumbnailName.value = file.name;
      thumbnailFile = File([file.bytes!], file.name);
    } else {
      return;
    }
  }
}

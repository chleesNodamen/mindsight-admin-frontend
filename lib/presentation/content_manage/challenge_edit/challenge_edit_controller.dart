// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/goal.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_details_model.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_details_repository.dart';
import 'package:mindsight_admin_page/data/challenge_edit/challenge_edit_repository.dart';
import 'package:mindsight_admin_page/data/challenge_edit/challenge_edit_req_put.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';

class ChallengeEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late ChallengeDetailsModel challengeDetailsModel;

  Rx<Goal> selectedGoal = Rx<Goal>(Goal.improveHealth);
  RxInt selectedDay = 1.obs;
  File? thumbnailFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController introController = TextEditingController();
  TextEditingController dayNameController = TextEditingController();

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

    if (challengeDetailsModel.isSuccess) {
      nameController.text = challengeDetailsModel.name ?? "";
      introController.text = challengeDetailsModel.intro ?? "";
      selectedGoal.value = Goal.fromKeyword(challengeDetailsModel.goal!);

      dayNameController.text = challengeDetailsModel.days![0].name!;
    }

    isLoading.value = false;
    isInited.value = true;
  }

  ChallengeDetailDay get selectedDayDetail {
    return challengeDetailsModel.days!
        .firstWhere((dayDetail) => dayDetail.day == selectedDay.value);
  }

  void updateSelectedDay(int day) {
    challengeDetailsModel.days![selectedDay.value - 1].name =
        dayNameController.text;

    selectedDay.value = day;
    dayNameController.text = challengeDetailsModel.days![day - 1].name!;
  }

  Future<void> onSave() async {
    if (thumbnailFile != null) {
      challengeDetailsModel.thumbnail =
          (await UploadRepository().uploadFile(thumbnailFile!)).url;
    }

    List<ChallengeEditDay> challengeDays =
        challengeDetailsModel.days?.map((detailDay) {
              return ChallengeEditDay(
                id: detailDay.id!,
                day: detailDay.day!,
                name: detailDay.name!,
              );
            }).toList() ??
            [];

    BaseModel model = await ChallengeEditRepository().put(
        id,
        ChallengeEditReqPut(
          name: nameController.text,
          goal: selectedGoal.value.keywordName,
          intro: introController.text,
          challengeDays: challengeDays,
          image: challengeDetailsModel.thumbnail,
          status: challengeDetailsModel.status,
          exposure: challengeDetailsModel.exposure,
        ));

    if (model.isSuccess) {
      await showSimpleMessage("저장 되었습니다.");
      Get.offAllNamed(AppRoutes.challengeDetails,
          arguments: {RouteArguments.id: id});
    } else {
      await showSimpleMessage("저장에 실패 하였습니다.");
    }
  }

  void onPickThumbnail(File? pickedFile) {
    if (pickedFile != null) {
      thumbnailFile = pickedFile;
    }
  }
}

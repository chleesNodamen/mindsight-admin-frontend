import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/practice_details/practice_details_model.dart';
import 'package:mindsight_admin_page/data/practice_details/practice_details_repository.dart';
import 'package:mindsight_admin_page/data/practice_edit/practice_edit_repository.dart';
import 'package:mindsight_admin_page/data/practice_edit/practice_edit_req_put.dart';
import 'package:mindsight_admin_page/function/show_content_select_dialog.dart';

class PracticeEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late PracticeDetailsModel practiceDetailsModel;

  RxString selectedBodyName = "".obs;
  String? selectedBodyId;
  RxString selectedBreathName = "".obs;
  String? selectedBreathId;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;
    isInited.value = false;

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    practiceDetailsModel = await PracticeDetailsRepository().get(id);

    if (practiceDetailsModel.isSuccess) {
      selectedBodyName.value = practiceDetailsModel.body!;
      selectedBreathName.value = practiceDetailsModel.breath!;
    }
    isLoading.value = false;
    isInited.value = true;
  }

  void goPracticeDetails() {
    Get.offAllNamed(AppRoutes.practiceDetails,
        arguments: {RouteArguments.id: id});
  }

  Future<void> onSave() async {
    isLoading.value = true;

    BaseModel practiceEditModel = await PracticeEditRepository().put(
        id,
        PracticeEditReqPut(
          bodyId: selectedBodyId,
          breathId: selectedBreathId,
          status: practiceDetailsModel.status,
          exposure: practiceDetailsModel.exposure,
        ));

    isLoading.value = false;

    if (practiceEditModel.isSuccess) {
      await showSimpleMessage("Saved successfully");
      Get.offAllNamed(AppRoutes.practiceDetails,
          arguments: {RouteArguments.id: id});
    } else {
      showSimpleMessage(
          "Save failed ${practiceEditModel.getErrorMessage().tr}");
    }
  }

  Future<void> onSelectBody() async {
    var result = await showContentSelectDialog(ContentCategory.body);

    if (result != null) {
      selectedBodyName.value = result["name"]!;
      selectedBodyId = result["id"]!;
    }
  }

  Future<void> onSelectBreath() async {
    var result = await showContentSelectDialog(ContentCategory.breath);
    if (result != null) {
      selectedBreathName.value = result["name"]!;
      selectedBreathId = result["id"]!;
    }
  }
}

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/practice_register/practice_register_repository.dart';
import 'package:mindsight_admin_page/data/practice_register/practice_register_req_post.dart';
import 'package:mindsight_admin_page/function/show_content_select_dialog.dart';

class PracticeRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  RxString selectedBodyName = "".obs;
  String? selectedBodyId;
  RxString selectedBreathName = "".obs;
  String? selectedBreathId;

  @override
  Future<void> onInit() async {
    super.onInit();

    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> onSave() async {
    if (selectedBodyId == null || selectedBreathId == null) {
      showSimpleMessage("Content를 선택 해 주십시오");
      return;
    }

    isLoading.value = true;

    BaseModel model = await PracticesRegisterRepository().post(
        PracticesRegisterReqPost(
            bodyId: selectedBodyId, breathId: selectedBreathId));

    isLoading.value = false;

    if (model.isSuccess) {
      await showSimpleMessage("Saved successfully");
      Get.offAllNamed(AppRoutes.contentPracticeManage);
    } else {
      showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
    }
  }

  Future<void> onSelectBody(String? name, String? id) async {
    if (name != null && id != null) {
      selectedBodyName.value = name;
      selectedBodyId = id;

      Logger.info(name);
      Logger.info(id);
    }
  }

  Future<void> onSelectBreath(String? name, String? id) async {
    if (name != null && id != null) {
      selectedBreathName.value = name;
      selectedBreathId = id;

      Logger.info(name);
      Logger.info(id);
    }
  }
}

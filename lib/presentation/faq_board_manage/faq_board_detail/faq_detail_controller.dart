// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/faq_board_delete/faq_board_delete_repository.dart';
import 'package:mindsight_admin_page/data/faq_board_detail/faq_board_model.dart';
import 'package:mindsight_admin_page/data/faq_board_detail/faq_board_repository.dart';

class FAQBoardDetailController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  late FAQBoardDetailModel faqBoardDetailModel;

  File? attachedFile;

  @override
  Future<void> onInit() async {
    await initData();

    super.onInit();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
  }

  Future<void> initData() async {
    isLoading.value = true;
    isInited.value = false;

    faqBoardDetailModel = await FAQBoardDetailRepository().get(id);

    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> onTapDelete() async {
    bool? confirm = await showDeleteConfirmationDialog();

    if (confirm != true) {
      return;
    }

    isLoading.value = true;

    try {
      BaseModel model = await FAQBoardDeleteRepository().delete(id);

      isLoading.value = false;

      if (model.isSuccess) {
        Get.offAllNamed(AppRoutes.faqBoardManage);
      } else {
        showSimpleMessage("Delete failed: ${model.getErrorMessage().tr}");
      }
    } catch (error) {
      isLoading.value = false;
      showSimpleMessage("An error occurred.");
      Logger.log(error);
    }
  }
}

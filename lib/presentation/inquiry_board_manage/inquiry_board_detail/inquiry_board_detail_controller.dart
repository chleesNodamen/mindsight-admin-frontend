import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/inquiry_board_delete/inquiry_board_delete_repository.dart';
import 'package:mindsight_admin_page/data/inquiry_board_detail/inquiry_board_detail_model.dart';
import 'package:mindsight_admin_page/data/inquiry_board_detail/inquiry_board_detail_repository.dart';
import 'package:mindsight_admin_page/data/inquiry_board_edit/inquiry_board_edit_repository.dart';
import 'package:mindsight_admin_page/data/inquiry_board_edit/inquiry_board_edit_req_put.dart';

class InquiryBoardDetailController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  late InquiryBoardDetailModel inquiryBoardDetailModel;
  final TextEditingController responseController = TextEditingController();
  late final focusNode = FocusNode();

  @override
  Future<void> onInit() async {
    super.onInit();

    await initData();
  }

  @override
  Future<void> onClose() async {
    super.onClose();

    responseController.dispose();
  }

  Future<void> initData() async {
    isLoading.value = true;
    isInited.value = false;

    inquiryBoardDetailModel = await InquiryBoardDetailRepository().get(id);

    responseController.text = inquiryBoardDetailModel.response ?? '';

    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    BaseModel model = await InquiryBoardEditRepository()
        .put(id, InquiryBoardEditReqPut(response: responseController.text));

    isLoading.value = false;

    if (model.isSuccess) {
      Get.offAllNamed(AppRoutes.inquiryBoardManage);
    } else {
      showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
    }
  }

  void nextLine() {
    String text = responseController.text;
    if (text.isEmpty) return;

    List<String> lines = text.split('\n');
    if (lines.last.startsWith('\t\t-\t\t')) {
      lines.add('\t\t-\t\t');
    }
    if (lines.last.startsWith('\t\t•\t\t')) {
      lines.add('\t\t•\t\t');
    }
    String formattedText = lines.join('\n');
    if (formattedText != text) {
      responseController.value = responseController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  Future<void> onTapDelete() async {
    bool? confirm = await showDeleteConfirmationDialog();

    if (confirm != true) {
      return;
    }

    isLoading.value = true;

    try {
      BaseModel model = await InquiryBoardDeleteRepository().delete(id);

      isLoading.value = false;

      if (model.isSuccess) {
        Get.offAllNamed(AppRoutes.inquiryBoardManage);
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

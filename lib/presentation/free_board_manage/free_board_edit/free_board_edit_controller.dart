import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/free_board_detail/free_board_detail_model.dart';
import 'package:mindsight_admin_page/data/free_board_detail/free_board_detail_repository.dart';
import 'package:mindsight_admin_page/data/free_board_edit/free_board_edit_repository.dart';
import 'package:mindsight_admin_page/data/free_board_edit/free_board_edit_req_put.dart';

class FreeBoardEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late FreeBoardDetailModel freeBoardDetailModel;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  late final focusNode = FocusNode();

  @override
  Future<void> onInit() async {
    await initData();

    super.onInit();
  }

  @override
  Future<void> onClose() async {
    titleController.dispose();
    contentController.dispose();

    super.onClose();
  }

  Future<void> initData() async {
    freeBoardDetailModel = await FreeBoardDetailRepository().get(id);

    titleController.text = freeBoardDetailModel.title ?? "";
    contentController.text = freeBoardDetailModel.content ?? "";

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    BaseModel model = await FreeBoardEditRepository().put(
        id,
        FreeBoardEditReqPut(
          title: titleController.text,
          content: contentController.text,
        ));

    if (model.isSuccess) {
      Get.offAllNamed(AppRoutes.freeBoardDetail,
          arguments: {RouteArguments.id: id});
    } else {
      showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
    }

    isLoading.value = false;
  }

  void nextList() {
    String text = contentController.text;
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
      contentController.value = contentController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }
}

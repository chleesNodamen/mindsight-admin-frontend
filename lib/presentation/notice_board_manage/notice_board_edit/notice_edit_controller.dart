import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/notice_board_detail/notice_board_model.dart';
import 'package:mindsight_admin_page/data/notice_board_detail/notice_board_repository.dart';
import 'package:mindsight_admin_page/data/notice_board_edit/notice_board_edit_repository.dart';
import 'package:mindsight_admin_page/data/notice_board_edit/notice_board_edit_req_put.dart';

class NoticeBoardEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late NoticeBoardDetailModel noticeBoardDetailModel;

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
    noticeBoardDetailModel = await NoticeBoardDetailRepository().get(id);

    titleController.text = noticeBoardDetailModel.title ?? "";
    contentController.text = noticeBoardDetailModel.content ?? "";

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    BaseModel model = await NoticeBoardEditRepository().put(
        id,
        NoticeBoardEditReqPut(
          title: titleController.text,
          content: contentController.text,
        ));

    if (model.isSuccess) {
      Get.offAllNamed(AppRoutes.noticeBoardDetail,
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

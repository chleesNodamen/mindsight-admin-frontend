import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/free_board_comment_delete/free_board_comment_delete_repository.dart';
import 'package:mindsight_admin_page/data/free_board_comment_list/free_board_comment_list_model.dart';
import 'package:mindsight_admin_page/data/free_board_comment_list/free_board_comment_list_repository.dart';
import 'package:mindsight_admin_page/data/free_board_comment_list/free_board_comment_list_req_get.dart';
import 'package:mindsight_admin_page/data/free_board_comment_register/free_board_comment_register_repository.dart';
import 'package:mindsight_admin_page/data/free_board_comment_register/free_board_comment_register_req_post.dart';
import 'package:mindsight_admin_page/data/free_board_delete/free_board_delete_repository.dart';
import 'package:mindsight_admin_page/data/free_board_detail/free_board_detail_model.dart';
import 'package:mindsight_admin_page/data/free_board_detail/free_board_detail_repository.dart';

class FreeBoardDetailController extends GetxController {
  late String id;
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  late FreeBoardDetailModel freeBoardDetailModel;
  late FreeBoardCommentListModel freeBoardCommentListModel;
  final TextEditingController commentController = TextEditingController();
  late final focusNode = FocusNode();

  @override
  Future<void> onInit() async {
    id = Get.arguments[RouteArguments.id];

    await initData();

    super.onInit();
  }

  @override
  Future<void> onClose() async {
    super.onClose();

    commentController.dispose();
  }

  Future<void> initData() async {
    isLoading.value = true;
    isInited.value = false;

    commentController.text = '';

    Logger.log(id);

    freeBoardDetailModel = await FreeBoardDetailRepository().get(id);

    freeBoardCommentListModel = await FreeBoardCommentListRepository()
        .get(id, FreeBoardCommentListReqGet());

    isLoading.value = false;
    isInited.value = true;
  }

  Future<void> onSave() async {
    if (commentController.text.isEmpty) {
      return;
    }
    isLoading.value = true;

    BaseModel model = await FreeBoardCommentRegisterRepository().post(
        id,
        FreeBoardCommentRegisterReqPost(
          content: commentController.text,
        ));

    isLoading.value = false;

    if (model.isSuccess) {
      await initData();
    } else {
      showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
    }
  }

  void nextLine() {
    String text = commentController.text;
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
      commentController.value = commentController.value.copyWith(
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
      BaseModel model = await FreeBoardDeleteRepository().delete(id);

      isLoading.value = false;

      if (model.isSuccess) {
        Get.offAllNamed(AppRoutes.freeBoardManage);
      } else {
        showSimpleMessage("Delete failed: ${model.getErrorMessage().tr}");
      }
    } catch (error) {
      isLoading.value = false;
      showSimpleMessage("An error occurred.");
      Logger.log(error);
    }
  }

  Future<void> onTapDeleteComment(String commentId) async {
    bool? confirm = await showDeleteConfirmationDialog();

    if (confirm != true) {
      return;
    }

    isLoading.value = true;

    try {
      BaseModel model =
          await FreeBoardCommentDeleteRepository().delete(commentId);

      isLoading.value = false;

      if (model.isSuccess) {
        await initData();
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

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/notice_board_delete/notice_board_repository.dart';
import 'package:mindsight_admin_page/data/notice_board_detail/notice_board_model.dart';
import 'package:mindsight_admin_page/data/notice_board_detail/notice_board_repository.dart';

class NoticeBoardDetailController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  late NoticeBoardDetailModel noticeBoardDetailModel;

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
    noticeBoardDetailModel = await NoticeBoardDetailRepository().get(id);

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
      BaseModel model = await NoticeBoardDeleteRepository().delete(id);

      isLoading.value = false;

      if (model.isSuccess) {
        Get.offAllNamed(AppRoutes.noticeBoardManage);
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

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_delete/admin_delete_model.dart';
import 'package:mindsight_admin_page/data/admin_delete/admin_delete_repository.dart';
import 'package:mindsight_admin_page/data/admin_delete/admin_delete_req_delete.dart';
import 'package:mindsight_admin_page/data/admin_list/admin_list_model.dart';
import 'package:mindsight_admin_page/data/admin_list/admin_list_repository.dart';
import 'package:mindsight_admin_page/data/admin_list/admin_list_req_get.dart';

class SubAdminSettingsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  RxMap<String, bool> selectedIds = <String, bool>{}.obs;
  RxInt activePage = 1.obs;

  late AdminListModel adminListModel;
  late AdminDeleteModel adminDeleteModel;

  @override
  Future<void> onInit() async {
    super.onInit();

    adminListModel = await AdminListRepository().get(AdminListReqGet(
      page: 1,
    ));

    isLoading.value = false;
    isInited.value = true;
  }

  //DATA TABLE
  RxString dataTableButtonText = '정상'.obs;
  void updateDTText(String newText) {
    dataTableButtonText.value = newText;
  }

  void loadNewPage(int pageNum) {
    activePage.value = pageNum;
  }

  void updateSelected(String id, bool isSelected) {
    selectedIds[id] = isSelected;
  }

  Future<void> deleteSelected() async {
    List<String> idsToDelete = selectedIds.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (idsToDelete.isEmpty) return;
    adminDeleteModel = await AdminDeleteRepository()
        .delete(AdminDeleteReqDelete(ids: idsToDelete));
    selectedIds.clear();
    Get.offAllNamed(AppRoutes.subAdminSettings);
    // Reload data if needed after deletion
  }

  void onRegisterTap() {
    Get.offAllNamed(AppRoutes.subAdminRegister);
  }

  void goToEdit(int index) {
    Get.offAllNamed(AppRoutes.subAdminDetails, arguments: {
      RouteArguments.id: Uri.encodeComponent(adminListModel.id![index])
    });
  }
}

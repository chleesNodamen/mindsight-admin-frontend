import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_delete/admin_delete_model.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_delete/admin_delete_repository.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_delete/admin_delete_req_delete.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_list/admin_list_model.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_list/admin_list_repository.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_list/admin_list_req_get.dart';

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

    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    adminListModel = await AdminListRepository().get(AdminListReqGet(
      page: 1,
    ));

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> loadPage(int pageNum) async {
    activePage.value = pageNum;

    isLoading.value = true;

    adminListModel = await AdminListRepository().get(AdminListReqGet(
      page: pageNum,
    ));

    isLoading.value = false;
  }

  void updateSelected(String id, bool isSelected) {
    selectedIds[id] = isSelected;
  }

  Future<void> onDeleteSelected() async {
    List<String> idsToDelete = selectedIds.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (idsToDelete.isEmpty) {
      return;
    }

    isLoading.value = true;
    adminDeleteModel = await AdminDeleteRepository()
        .delete(AdminDeleteReqDelete(ids: idsToDelete));
    isLoading.value = false;

    selectedIds.clear();

    if (adminDeleteModel.isSuccess) {
      showSimpleMessage("Delete 되었습니다");
    } else {
      showSimpleMessage("Delete에 실패 하였습니다");
    }

    await loadPage(activePage.value);
  }

  void onRegister() {
    Get.offAllNamed(AppRoutes.subAdminRegister);
  }

  void onEdit(int index) {
    Get.offAllNamed(AppRoutes.subAdminDetails, arguments: {
      RouteArguments.id: Uri.encodeComponent(adminListModel.id![index])
    });
  }
}

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/content_type.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_model.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_req_get.dart';
import 'package:mindsight_admin_page/data/practices_data/practices_data_model.dart';
import 'package:mindsight_admin_page/data/practices_data/practices_data_repository.dart';
import 'package:mindsight_admin_page/data/practices_data/practices_data_req_post.dart';

class PracticeRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late ContentListModel contentListModel;
  late PracticesDataModel practicesDataModel;

  RxBool fetchedData = false.obs;

  final TextEditingController textController = TextEditingController();

  var selectedIndex = (-1).obs; // Initialize with -1 indicating no selection
  RxString selectedBodyName = "".obs;
  String? selectedBodyId;
  RxString selectedBreathName = "".obs;
  String? selectedBreathId;

  List<String> contentType = [];

  var selected = false.obs;
  var activePage = 1.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    isLoading.value = false;
    isInited.value = true;
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> loadPage(int pageNum) async {
    selectedIndex.value = (-1);

    isLoading.value = true;
    contentListModel = await ContentListRepository().get(ContentListReqGet(
      page: pageNum,
      type: contentType,
      search: textController.text,
      status: true,
      pageSize: 5,
    ));

    activePage.value = pageNum;
    isLoading.value = false;
  }

  Future<void> fetchBodyData(String? search) async {
    selectedIndex.value = (-1);

    contentListModel = await ContentListRepository().get(ContentListReqGet(
      page: 1,
      type: [
        ContentType.basicBody.keywordName,
        ContentType.intermediateBody.keywordName,
        ContentType.advanceBody.keywordName
      ],
      search: textController.text,
      pageSize: 4,
      status: true,
    ));

    fetchedData.value = true;
  }

  Future<void> fetchBreathData(String? search) async {
    selectedIndex.value = (-1);

    contentListModel = await ContentListRepository().get(ContentListReqGet(
      page: 1,
      type: [ContentType.natureBreathing.keywordName],
      search: textController.text,
      pageSize: 4,
      status: true,
    ));

    fetchedData.value = true;
  }

  Future<void> initSearchDialogData(bool isBody) async {
    contentListModel = ContentListModel();
    contentType = [];
    fetchedData.value = false;
    activePage.value = 1;
    textController.clear();

    if (isBody) {
      await fetchBodyData(textController.text);
    } else {
      await fetchBreathData(textController.text);
    }
  }

  void onBodyButtonPressed() {
    selectedBodyName.value = contentListModel.name![selectedIndex.value];
    selectedBodyId = contentListModel.id![selectedIndex.value];
  }

  void onBreathButtonPressed() {
    selectedBreathName.value = contentListModel.name![selectedIndex.value];
    selectedBreathId = contentListModel.id![selectedIndex.value];
  }

  Future<void> onSave() async {
    if (selectedBodyId == null || selectedBreathId == null) {
      showSimpleMessage(Get.context!, "콘텐츠를 선택 해 주십시오");
      return;
    }

    isLoading.value = true;

    practicesDataModel = await PracticesDataRepository().post(
        PracticesDataReqPost(
            bodyId: selectedBodyId, breathId: selectedBreathId));

    isLoading.value = false;

    if (practicesDataModel.isSuccess) {
      showSimpleMessage(Get.context!, "저장 되었습니다");
      // Get.offAllNamed(AppRoutes.contentPracticeManage);
    } else {
      showSimpleMessage(Get.context!, "저장에 실패 하였습니다");
    }
  }
}

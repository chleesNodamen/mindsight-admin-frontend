import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/sort_condition.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_model.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_req_get.dart';

class ContentSelectController extends GetxController {
  final ContentCategory category;
  ContentSelectController({required this.category});

  RxBool isLoading = true.obs;

  RxInt activePage = 1.obs;
  TextEditingController textController = TextEditingController();
  RxInt selectedIndex = (-1).obs;
  Rx<ContentListModel> contentListModel = ContentListModel().obs;
  Map<String, String>? result;

  @override
  Future<void> onInit() async {
    super.onInit();

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }
    await fetchContentList(1, textController.text);
  }

  Future<void> fetchContentList(int pageNumber, String searchQuery) async {
    isLoading.value = true;
    selectedIndex.value = -1;

    if (category == ContentCategory.body) {
      contentListModel.value =
          await ContentListRepository().get(ContentListReqGet(
        page: pageNumber,
        sortBy: SortCondition.registration.keywordName,
        // type: [
        //   ContentType.basicBody.keywordName,
        //   ContentType.intermediateBody.keywordName,
        //   ContentType.advanceBody.keywordName
        // ],
        search: searchQuery,
        pageSize: 5,
        // status: true,
      ));
    } else {
      contentListModel.value =
          await ContentListRepository().get(ContentListReqGet(
        page: pageNumber,
        sortBy: SortCondition.registration.keywordName,
        // type: [
        //   ContentType.natureBreathing.keywordName,
        //   ContentType.guidedMeditation.keywordName
        // ],
        search: searchQuery,
        pageSize: 5,
        // status: true,
      ));
    }

    activePage.value = pageNumber;

    isLoading.value = false;
  }

  void search() {
    fetchContentList(1, textController.text);
  }

  void selectPage(int pageNum) {
    fetchContentList(pageNum, textController.text);
  }

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  void confirmSelection() {
    if (selectedIndex.value >= 0) {
      result = {
        "id": contentListModel.value.id![selectedIndex.value],
        "name": contentListModel.value.name![selectedIndex.value],
      };
    }

    Get.back();
  }
}

Future<Map<String, String>?> showContentSelectDialog(
    ContentCategory category) async {
  if (Get.isRegistered<ContentSelectController>()) {
    Get.delete<ContentSelectController>();
  }

  final ContentSelectController controller =
      Get.put(ContentSelectController(category: category));

  await Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder12,
          color: appTheme.background,
        ),
        width: 900,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "콘텐츠 선택".tr,
                  style: CustomTextStyles.bodyMediumBlack,
                ),
                CustomImageView(
                  imagePath: IconConstant.close,
                  onTap: () => Get.back(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: controller.textController,
                      decoration: InputDecoration(
                        fillColor: appTheme.white,
                        filled: true,
                        labelText: "콘텐츠 제목".tr,
                        labelStyle: CustomTextStyles.bodyMediumGray,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: appTheme.grayScale3,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: appTheme.grayScale3,
                            width: 1,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: appTheme.grayScale3,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: appTheme.grayScale3,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: appTheme.red,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: appTheme.red,
                            width: 2,
                          ),
                        ),
                        errorStyle: TextStyle(
                          color: appTheme.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await controller.fetchContentList(
                        1, controller.textController.text);
                  },
                  child: Container(
                    width: 76,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: appTheme.black,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      "검색".tr,
                      style: CustomTextStyles.bodyMediumWhite,
                    ),
                  ),
                ),
              ],
            ),

            // Content and Pagination
            Obx(() {
              if (controller.isLoading.value) {
                return const SizedBox.shrink();
              }
              return Column(
                children: [
                  const SizedBox(height: 35),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder12,
                      color: appTheme.white,
                    ),
                    padding: const EdgeInsets.all(32.0),
                    width: double.infinity,
                    child: Column(
                      children: [
                        // DataTable
                        SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            columnSpacing: 0,
                            checkboxHorizontalMargin: 0,
                            dataRowMaxHeight: 80,
                            border: TableBorder(
                              horizontalInside:
                                  BorderSide(color: appTheme.grayScale2),
                            ),
                            columns: [
                              DataColumn(
                                label: Text('',
                                    style: CustomTextStyles.labelLargeGray),
                              ),
                              DataColumn(
                                label: Text("타입".tr,
                                    style: CustomTextStyles.labelLargeGray),
                              ),
                              DataColumn(
                                label: Text("제목".tr,
                                    style: CustomTextStyles.labelLargeGray),
                              ),
                              DataColumn(
                                label: Text("상태".tr,
                                    style: CustomTextStyles.labelLargeGray),
                              ),
                            ],
                            rows: List.generate(
                              controller.contentListModel.value.length,
                              (index) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Radio<int>(
                                          value: index,
                                          groupValue:
                                              controller.selectedIndex.value,
                                          onChanged: (int? value) {
                                            if (value != null) {
                                              controller.selectItem(value);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24.0),
                                        child: Text(
                                          controller.contentListModel.value
                                              .type![index],
                                          style:
                                              CustomTextStyles.bodyLargeBlack,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24.0),
                                        child: Text(
                                          controller.contentListModel.value
                                              .name![index],
                                          style:
                                              CustomTextStyles.bodyLargeBlack,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24.0),
                                        child: Text(
                                          controller.contentListModel.value
                                                  .status![index]
                                              ? "정상".tr
                                              : "안함".tr,
                                          style:
                                              CustomTextStyles.bodyLargeBlack,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Pagination and Confirm Button
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            CustomElevatedButton(
                              text: "선택 완료".tr,
                              buttonTextStyle:
                                  CustomTextStyles.bodyMediumWhiteBold,
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              margin: const EdgeInsets.only(right: 16),
                              width: 107,
                              height: 44,
                              onPressed: controller.confirmSelection,
                            ),
                            Center(
                              child: Pages(
                                pages:
                                    (controller.contentListModel.value.total! /
                                            5)
                                        .ceil(),
                                activePage: controller.activePage.value,
                                onTap: controller.selectPage,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ),
  );

  return controller.result;
}

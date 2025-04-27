import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/sort_condition.dart';
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

  Rx<SortCondition> selectedOrder = SortCondition.registration.obs;

  RxString masterSearchType = "MY".obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    await fetchContentList(1, textController.text);
  }

  Future<void> fetchContentList(int pageNumber, String searchQuery) async {
    isLoading.value = true;
    selectedIndex.value = -1;

    contentListModel.value = await ContentListRepository().get(
        ContentListReqGet(
            page: pageNumber,
            sortBy: selectedOrder.value.keywordName,
            category: [category.keywordName],
            search: searchQuery,
            pageSize: 5,
            masterId: masterSearchType.value == "ALL" ? null : Account.id));

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

  void onChangedSelectedOrder(SortCondition newValue) {
    selectedOrder.value = newValue;
  }

  Future<void> onMasterSearchType(String? value) async {
    isLoading.value = true;
    masterSearchType.value = value!;
    Logger.info(masterSearchType.value);

    await fetchContentList(1, textController.text);

    isLoading.value = false;
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
        width: 1200,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${"Select content".tr} : ${category.displayName.tr}",
                  style: CustomTextStyles.bodyMediumBlack,
                ),
                Row(
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Row(
                                  children: <Widget>[
                                    Radio<String>(
                                      value: "ALL",
                                      groupValue:
                                          controller.masterSearchType.value,
                                      onChanged: (String? value) {
                                        controller.onMasterSearchType(value);
                                      },
                                    ),
                                    Text(
                                      "All".tr,
                                      style: CustomTextStyles.bodyMediumBlack
                                          .copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                children: <Widget>[
                                  Radio<String>(
                                    value: "MY",
                                    groupValue:
                                        controller.masterSearchType.value,
                                    onChanged: (String? value) {
                                      controller.onMasterSearchType(value);
                                    },
                                  ),
                                  Text(
                                    "My".tr,
                                    style: CustomTextStyles.bodyMediumBlack
                                        .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 400,
                      child: TextFormField(
                        controller: controller.textController,
                        decoration: InputDecoration(
                          fillColor: appTheme.white,
                          filled: true,
                          labelText: "${"Content title".tr}, ${"Master".tr}",
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
                          "Search".tr,
                          style: CustomTextStyles.bodyMediumWhite,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    CustomImageView(
                      imagePath: IconConstant.close,
                      onTap: () => Get.back(),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: appTheme.grayScale2,
                ),
                color: appTheme.white,
                borderRadius: BorderRadiusStyle.roundedBorder8,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 6, right: 0, top: 0, bottom: 0),
                child: DropdownButton<SortCondition>(
                  value: controller.selectedOrder.value,
                  underline: Container(),
                  padding: const EdgeInsets.only(left: 6),
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (SortCondition? newValue) {
                    if (newValue != null) {
                      controller.onChangedSelectedOrder(newValue);
                    }
                  },
                  items: <SortCondition>[
                    SortCondition.registration,
                    SortCondition.highestCompletionRate,
                    SortCondition.lowestCompletionRate,
                    SortCondition.likes
                  ].map<DropdownMenuItem<SortCondition>>((SortCondition value) {
                    return DropdownMenuItem<SortCondition>(
                      value: value,
                      child: Text(
                        value.displayName.tr,
                        style: CustomTextStyles.labelLargeBlack,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Content and Pagination
            Obx(() {
              if (controller.isLoading.value) {
                return const SizedBox.shrink();
              }
              return Column(
                children: [
                  const SizedBox(height: 24),
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
                                label: Text("Category".tr,
                                    style: CustomTextStyles.labelLargeGray),
                              ),
                              DataColumn(
                                label: Text("Title".tr,
                                    style: CustomTextStyles.labelLargeGray),
                              ),
                              DataColumn(
                                label: Text("Master".tr,
                                    style: CustomTextStyles.labelLargeGray),
                              ),
                              DataColumn(
                                label: Text("Approval".tr,
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
                                          ContentCategory.fromKeyword(controller
                                                  .contentListModel
                                                  .value
                                                  .category![index])
                                              .displayName
                                              .tr,
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
                                              .master![index],
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
                                          ContentStatus.fromKeyword(controller
                                                  .contentListModel
                                                  .value
                                                  .status![index])
                                              .displayName
                                              .tr,
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
                              text: "Selection complete".tr,
                              buttonTextStyle:
                                  CustomTextStyles.bodyMediumWhiteBold,
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              margin: const EdgeInsets.only(right: 16),
                              // width: 107,
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

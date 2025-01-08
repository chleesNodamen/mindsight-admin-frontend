import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/sort_condition.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_manage/practice_manage_controller.dart';

class PracticeManageView extends GetWidget<PracticeManageController> {
  const PracticeManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBodyBehindAppBar: true,
        body: PageLoadingIndicator(
          isLoading: controller.isLoading.value,
          child: controller.isInited.value
              ? ResponsiveWidget(
                  largeScreen: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SideMenu(),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                          child: ListView(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildTitle(),
                                  const SizedBox(height: 32),
                                  _buildRegisterButton(),
                                  const SizedBox(height: 32),
                                  _buildSortDropdown(),
                                  const SizedBox(height: 16),
                                  _buildPage()
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  CustomElevatedButton _buildRegisterButton() {
    return CustomElevatedButton(
      text: "New registration".tr,
      height: 44,
      // width: 107,
      decoration:
          BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder12),
      onPressed: controller.onPressedRegister,
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Practice plan management".tr,
      searchShow: true,
      viewCount: false,
      searchText: "Search title".tr,
      onSearch: controller.onSearch,
    );
  }

  DecoratedBox _buildSortDropdown() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: appTheme.grayScale2,
        ),
        color: appTheme.white,
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 0, top: 0, bottom: 0),
        child: DropdownButton<SortCondition>(
          value: controller.selectedOrder.value,
          underline: Container(),
          padding: const EdgeInsets.only(left: 6),
          borderRadius: BorderRadiusStyle.roundedBorder12,
          // icon: const Icon(Icons.),
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
    );
  }

  SingleChildScrollView _buildPage() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: appTheme.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
            width: 1,
            color: appTheme.grayScale2,
          ),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(32.0),
        // height: 972,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              child: DataTable(
                showCheckboxColumn: false,
                columnSpacing: 0,
                checkboxHorizontalMargin: 0,
                dataRowMaxHeight: 80,
                border: TableBorder(
                    horizontalInside: BorderSide(color: appTheme.grayScale2)),
                columns: [
                  DataColumn(
                      label: Text("Master".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Title".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Complete member".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Participating members".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Complete rate".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Likes".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Approval status".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('Exposure'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Account.isAdmin
                          ? const SizedBox.shrink()
                          : Text("Approval request".tr,
                              style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('Edit'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                ],
                rows: List.generate(controller.practicesModel.length, (index) {
                  return DataRow(cells: [
                    DataCell(SizedBox(
                      width: 150,
                      child: Text(
                        controller.practicesModel.masterName![index],
                        style: CustomTextStyles.bodyLargeBlack,
                      ),
                    )),
                    DataCell(InkWell(
                        onTap: () => controller.onTapDetail(index),
                        child: SizedBox(
                          width: 300,
                          child: Text(controller.practicesModel.name![index],
                              style: CustomTextStyles.bodyLargeBlack.copyWith(
                                  decoration: TextDecoration.underline)),
                        ))),
                    DataCell(Text(
                        controller.practicesModel.finished![index].toString(),
                        style: CustomTextStyles.bodyLargeBlack)),
                    DataCell(Text(
                        controller.practicesModel.participated![index]
                            .toString(),
                        style: CustomTextStyles.bodyLargeBlack)),
                    DataCell(Text(controller.practicesModel.ratio![index],
                        style: CustomTextStyles.bodyLargeGreen)),
                    DataCell(Text(
                        controller.practicesModel.liked![index].toString(),
                        style: CustomTextStyles.bodyLargeBlack)),
                    DataCell(StatusDropdown(
                      isEnable: Account.isAdmin,
                      isActive: controller.practicesModel.status![index],
                      onChanged: (newState) {
                        controller.onStatusChange(index);
                      },
                    )),
                    DataCell(StatusDropdown(
                      isEnable: true,
                      isActive: controller.practicesModel.exposure![index],
                      onChanged: (newState) {
                        controller.onExposureChange(index);
                      },
                    )),
                    DataCell(Account.isAdmin
                        ? const SizedBox.shrink()
                        : CustomElevatedButton(
                            text: "Approval request".tr,
                            buttonTextStyle:
                                CustomTextStyles.bodyMediumWhiteBold,
                            buttonStyle: CustomButtonStyles.fillBlack,
                            // width: 70,
                            height: 30,
                            onPressed: () =>
                                showSimpleMessage("Service preparing".tr))),
                    DataCell(CustomElevatedButton(
                        text: "Edit".tr,
                        buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
                        buttonStyle: CustomButtonStyles.fillBlack,
                        // width: 60,
                        height: 30,
                        onPressed: () =>
                            Get.offAllNamed(AppRoutes.practiceEdit, arguments: {
                              RouteArguments.id:
                                  controller.practicesModel.id![index],
                            }))),
                  ]);
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Pages(
                pages: (controller.practicesModel.total! / 20).ceil(),
                activePage: controller.activePage.value,
                onTap: (int pageNum) {
                  controller.loadPage(pageNum);
                }),
          ],
        ),
      ),
    );
  }
}

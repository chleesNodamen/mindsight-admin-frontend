import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/goal.dart';
import 'package:mindsight_admin_page/constants/enum/sort_condition.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage/challenge_manage_controller.dart';

class ChallengeManageView extends GetWidget<ChallengeManageController> {
  const ChallengeManageView({super.key});

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
                                  _buildSelect(),
                                  const SizedBox(height: 16),
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
      onPressed: () {
        Get.offAllNamed(AppRoutes.challengeRegister);
      },
      text: "New registration".tr,
      height: 44,
      // width: 107,
      decoration:
          BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder12),
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Challenge management".tr,
      searchShow: true,
      viewCount: false,
      searchText: "Challenge, Content title".tr,
      onSearch: controller.onSearch,
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
                columnSpacing: 0,
                checkboxHorizontalMargin: 0,
                // dataRowMinHeight: ,
                dataRowMaxHeight: 80,
                border: TableBorder(
                    horizontalInside: BorderSide(color: appTheme.grayScale2)),
                columns: [
                  DataColumn(
                      label: Text('Purpose'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('Title'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('Participating members'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('Completed members'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('Like count'.tr,
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
                rows: List.generate(controller.challengesModel.length, (index) {
                  String id = controller.challengesModel.id![index];
                  return DataRow(
                      selected: controller.selectedIds[id] ?? false,
                      onSelectChanged: (bool? value) {
                        controller.updateSelected(id, value ?? false);
                      },
                      cells: [
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Text(
                                Goal.fromKeyword(
                                        controller.challengesModel.goal![index])
                                    .displayName
                                    .tr,
                                style: CustomTextStyles.bodyLargeBlack),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: InkWell(
                              onTap: () => controller.onDetail(index),
                              child: Text(
                                controller.challengesModel.name![index],
                                style:
                                    CustomTextStyles.bodyMediumBlack.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Text(
                                controller.challengesModel.participants![index]
                                    .toString(),
                                style: CustomTextStyles.bodyLargeBlack),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Text(
                                controller.challengesModel.finished![index]
                                    .toString(),
                                style: CustomTextStyles.bodyLargeBlack),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Text(
                                controller.challengesModel.liked![index]
                                    .toString(),
                                style: CustomTextStyles.bodyLargeBlack),
                          ),
                        ),
                        DataCell(StatusDropdown(
                          isEnable: Account.isAdmin,
                          isActive: controller.challengesModel.status![index],
                          onChanged: (newState) {
                            controller.onStatusChange(index);
                          },
                        )),
                        DataCell(StatusDropdown(
                          isEnable: true,
                          isActive: controller.challengesModel.exposure![index],
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
                            buttonTextStyle:
                                CustomTextStyles.bodyMediumWhiteBold,
                            buttonStyle: CustomButtonStyles.fillBlack,
                            // width: 60,
                            height: 30,
                            onPressed: () => Get.offAllNamed(
                                    AppRoutes.challengeEdit,
                                    arguments: {
                                      RouteArguments.id:
                                          controller.challengesModel.id![index],
                                    }))),
                      ]);
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Visibility(
                      visible: Account.isAdmin,
                      child: CustomElevatedButton(
                        text: 'Change status'.tr,
                        buttonTextStyle: CustomTextStyles.bodyMediumSkyBlueBold,
                        buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
                        margin: const EdgeInsets.only(right: 16),
                        // width: 107,
                        height: 44,
                        onPressed: () {
                          showSimpleMessage("Service preparing".tr);
                        },
                      ),
                    ),
                    Visibility(
                      visible: Account.isAdmin,
                      child: CustomElevatedButton(
                        text: 'Delete'.tr,
                        buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
                        buttonStyle:
                            CustomButtonStyles.fillRedTransparent.copyWith(),
                        // width: 76,
                        height: 44,
                        onPressed: () {
                          showSimpleMessage("Service preparing".tr);
                        },
                      ),
                    ),
                  ],
                ),
                Pages(
                    pages: (controller.challengesModel.total! / 20).ceil(),
                    activePage: controller.activePage.value,
                    onTap: (int pageNum) {
                      controller.loadPage(pageNum);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildSelect() {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(
          width: 1,
          color: appTheme.grayScale2,
        ),
      ),
      height: 238,
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Purpose'.tr, style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 17),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              runSpacing: 18,
              children: List.generate(controller.goalValues.length, (index) {
                return CustomCheckboxWidget(
                  isChecked: controller.goalValues[index],
                  label: controller.goalLabels[index].displayName.tr,
                  onChanged: (value) =>
                      controller.toggleGoalCheckbox(index, value),
                );
              }),
            ),
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Period'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 15),
                  Row(
                    children:
                        List.generate(controller.periodValues.length, (index) {
                      return CustomCheckboxWidget(
                        isChecked: controller.periodValues[index],
                        label: '${controller.periodLabels[index]} ${'일'.tr}',
                        onChanged: (value) =>
                            controller.togglePeriodCheckbox(index, value),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Approval status".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      CustomCheckboxWidget(
                        isChecked: controller.statusValues[0],
                        label: 'Active'.tr,
                        onChanged: (value) => controller.toggleStatusCheckbox(
                            0, value), // Adjust as needed
                      ),
                      CustomCheckboxWidget(
                        isChecked: controller.statusValues[1],
                        label: 'Inactive'.tr,
                        onChanged: (value) => controller.toggleStatusCheckbox(
                            1, value), // Adjust as needed
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
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
              controller.updateSelectedOrder(newValue);
            }
          },
          items: <SortCondition>[
            SortCondition.registration,
            SortCondition.mostParticipants,
            SortCondition.fewestParticipants,
            SortCondition.highestRatings,
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
}

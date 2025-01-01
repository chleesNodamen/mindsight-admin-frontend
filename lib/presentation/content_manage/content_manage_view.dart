import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/sort_condition.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_controller.dart';

class ContentManageView extends GetWidget<ContentManageController> {
  const ContentManageView({super.key});

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
        Get.offAllNamed(AppRoutes.contentRegister);
      },
      text: "신규 등록".tr,
      height: 44,
      width: 107,
      decoration:
          BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder12),
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "콘텐츠 목록".tr,
      searchShow: true,
      viewCount: true,
      searchText: "제목 검색".tr,
      viewNumber: controller.contentListModel.value.total,
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
                      label: Text('타입'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('제목'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('마스터'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('조회수'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('좋아요 수'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  // DataColumn(
                  //     label:
                  //         Text('미리보기', style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('상태'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('노출'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Account.isAdmin
                          ? const SizedBox.shrink()
                          : Text("승인 요청".tr,
                              style: CustomTextStyles.labelLargeGray)),

                  DataColumn(
                      label: Text('수정'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                ],
                rows: List.generate(controller.contentListModel.value.length,
                    (index) {
                  return DataRow(
                      selected: controller.selectedContent[index],
                      onSelectChanged: (bool? value) {
                        controller.selectedContent[index] =
                            !controller.selectedContent[index];
                      },
                      cells: [
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              ContentType.fromKeyword(controller
                                          .contentListModel.value.type![index])
                                      ?.displayName ??
                                  "",
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(
                          InkWell(
                            onTap: () => controller.onDetails(index),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 24.0),
                              child: Text(
                                controller.contentListModel.value.name![index],
                                style: CustomTextStyles.bodyLargeBlack.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.contentListModel.value.master![index]
                                  .toString(),
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.contentListModel.value.seen![index]
                                  .toString(),
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.contentListModel.value.liked![index]
                                  .toString(),
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        // DataCell(Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 24.0),
                        //   child: Text('재생',
                        //       style: CustomTextStyles.bodyLargeBlack),
                        // )),
                        DataCell(StatusDropdown(
                          isEnable: Account.isAdmin,
                          isActive:
                              controller.contentListModel.value.status![index],
                          onChanged: (newState) {
                            controller.onStatusChange(index);
                          },
                        )),

                        DataCell(StatusDropdown(
                          isEnable: true,
                          isActive: controller
                              .contentListModel.value.exposure![index],
                          onChanged: (newState) {
                            controller.onExposureChange(index);
                          },
                        )),

                        DataCell(Account.isAdmin
                            ? const SizedBox.shrink()
                            : CustomElevatedButton(
                                text: "승인요청".tr,
                                buttonTextStyle:
                                    CustomTextStyles.bodyMediumWhiteBold,
                                buttonStyle: CustomButtonStyles.fillBlack,
                                width: 70,
                                height: 30,
                                onPressed: () =>
                                    showSimpleMessage("서비스 준비 중 입니다".tr))),

                        DataCell(CustomElevatedButton(
                            text: "수정".tr,
                            buttonTextStyle:
                                CustomTextStyles.bodyMediumWhiteBold,
                            buttonStyle: CustomButtonStyles.fillBlack,
                            width: 60,
                            height: 30,
                            onPressed: () => Get.offAllNamed(
                                    AppRoutes.contentEdit,
                                    arguments: {
                                      RouteArguments.id: controller
                                          .contentListModel.value.id![index],
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
                        text: '상태 변경'.tr,
                        buttonTextStyle: CustomTextStyles.bodyMediumSkyBlueBold,
                        buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
                        margin: const EdgeInsets.only(right: 16),
                        width: 107,
                        height: 44,
                        onPressed: () => controller.onStatusChangeForAll(),
                      ),
                    ),
                    CustomElevatedButton(
                      text: '노출 변경'.tr,
                      buttonTextStyle: CustomTextStyles.bodyMediumSkyBlueBold,
                      buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
                      margin: const EdgeInsets.only(right: 16),
                      width: 107,
                      height: 44,
                      onPressed: () => controller.onExposureChangeForAll(false),
                    ),
                  ],
                ),
                Pages(
                    pages:
                        (controller.contentListModel.value.total! / 20).ceil(),
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
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('타입'.tr, style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 17),
          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      runSpacing: 18,
                      children: List.generate(3, (index) {
                        return CustomCheckboxWidget(
                          isChecked: controller.bodyValues[index],
                          label: controller.bodyLabels[index].displayName,
                          onChanged: (value) =>
                              controller.toggleBodyCheckbox(index, value),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      runSpacing: 18,
                      children: List.generate(
                        controller.breathingValues.length,
                        (index) {
                          return CustomCheckboxWidget(
                            isChecked: controller.breathingValues[index],
                            label:
                                controller.breathingLabels[index].displayName,
                            onChanged: (value) => controller
                                .toggleBreathingCheckbox(index, value),
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: controller.showMore.value,
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              runSpacing: 18,
                              children: List.generate(
                                controller.otherValues.length,
                                (index) {
                                  return CustomCheckboxWidget(
                                    isChecked: controller.otherValues[index],
                                    label: controller
                                        .otherLabels[index].displayName,
                                    onChanged: (value) => controller
                                        .toggleOtherCheckbox(index, value),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              runSpacing: 18,
                              children: List.generate(
                                controller.theoryValues.length,
                                (index) {
                                  return CustomCheckboxWidget(
                                    isChecked: controller.theoryValues[index],
                                    label: controller
                                        .theoryLabels[index].displayName,
                                    onChanged: (value) => controller
                                        .toggleTheoryCheckbox(index, value),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    child: Text(
                      controller.showMore.value ? "간략히 보기".tr : "전체 보기".tr,
                      style: CustomTextStyles.bodySmallSkyBlue.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: appTheme.skyBlue,
                      ),
                    ),
                    onTap: () {
                      controller.showMore.value = !controller.showMore.value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Text('상태'.tr, style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 15),
          Row(
            children: [
              CustomCheckboxWidget(
                isChecked: controller.serviceValues[0],
                label: '활성'.tr,
                onChanged: (value) => controller.toggleServiceValues(0, value),
              ),
              CustomCheckboxWidget(
                isChecked: controller.serviceValues[1],
                label: '비활성'.tr,
                onChanged: (value) => controller.toggleServiceValues(1, value),
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
          value: controller.selectedSort.value,
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
            SortCondition.views,
            SortCondition.likes
          ].map<DropdownMenuItem<SortCondition>>((SortCondition value) {
            return DropdownMenuItem<SortCondition>(
              value: value,
              child: Text(
                value.displayName,
                style: CustomTextStyles.labelLargeBlack,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

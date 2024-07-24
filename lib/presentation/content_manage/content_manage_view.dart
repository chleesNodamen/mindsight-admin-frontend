import 'package:mindsight_admin_page/app_export.dart';
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
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            margin: const EdgeInsets.all(48.0),
                            child: ListView(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    buildTopBar(),
                                    const SizedBox(height: 32),
                                    buildBlueButton(),
                                    const SizedBox(height: 32),
                                    buildFirstContainer(),
                                    const SizedBox(height: 16),
                                    dropdownButton(),
                                    const SizedBox(height: 16),
                                    buildSecondContainer()
                                  ],
                                ),
                              ],
                            ),
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

  CustomElevatedButton buildBlueButton() {
    return CustomElevatedButton(
      onPressed: () {
        Get.toNamed(AppRoutes.contentRegister);
      },
      text: "신규 등록",
      height: 44,
      width: 107,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
    );
  }

  TobBarSearch buildTopBar() {
    return TobBarSearch(
      name: "콘텐츠 목록",
      searchShow: true,
      viewCount: true,
      searchText: "제목, 마스터 이름, 태그 검색",
      viewNumber: controller.contentListModel.total,
      onSearch: controller.onSearch,
    );
  }

  SingleChildScrollView buildSecondContainer() {
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
                  // DataColumn(
                  //   label: Checkbox(
                  //       activeColor: appTheme.skyBlue,
                  //       checkColor: Colors.white,
                  //       fillColor: MaterialStateProperty.resolveWith(
                  //         (states) {
                  //           if (!states
                  //               .contains(MaterialState.selected)) {
                  //             return Colors.transparent;
                  //           }
                  //           return null;
                  //         },
                  //       ),
                  //       value: false,
                  //       onChanged: (bool? value) {}),
                  // ),
                  DataColumn(
                      label:
                          Text('타입', style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label:
                          Text('제목', style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label:
                          Text('조회수', style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('좋아요 수',
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label:
                          Text('미리보기', style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label:
                          Text('상태', style: CustomTextStyles.labelLargeGray)),
                ],
                rows:
                    List.generate(controller.contentListModel.length, (index) {
                  String id = controller.contentListModel.id![index];
                  return DataRow(
                      selected: controller.selectedIds[id] ?? false,
                      onSelectChanged: (bool? value) {
                        controller.updateSelected(id, value ?? false);
                      },
                      cells: [
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(controller.contentListModel.type![index],
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(
                          GestureDetector(
                            onTap: () => controller.goToDetails(index),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 24.0),
                              child: Text(
                                controller.contentListModel.name![index],
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
                              controller.contentListModel.seen![index]
                                  .toString(),
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.contentListModel.liked![index]
                                  .toString(),
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text('재생',
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(DecoratedBox(
                          decoration: BoxDecoration(
                            color: appTheme.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: appTheme.grayScale2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 0, top: 0, bottom: 0),
                            child: DropdownButton<String>(
                              value: controller.contentState![index]
                                  ? '활성'
                                  : '비활성',
                              underline: Container(),
                              padding: const EdgeInsets.only(left: 6),
                              borderRadius: BorderRadius.circular(12),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.contentState![index] =
                                      !controller.contentState![index];
                                  controller.onStatusChange(index);
                                }
                              },
                              items: <String>[
                                '활성',
                                '비활성'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: value == "활성"
                                        ? CustomTextStyles.labelLargeGreen
                                        : CustomTextStyles.labelLargeRed,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )),
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
                    CustomElevatedButton(
                      text: '상태 변경',
                      buttonTextStyle:
                          CustomTextStyles.bodyMediumSkyBlue.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
                      margin: const EdgeInsets.only(right: 16),
                      width: 107,
                      height: 44,
                      onPressed: () {},
                    ),
                    CustomElevatedButton(
                      text: '삭제',
                      buttonTextStyle: CustomTextStyles.bodyMediumRed.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      buttonStyle:
                          CustomButtonStyles.fillRedTransparent.copyWith(),
                      width: 76,
                      height: 44,
                      onPressed: () {},
                    ),
                  ],
                ),
                Pages(
                    pages: (controller.contentListModel.total! / 10).ceil(),
                    activePage: controller.activePage.value,
                    onTap: (int pageNum) {
                      controller.loadNewPage(pageNum);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildFirstContainer() {
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
          Text('타입', style: CustomTextStyles.labelMediumGray),
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
                          label: controller.bodyLabels[index],
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
                            label: controller.breathingLabels[index],
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
                        child: Wrap(
                          runSpacing: 18,
                          children: List.generate(
                            controller.otherValues.length,
                            (index) {
                              return CustomCheckboxWidget(
                                isChecked: controller.otherValues[index],
                                label: controller.otherLabels[index],
                                onChanged: (value) => controller
                                    .toggleOtherCheckbox(index, value),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    child: Text(
                      controller.showMore.value ? "간략히 보기" : "전체 보기",
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
          const SizedBox(height: 25),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(
            height: 24,
          ),
          Text('상태', style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 15),
          Row(
            children: [
              CustomCheckboxWidget(
                isChecked: controller.serviceValues[0],
                label: '정상',
                onChanged: (value) => controller.toggleServiceValues(0, value),
              ),
              CustomCheckboxWidget(
                isChecked: controller.serviceValues[1],
                label: '서비스 안함',
                onChanged: (value) => controller.toggleServiceValues(1, value),
              ),
            ],
          ),
        ],
      ),
    );
  }

  DecoratedBox dropdownButton() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: appTheme.grayScale2,
        ),
        color: appTheme.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 0, top: 0, bottom: 0),
        child: DropdownButton<String>(
          value: controller.selectedOrder.value,
          underline: Container(),
          padding: const EdgeInsets.only(left: 6),
          borderRadius: BorderRadius.circular(12),
          // icon: const Icon(Icons.),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.updateSelectedOrder(newValue);
            }
          },
          items: <String>['등록순', '조회순', '좋아요순']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: CustomTextStyles.labelLargeBlack,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

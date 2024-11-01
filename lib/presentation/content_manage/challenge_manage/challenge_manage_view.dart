import 'package:mindsight_admin_page/app_export.dart';
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

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Challenge 관리",
      searchShow: true,
      viewCount: false,
      searchText: "챌린지 제목, 콘텐츠 제목 검색",
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
                      label:
                          Text('목적', style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label:
                          Text('제목', style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('참여 회원 수',
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('완료 회원 수',
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('좋아요 수',
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label:
                          Text('상태', style: CustomTextStyles.labelLargeGray)),
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
                            child: Text(controller.challengesModel.goal![index],
                                style: CustomTextStyles.bodyLargeBlack),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: InkWell(
                              onTap: () => controller.goToEdit(index),
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
                        DataCell(
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: appTheme.white,
                              borderRadius: BorderRadiusStyle.roundedBorder8,
                              border: Border.all(
                                width: 1,
                                color: appTheme.grayScale2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 6, right: 0, top: 0, bottom: 0),
                              child: DropdownButton<String>(
                                value: controller.challengesModel.status![index]
                                    ? '정상'
                                    : "안함",
                                underline: Container(),
                                padding: const EdgeInsets.only(left: 6),
                                borderRadius: BorderRadiusStyle.roundedBorder12,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    controller.onStatusChange(index);
                                  }
                                },
                                items: <String>['정상', '안함']
                                    .map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: value == "정상"
                                            ? CustomTextStyles.labelLargeGreen
                                            : CustomTextStyles.labelLargeRed,
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ),
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
                      buttonTextStyle: CustomTextStyles.bodyMediumSkyBlueBold,
                      buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
                      margin: const EdgeInsets.only(right: 16),
                      width: 107,
                      height: 44,
                      onPressed: () {
                        showSimpleMessage(Get.context!, "서비스 준비 중 입니다");
                      },
                    ),
                    CustomElevatedButton(
                      text: '삭제',
                      buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
                      buttonStyle:
                          CustomButtonStyles.fillRedTransparent.copyWith(),
                      width: 76,
                      height: 44,
                      onPressed: () {
                        showSimpleMessage(Get.context!, "서비스 준비 중 입니다");
                      },
                    ),
                  ],
                ),
                Pages(
                    pages: (controller.challengesModel.total! / 20).ceil(),
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
          Text('목적', style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 17),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              runSpacing: 18,
              children: List.generate(controller.goalValues.length, (index) {
                return CustomCheckboxWidget(
                  isChecked: controller.goalValues[index],
                  label: controller.goalLabels[index],
                  onChanged: (value) =>
                      controller.toggleGoalCheckbox(index, value),
                );
              }),
            ),
          ),
          const SizedBox(height: 25),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('기간', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 15),
                  Row(
                    children:
                        List.generate(controller.periodValues.length, (index) {
                      return CustomCheckboxWidget(
                        isChecked: controller.periodValues[index],
                        label: controller.periodLabels[index],
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
                  Text('상태', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      CustomCheckboxWidget(
                        isChecked: controller.statusValues[0],
                        label: '정상',
                        onChanged: (value) => controller.toggleStatusCheckbox(
                            0, value), // Adjust as needed
                      ),
                      CustomCheckboxWidget(
                        isChecked: controller.statusValues[1],
                        label: '서비스 안함',
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
        child: DropdownButton<String>(
          value: controller.selectedOrder.value,
          underline: Container(),
          padding: const EdgeInsets.only(left: 6),
          borderRadius: BorderRadiusStyle.roundedBorder12,
          // icon: const Icon(Icons.),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.updateSelectedOrder(newValue);
            }
          },
          items: <String>['등록순', '참여자 많은 순', '참여자 낮은 순 ', '별점 높은 순 ', '좋아요순']
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

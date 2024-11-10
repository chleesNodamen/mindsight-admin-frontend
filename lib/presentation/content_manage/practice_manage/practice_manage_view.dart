import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/sort_condition.dart';
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
      text: "신규 등록",
      height: 44,
      width: 107,
      decoration:
          BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder12),
      onPressed: controller.onRegisterTap,
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Practice plan 관리",
      searchShow: true,
      viewCount: false,
      searchText: "마스터, 콘텐츠 제목 검색",
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
            SortCondition.highestCompletionRate,
            SortCondition.lowestCompletionRate,
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
                dataRowMaxHeight: 80,
                border: TableBorder(
                    horizontalInside: BorderSide(color: appTheme.grayScale2)),
                columns: [
                  DataColumn(
                      label:
                          Text('마스터', style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('컨텐츠 명',
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('완료 회원 수',
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('참여 회원 수',
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label:
                          Text('완료율', style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('좋아요 수',
                          style: CustomTextStyles.labelLargeGray)),
                ],
                rows: List.generate(controller.practicesModel.length, (index) {
                  return DataRow(cells: [
                    DataCell(Text(
                      "마스터이름",
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                    DataCell(InkWell(
                        onTap: () => controller.onDetails(index),
                        child: Text("컨텐츠 이름",
                            style: CustomTextStyles.bodyLargeBlack.copyWith(
                                decoration: TextDecoration.underline)))),
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
                  controller.loadNewPage(pageNum);
                }),
          ],
        ),
      ),
    );
  }
}

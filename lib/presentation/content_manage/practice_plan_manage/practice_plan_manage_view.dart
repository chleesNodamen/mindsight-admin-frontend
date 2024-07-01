import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_manage/practice_plan_manage_controller.dart';

class PracticePlanManageView extends GetWidget<PracticePlanManageController> {
  const PracticePlanManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBodyBehindAppBar: true,
        body: ResponsiveWidget(
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
        ),
      ),
    );
  }

  CustomElevatedButton buildBlueButton() {
    return CustomElevatedButton(
      text: "신규 등록",
      height: 44,
      width: 107,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      onPressed: controller.onRegisterTap,
    );
  }

  TobBarSearch buildTopBar() {
    return TobBarSearch(
      name: "Practice plan 관리",
      searchShow: true,
      viewCount: false,
      searchText: "회차, 콘텐츠 제목 검색",
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
          items: <String>['회차순', '완료율 높은 순', '완료율 낮은 순', '좋아요순']
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
                      label: Padding(
                    padding: const EdgeInsets.only(left: 64.0),
                    child: Text('회차', style: CustomTextStyles.labelLargeGray),
                  )),
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
                rows: controller.data.map((item) {
                  return DataRow(cells: [
                    // DataCell(
                    //   Padding(
                    //     padding: const EdgeInsets.only(right: 8.0),
                    //     child: Checkbox(
                    //       value: controller.selected.value,
                    //       onChanged: (bool? value) {
                    //         controller.updateValue();
                    //       },
                    //     ),
                    //   ),
                    // ), // Checkbox cell
                    DataCell(Padding(
                      padding: const EdgeInsets.only(left: 64.0),
                      child: Text(
                        item['level'],
                        style: CustomTextStyles.bodyLargeBlack
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    )),
                    DataCell(Text(item['completed'],
                        style: CustomTextStyles.bodyLargeBlack)),
                    DataCell(Text(item['participated'],
                        style: CustomTextStyles.bodyLargeBlack)),
                    DataCell(Text(item['ratio'],
                        style: CustomTextStyles.bodyLargeGreen)),
                    DataCell(Text(item['likes'],
                        style: CustomTextStyles.bodyLargeBlack)),
                  ]);
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Pages(
                pages: 100,
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

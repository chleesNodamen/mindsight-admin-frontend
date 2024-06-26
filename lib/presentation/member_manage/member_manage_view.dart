import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage_controller.dart';

class MemberManageView extends GetWidget<MemberManageController> {
  const MemberManageView({super.key});

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
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(48.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const TobBarSearch(
                                    name: "회원 목록",
                                    searchShow: true,
                                    viewCount: false,
                                    searchText: "이메일 주소, 사용자 이름 검색",
                                  ),
                                  const SizedBox(height: 32),
                                  _buildFirstContainer(),
                                  const SizedBox(height: 16),
                                  _pageView(),
                                ],
                              ),
                            ),
                          ],
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

  Widget _buildFirstContainer() {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      height: 122,
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('소속', style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Wrap(
                runSpacing: 18,
                children: List.generate(3, (index) {
                  return CustomCheckboxWidget(
                    isChecked: controller.membershipValues[index],
                    label: controller.membershipLabels[index],
                    onChanged: (value) =>
                        controller.toggleMembership(index, value),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _pageView() {
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
            color: appTheme.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          // height: 1016,
          width: double.infinity,
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DataTable(
                columnSpacing: 0,
                checkboxHorizontalMargin: 0,
                dataRowMaxHeight: 80,
                border: TableBorder(
                    horizontalInside: BorderSide(color: appTheme.grayScale2)),
                columns: <DataColumn>[
                  DataColumn(
                    label: SizedBox(
                      width: 20,
                      child: Text(
                        '',
                        style: CustomTextStyles.labelLargeGray,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 80,
                      child: Text(
                        '회차',
                        style: CustomTextStyles.labelLargeGray,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 80,
                      child: Text(
                        '완료 회원 수',
                        style: CustomTextStyles.labelLargeGray,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 80,
                      child: Text(
                        '참여 회원 수',
                        style: CustomTextStyles.labelLargeGray,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 80,
                      child: Text(
                        '완료율',
                        style: CustomTextStyles.labelLargeGray,
                      ),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        '1',
                        style: CustomTextStyles.bodyLargeSkyBlue,
                      )),
                      DataCell(GestureDetector(
                        onTap: controller.onMemberTap,
                        child: Text(
                          '1회차',
                          style: CustomTextStyles.bodyLargeBlack
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      )),
                      DataCell(Text(
                        '3,456',
                        style: CustomTextStyles.bodyLargeBlack,
                      )),
                      DataCell(Text(
                        '3,920',
                        style: CustomTextStyles.bodyLargeBlack,
                      )),
                      DataCell(Text(
                        '88.1%',
                        style: CustomTextStyles.bodyLargeGreen,
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        '2',
                        style: CustomTextStyles.bodyLargeSkyBlue,
                      )),
                      DataCell(Text(
                        '2회차',
                        style: CustomTextStyles.bodyLargeBlack
                            .copyWith(decoration: TextDecoration.underline),
                      )),
                      DataCell(Text(
                        '3,456',
                        style: CustomTextStyles.bodyLargeBlack,
                      )),
                      DataCell(Text(
                        '3,920',
                        style: CustomTextStyles.bodyLargeBlack,
                      )),
                      DataCell(Text(
                        '88.1%',
                        style: CustomTextStyles.bodyLargeGreen,
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        '3',
                        style: CustomTextStyles.bodyLargeSkyBlue,
                      )),
                      DataCell(Text(
                        '3회차',
                        style: CustomTextStyles.bodyLargeBlack
                            .copyWith(decoration: TextDecoration.underline),
                      )),
                      DataCell(Text(
                        '3,456',
                        style: CustomTextStyles.bodyLargeBlack,
                      )),
                      DataCell(Text(
                        '3,920',
                        style: CustomTextStyles.bodyLargeBlack,
                      )),
                      DataCell(Text(
                        '88.1%',
                        style: CustomTextStyles.bodyLargeGreen,
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        '4',
                        style: CustomTextStyles.bodyLargeSkyBlue,
                      )),
                      DataCell(Text(
                        '4회차',
                        style: CustomTextStyles.bodyLargeBlack
                            .copyWith(decoration: TextDecoration.underline),
                      )),
                      DataCell(Text(
                        '3,456',
                        style: CustomTextStyles.bodyLargeBlack,
                      )),
                      DataCell(Text(
                        '3,920',
                        style: CustomTextStyles.bodyLargeBlack,
                      )),
                      DataCell(Text(
                        '88.1%',
                        style: CustomTextStyles.bodyLargeGreen,
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        '5',
                        style: CustomTextStyles.bodyLargeSkyBlue,
                      )),
                      DataCell(Text(
                        '5회차',
                        style: CustomTextStyles.bodyLargeBlack
                            .copyWith(decoration: TextDecoration.underline),
                      )),
                      DataCell(Text(
                        '3,456',
                        style: CustomTextStyles.bodyLargeBlack,
                      )),
                      DataCell(Text(
                        '3,920',
                        style: CustomTextStyles.bodyLargeBlack,
                      )),
                      DataCell(Text(
                        '88.1%',
                        style: CustomTextStyles.bodyLargeGreen,
                      )),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Obx(() => Stack(alignment: Alignment.centerLeft, children: [
                    CustomElevatedButton(
                      text: '비활성',
                      buttonTextStyle: CustomTextStyles.bodyMediumRed.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      buttonStyle: CustomButtonStyles.fillRedTransparent,
                      // margin: const EdgeInsets.symmetric(
                      //     vertical: 11, horizontal: 24),
                      width: 90,
                      height: 44,
                    ),
                    Pages(
                        pages: 100,
                        activePage: controller.activePage.value,
                        onTap: (int pageNum) {
                          controller.loadNewPage(pageNum);
                        }),
                  ]))
            ],
          )),
    );
  }
}

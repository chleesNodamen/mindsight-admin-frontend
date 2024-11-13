import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/company_manage/inactive_company_manage_controller.dart';

class InactiveCompanyManageView
    extends GetWidget<InactiveCompanyManageController> {
  const InactiveCompanyManageView({super.key});

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
                              margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildTitle(),
                                  const SizedBox(height: 32),
                                  // _buildCheckBox(),
                                  // const SizedBox(height: 16),
                                  _buildPage(),
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

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "비승인 회사 관리",
      searchShow: true,
      viewCount: false,
      searchText: "회사 이름 검색",
      memberShow: true,
      memberCount: controller.companyListModel.total,
      onSearch: controller.onSearch,
    );
  }

  SingleChildScrollView _buildPage() {
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
                      label: Text("회사 이름",
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("대표자 이름",
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("사업자 번호",
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label:
                          Text("전환일", style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label:
                          Text("상태", style: CustomTextStyles.labelLargeGray)),
                ],
                rows:
                    List.generate(controller.companyListModel.total!, (index) {
                  return DataRow(
                      selected: controller.selectedCompany[index],
                      onSelectChanged: (bool? value) {
                        controller.onSelectedCompany(index);
                      },
                      cells: [
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.companyListModel.companyName![index],
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: InkWell(
                            child: Text(
                                controller
                                    .companyListModel.representative![index],
                                style: CustomTextStyles.bodyLargeBlack.copyWith(
                                    decoration: TextDecoration.underline)),
                            onTap: () {
                              controller.onCompanyTap(
                                  controller.companyListModel.id![index]);
                            },
                          ),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller
                                  .companyListModel.businessNumber![index],
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.companyListModel.createdAt != null
                                  ? DateFormat("yyyy-MM-dd").format(controller
                                      .companyListModel.createdAt![index])
                                  : "",
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(DecoratedBox(
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
                              value: controller.companyVerified![index]
                                  ? "승인"
                                  : "비승인",
                              underline: Container(),
                              padding: const EdgeInsets.only(left: 6),
                              borderRadius: BorderRadiusStyle.roundedBorder12,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.companyVerified![index] =
                                      !controller.companyVerified![index];
                                  controller.onVerifiedChange(index);
                                }
                              },
                              items: <String>[
                                "승인",
                                "비승인"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: value == "승인"
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
            Obx(
              () => Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Row(
                    children: [
                      CustomElevatedButton(
                        text: "승인",
                        buttonTextStyle: CustomTextStyles.bodyMediumSkyBlueBold,
                        buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
                        width: 90,
                        height: 44,
                        onPressed: controller.onVerifiedButton,
                      ),
                    ],
                  ),
                  Pages(
                      pages: (controller.companyListModel.total! / 20).ceil(),
                      activePage: controller.activePage.value,
                      onTap: (int pageNum) {
                        controller.loadPage(pageNum);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

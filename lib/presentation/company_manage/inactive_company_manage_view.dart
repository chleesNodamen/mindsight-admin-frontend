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
      name: "비활성 회사 관리".tr,
      searchShow: true,
      viewCount: false,
      searchText: "회사 이름 검색".tr,
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
                      label: Text("회사 이름".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("대표자 이름".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("사업자 번호".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("전환일".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("상태".tr,
                          style: CustomTextStyles.labelLargeGray)),
                ],
                rows: List.generate(controller.companyListModel.id!.length,
                    (index) {
                  return DataRow(
                      selected: controller.selectedCompany[index],
                      onSelectChanged: (bool? value) {
                        controller.onSelectedCompany(index);
                      },
                      cells: [
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: InkWell(
                            onTap: () {
                              controller.onCompanyTap(
                                  controller.companyListModel.id![index]);
                            },
                            child: Text(
                                controller.companyListModel.companyName![index],
                                style: CustomTextStyles.bodyLargeBlack.copyWith(
                                    decoration: TextDecoration.underline)),
                          ),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller
                                  .companyListModel.representative![index],
                              style: CustomTextStyles.bodyLargeBlack),
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
                        DataCell(StatusDropdown(
                          isEnable: Account.isAdmin,
                          isActive:
                              controller.companyListModel.verified![index],
                          onChanged: (newState) {
                            controller.onVerifiedChange(index);
                          },
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
                      Visibility(
                        visible: Account.isAdmin,
                        child: CustomElevatedButton(
                          text: "활성".tr,
                          buttonTextStyle:
                              CustomTextStyles.bodyMediumSkyBlueBold,
                          buttonStyle:
                              CustomButtonStyles.fillPrimaryTransparent,
                          width: 90,
                          height: 44,
                          onPressed: controller.onVerifiedButton,
                        ),
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

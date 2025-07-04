import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_manage_controller.dart';

class CompanyManageView extends GetWidget<CompanyManageController> {
  const CompanyManageView({super.key});

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
                                  Row(
                                    children: [
                                      _buildRegisterButton(),
                                      // const SizedBox(width: 16),
                                      // _buildMassRegisterButton(),
                                    ],
                                  ),
                                  const SizedBox(height: 32),
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
      name: "Company list".tr,
      searchShow: true,
      viewCount: false,
      searchText: "Search company name".tr,
      memberShow: true,
      memberCount: controller.companyListModel.total,
      onSearch: controller.onSearch,
    );
  }

  CustomElevatedButton _buildRegisterButton() {
    return CustomElevatedButton(
      onPressed: () {
        Get.offAllNamed(AppRoutes.companyRegister);
      },
      text: "New registration".tr,
      height: 44,
      // width: 107,
      decoration:
          BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder12),
    );
  }

  CustomElevatedButton _buildMassRegisterButton() {
    return CustomElevatedButton(
      onPressed: () {
        Get.offAllNamed(AppRoutes.companyMassRegister);
      },
      text: "Mass New registration".tr,
      height: 44,
      // width: 107,
      decoration:
          BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder12),
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
                showCheckboxColumn: Account.isAdmin,
                columnSpacing: 0,
                checkboxHorizontalMargin: 0,
                dataRowMaxHeight: 80,
                border: TableBorder(
                    horizontalInside: BorderSide(color: appTheme.grayScale2)),
                columns: [
                  DataColumn(
                      label: Text("Company name".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Representative".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Business number".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Registration date".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Approval".tr,
                          style: CustomTextStyles.labelLargeGray)),
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
                                  ? DateFormat('yyyy-MM-dd').format(controller
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
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Visibility(
                  visible: Account.isAdmin,
                  child: CustomElevatedButton(
                    text: "Inactive".tr,
                    buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
                    buttonStyle: CustomButtonStyles.fillRedTransparent,
                    // margin: const EdgeInsets.symmetric(
                    //     vertical: 11, horizontal: 24),
                    // width: 90,
                    height: 44,
                    onPressed: controller.onVerifiedButton,
                  ),
                ),
                Pages(
                    pages: (controller.companyListModel.total! / 20).ceil(),
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
}

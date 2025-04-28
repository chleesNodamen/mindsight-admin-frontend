import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/master_settlement_manage_controller.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/widget/custom_month_picker_dialog.dart';

class MasterSettlementManageView
    extends GetWidget<MasterSettlementManageController> {
  const MasterSettlementManageView({super.key});

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
                                  TobBarSearch(
                                    name: "Master Settlement".tr,
                                    searchShow: false,
                                    viewCount: false,
                                    searchText: "Search master name".tr,
                                  ),
                                  const SizedBox(height: 32),
                                  _buildSelect(context),
                                  const SizedBox(height: 32),
                                  _buildSummary(),
                                  const SizedBox(height: 32),
                                  Text("Streaming settlement".tr,
                                      style: CustomTextStyles.bodyLargeBlack),
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

  Widget _buildSummary() {
    return Row(
      children: [
        Text(
            "${"Sales aggregation".tr} ${controller.selectedMonth} ${"Month".tr}   ",
            style: CustomTextStyles.labelLargeBlack),
        Text("(${controller.dateRange})",
            style: CustomTextStyles.labelLargeGray),
      ],
    );
  }

  Container _buildSelect(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      // height: 268,
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomElevatedButton(
                      text: "Last month".tr,
                      buttonTextStyle: controller.selectedMonthType.value ==
                              MonthType.lastMonth
                          ? CustomTextStyles.bodyMediumWhiteBold
                          : CustomTextStyles.bodyMediumSkyBlueBold,
                      buttonStyle: controller.selectedMonthType.value ==
                              MonthType.lastMonth
                          ? CustomButtonStyles.fillPrimary
                          : CustomButtonStyles.fillPrimaryTransparent,
                      height: 44,
                      onPressed: () async =>
                          await controller.changeMonth(MonthType.lastMonth),
                    ),
                    CustomElevatedButton(
                      text: "This month".tr,
                      buttonTextStyle: controller.selectedMonthType.value ==
                              MonthType.thisMonth
                          ? CustomTextStyles.bodyMediumWhiteBold
                          : CustomTextStyles.bodyMediumSkyBlueBold,
                      buttonStyle: controller.selectedMonthType.value ==
                              MonthType.thisMonth
                          ? CustomButtonStyles.fillPrimary
                          : CustomButtonStyles.fillPrimaryTransparent,
                      margin: const EdgeInsets.only(left: 10),
                      height: 44,
                      onPressed: () async =>
                          await controller.changeMonth(MonthType.thisMonth),
                    ),
                    CustomElevatedButton(
                      text: "${"Select month".tr}   ",
                      decoration: AppDecoration.outlineGray,
                      rightIcon: CustomImageView(
                        imagePath: IconConstant.aabbcc,
                        color: controller.selectedMonthType.value ==
                                MonthType.selectedMonth
                            ? appTheme.white
                            : appTheme.black,
                      ),
                      buttonTextStyle: controller.selectedMonthType.value ==
                              MonthType.selectedMonth
                          ? CustomTextStyles.bodyMediumWhiteBold
                          : CustomTextStyles.bodyMediumGray,
                      buttonStyle: controller.selectedMonthType.value ==
                              MonthType.selectedMonth
                          ? CustomButtonStyles.fillPrimary
                          : CustomButtonStyles.fillTransparent,
                      margin: const EdgeInsets.only(left: 10),
                      height: 44,
                      // onPressed: () {
                      //   showDialog(
                      //     context: context,
                      //     builder: (context) => const CustomMonthPickerDialog(),
                      //   );
                      // },
                      onPressed: () async {
                        final result = await showDialog<Map<String, int>>(
                          context: context,
                          builder: (context) => const CustomMonthPickerDialog(),
                        );

                        if (result != null) {
                          controller.changeMonth(MonthType.selectedMonth,
                              year: result['year']!,
                              monthNumber: result['monthNumber']!);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
                showCheckboxColumn: false,
                columnSpacing: 20,
                checkboxHorizontalMargin: 0,
                dataRowMaxHeight: 80,
                border: TableBorder(
                    horizontalInside: BorderSide(color: appTheme.grayScale2)),
                columns: [
                  DataColumn(
                      label: Text(
                    "Master name".tr,
                    style: CustomTextStyles.labelLargeGray,
                  )),
                  DataColumn(
                      label: Text("Profit margin".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text(
                    "Total play count".tr,
                    style: CustomTextStyles.labelLargeGray,
                    textAlign: TextAlign.center,
                  )),
                  DataColumn(
                      label: Text("Total View Rate".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text(
                    "Net Settlement Amount\n(Including VAT)".tr,
                    style: CustomTextStyles.labelLargeGray,
                    textAlign: TextAlign.center,
                  )),
                  DataColumn(
                      label: Text("Tax Invoice".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text(
                    "Deposit Status".tr,
                    style: CustomTextStyles.labelLargeGray,
                    textAlign: TextAlign.center,
                  )),
                  DataColumn(
                      label: Text(
                    "Memo".tr,
                    style: CustomTextStyles.labelLargeGray,
                    textAlign: TextAlign.center,
                  )),
                ],
                rows: List.generate(controller.masterSettlementListModel.length,
                    (index) {
                  return DataRow(
                      selected: false,
                      onSelectChanged: (bool? value) {},
                      cells: [
                        DataCell(InkWell(
                          child: Text(
                              controller.masterSettlementListModel.name![index],
                              style: CustomTextStyles.bodyLargeBlack.copyWith(
                                  decoration: TextDecoration.underline)),
                          onTap: () {},
                        )),
                        DataCell(Text(
                            "${controller.masterSettlementListModel.currentProfitRate![index]}%",
                            style: CustomTextStyles.bodyLargeBlack)),
                        DataCell(Text(
                            controller
                                .masterSettlementListModel.playCount![index]
                                .toString(),
                            style: CustomTextStyles.bodyLargeBlack)),
                        DataCell(Text("${controller.getViewRate(index)}%",
                            style: CustomTextStyles.bodyLargeBlack)),
                        DataCell(Text(controller.getSettlementAmount(index),
                            style: CustomTextStyles.bodyLargeBlack)),
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Unissued".tr,
                                style: CustomTextStyles.bodyLargeBlack),
                            CustomElevatedButton(
                              text: "Issued".tr,
                              buttonTextStyle:
                                  CustomTextStyles.bodyMediumWhiteBold,
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              // width: 60,
                              height: 30,
                              margin: const EdgeInsets.only(top: 10),
                              // onPressed: _buildTotalSalesDetailModal,
                            )
                          ],
                        )),
                        DataCell(Text("Payment Completed",
                            style: CustomTextStyles.bodyLargeBlack)),
                        DataCell(
                            Text("", style: CustomTextStyles.bodyLargeBlack)),
                      ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

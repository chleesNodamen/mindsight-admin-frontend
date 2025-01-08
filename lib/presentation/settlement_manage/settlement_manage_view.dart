import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/widget/custom_month_picker_dialog.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/settlement_manage_controller.dart';

class SettlementManageView extends GetWidget<SettlementManageController> {
  const SettlementManageView({super.key});

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
                                    name: "Streaming Details".tr,
                                    searchShow: false,
                                    viewCount: false,
                                    searchText: "Search master name".tr,
                                    onSearch: controller.onSearch,
                                  ),
                                  const SizedBox(height: 32),
                                  _buildSelect(context),
                                  const SizedBox(height: 32),
                                  _buildSummary(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
                "${"Sales aggregation".tr} ${controller.selectedMonth} ${"Month".tr}   ",
                style: CustomTextStyles.labelLargeBlack),
            Text("(${controller.dateRange})",
                style: CustomTextStyles.labelLargeGray),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            _buildSummaryCard(
                "Total Monthly Sales".tr,
                CustomTextStyles.labelLargeGray,
                controller.settlementSummaryModel.totalSales!),
            _buildSummaryCard(
                "Total Monthly Play Count".tr,
                CustomTextStyles.labelLargeGray,
                controller.settlementSummaryModel.playCount!.toDouble()),
          ],
        ),
      ],
    );
  }

  Container _buildSummaryCard(
      String title, TextStyle titleTextStyle, double amount) {
    return Container(
      width: 260,
      decoration: AppDecoration.outlineGray,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleTextStyle),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "$amount",
              style: CustomTextStyles.titleLargeBlack,
            ),
          ),
        ],
      ),
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
                columnSpacing: 0,
                checkboxHorizontalMargin: 0,
                dataRowMaxHeight: 80,
                border: TableBorder(
                    horizontalInside: BorderSide(color: appTheme.grayScale2)),
                columns: [
                  DataColumn(
                      label: Text(
                    "Content name".tr,
                    style: CustomTextStyles.labelLargeGray,
                  )),
                  DataColumn(
                      label: Text("Share rate".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text(
                    "Play count".tr,
                    style: CustomTextStyles.labelLargeGray,
                    textAlign: TextAlign.center,
                  )),
                  DataColumn(
                      label: Text("View rate per content".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text(
                    "Settlement per content".tr,
                    style: CustomTextStyles.labelLargeGray,
                    textAlign: TextAlign.center,
                  )),
                ],
                rows: List.generate(
                    controller.masterContentSettlementListModel.length,
                    (index) {
                  return DataRow(
                      selected: false,
                      onSelectChanged: (bool? value) {},
                      cells: [
                        DataCell(InkWell(
                          child: Text(
                              controller.masterContentSettlementListModel
                                  .name![index],
                              style: CustomTextStyles.bodyLargeBlack.copyWith(
                                  decoration: TextDecoration.underline)),
                          onTap: () {},
                        )),
                        DataCell(Text("35%",
                            style: CustomTextStyles.bodyLargeBlack)),
                        DataCell(Text(
                            "${controller.masterContentSettlementListModel.playCount![index]}",
                            style: CustomTextStyles.bodyLargeBlack)),
                        DataCell(Text("${controller.getViewRate(index)}%",
                            style: CustomTextStyles.bodyLargeBlack)),
                        DataCell(Text(controller.getSettlementAmount(index),
                            style: CustomTextStyles.bodyLargeBlack)),
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
                        text: "Download Excel".tr,
                        buttonTextStyle: CustomTextStyles.bodyMediumSkyBlueBold,
                        buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
                        // width: 135,
                        height: 44,
                        // onPressed: controller.onStatusChangeForAll,
                      ),
                    ],
                  ),
                  Pages(
                      pages:
                          (controller.masterContentSettlementListModel.total! /
                                  20)
                              .ceil(),
                      activePage: controller.activePage.value,
                      onTap: (int pageNum) {
                        // controller.loadPage(pageNum);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _buildTotalSalesDetailModal() async {
    await controller.reqPurchaseList();

    return Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.zero,
        backgroundColor: appTheme.background,
        radius: 12,
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder12,
              color: appTheme.background),
          // width: 1500,
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Monthly Subscription Total Sales Detail".tr,
                        style: CustomTextStyles.headlineLargeBlack,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${controller.selectedMonth} ${"Month".tr} (${controller.dateRange})",
                        style: CustomTextStyles.labelLargeGray,
                      ),
                    ],
                  ),
                  CustomImageView(
                    imagePath: IconConstant.close,
                    onTap: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                decoration: BoxDecoration(
                  color: appTheme.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                height: 60,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          // 첫 번째 ListTile
                          Expanded(
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              title: Row(
                                children: <Widget>[
                                  Radio<Type>(
                                    value: Type.all,
                                    groupValue: controller.type.value,
                                    onChanged: (Type? value) {
                                      controller.changeType(value);
                                    },
                                  ),
                                  Text(
                                    "All".tr,
                                    style: CustomTextStyles.bodyMediumBlack
                                        .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // 두 번째 ListTile
                          Expanded(
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              title: Row(
                                children: <Widget>[
                                  Radio<Type>(
                                    value: Type.notIssued,
                                    groupValue: controller.type.value,
                                    onChanged: (Type? value) {
                                      controller.changeType(value);
                                    },
                                  ),
                                  Text(
                                    "PG".tr,
                                    style: CustomTextStyles.bodyMediumBlack
                                        .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // 세 번째 ListTile
                          Expanded(
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              title: Row(
                                children: <Widget>[
                                  Radio<Type>(
                                    value: Type.notSettled,
                                    groupValue: controller.type.value,
                                    onChanged: (Type? value) {
                                      controller.changeType(value);
                                    },
                                  ),
                                  Text(
                                    "App Payment".tr,
                                    style: CustomTextStyles.bodyMediumBlack
                                        .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // 네 번째 ListTile
                          Expanded(
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              title: Row(
                                children: <Widget>[
                                  Radio<Type>(
                                    value: Type.notSettled, // 수정된 타입 값
                                    groupValue: controller.type.value,
                                    onChanged: (Type? value) {
                                      controller.changeType(value);
                                    },
                                  ),
                                  Text(
                                    "Others".tr,
                                    style: CustomTextStyles.bodyMediumBlack
                                        .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
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
                          columnSpacing: 30,
                          checkboxHorizontalMargin: 0,
                          dataRowMaxHeight: 80,
                          border: TableBorder(
                              horizontalInside:
                                  BorderSide(color: appTheme.grayScale2)),
                          columns: [
                            DataColumn(
                                label: Text(
                              "Buyer name\n(Member ID)".tr,
                              style: CustomTextStyles.labelLargeGray,
                              textAlign: TextAlign.center,
                            )),
                            DataColumn(
                                label: Text(
                              "Transaction datetime".tr,
                              style: CustomTextStyles.labelLargeGray,
                              textAlign: TextAlign.center,
                            )),
                            DataColumn(
                                label: Text("Cancellation datetime".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text(
                              "Membership name".tr,
                              style: CustomTextStyles.labelLargeGray,
                              textAlign: TextAlign.center,
                            )),
                            DataColumn(
                                label: Text("Amount".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text("Approval number".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text("Payment agency".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text("Fee".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text("Net sales".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text("Other fee\n(Copyright)".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text("Net sales".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                          ],
                          rows: List.generate(
                              controller.purchaseListModel.length, (index) {
                            return DataRow(
                                selected: false,
                                onSelectChanged: (bool? value) {},
                                cells: [
                                  DataCell(InkWell(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            controller.purchaseListModel
                                                .buyer![index],
                                            style: CustomTextStyles
                                                .bodyLargeBlack
                                                .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            )),
                                        Text(
                                            controller.purchaseListModel
                                                .email![index],
                                            style: CustomTextStyles
                                                .labelLargeGray
                                                .copyWith(
                                                    decoration: TextDecoration
                                                        .underline)),
                                      ],
                                    ),
                                    onTap: () {},
                                  )),
                                  DataCell(Text(
                                      DateFormat('yyyy-MM-dd').format(controller
                                          .purchaseListModel
                                          .transactionDate![index]),
                                      style: CustomTextStyles.bodyLargeBlack)),
                                  DataCell(Text('-',
                                      style: CustomTextStyles.bodyLargeBlack)),
                                  DataCell(Text(
                                      controller.purchaseListModel
                                          .membershipName![index],
                                      style: CustomTextStyles.bodyLargeBlack)),
                                  DataCell(Text(
                                      "${controller.purchaseListModel.amount![index]}",
                                      style: CustomTextStyles.bodyLargeBlack)),
                                  DataCell(Text(
                                      controller.purchaseListModel
                                          .approvalNumber![index],
                                      style: CustomTextStyles.bodyLargeBlack)),
                                  DataCell(Text(
                                      controller.purchaseListModel
                                          .paymentGateway![index],
                                      style: CustomTextStyles.bodyLargeBlack)),
                                  DataCell(Text(
                                      "${controller.purchaseListModel.fee![index]}%",
                                      style: CustomTextStyles.bodyLargeBlack)),
                                  DataCell(Text(
                                      "${controller.purchaseListModel.netSales![index]}",
                                      style: CustomTextStyles.bodyLargeBlack)),
                                  DataCell(Text(
                                      "${controller.purchaseListModel.otherFees![index]}%",
                                      style: CustomTextStyles.bodyLargeBlack)),
                                  DataCell(Text(
                                      "${controller.purchaseListModel.finalSales![index]}",
                                      style: CustomTextStyles.bodyLargeBlack)),
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
                            CustomElevatedButton(
                              text: "Download Excel".tr,
                              buttonTextStyle:
                                  CustomTextStyles.bodyMediumSkyBlueBold,
                              buttonStyle:
                                  CustomButtonStyles.fillPrimaryTransparent,
                              // width: 135,
                              height: 44,
                              // onPressed: controller.onStatusChangeForAll,
                            ),
                            Pages(
                                pages: (controller
                                            .masterContentSettlementListModel
                                            .total! /
                                        20)
                                    .ceil(),
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
              )
            ],
          ),
        ));
  }

  // Future<dynamic> _buildMasterContentSettlementListModal(int index) async {
  //   await controller.loadPage(1);

  //   return Get.defaultDialog(
  //       title: '',
  //       titlePadding: EdgeInsets.zero,
  //       backgroundColor: appTheme.background,
  //       radius: 12,
  //       content: Obx(() => Container(
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadiusStyle.roundedBorder12,
  //                 color: appTheme.background),
  //             padding: const EdgeInsets.only(left: 32, right: 32, bottom: 15),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           controller.masterSettlementListModel.name![index],
  //                           style: CustomTextStyles.headlineLargeBlack.copyWith(
  //                             decoration: TextDecoration.underline,
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 5,
  //                         ),
  //                         Text(
  //                           "Settlement by play count".tr,
  //                           style: CustomTextStyles.titleLargeBlack,
  //                         ),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         Row(
  //                           children: [
  //                             Text(
  //                               "${controller.selectedMonth} ${"Month".tr}",
  //                               style: CustomTextStyles.labelLargeBlack,
  //                             ),
  //                             Text(
  //                               " (${controller.dateRange})",
  //                               style: CustomTextStyles.labelLargeGray,
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     CustomImageView(
  //                       imagePath: IconConstant.close,
  //                       onTap: () => Get.back(),
  //                       margin: const EdgeInsets.only(left: 20),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(
  //                   height: 32,
  //                 ),
  //                 SingleChildScrollView(
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       color: appTheme.white,
  //                       borderRadius:
  //                           const BorderRadius.all(Radius.circular(12)),
  //                     ),
  //                     // height: 1016,
  //                     width: double.infinity,
  //                     padding: const EdgeInsets.all(32.0),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         SizedBox(
  //                           width: double.infinity,
  //                           child: DataTable(
  //                             columnSpacing: 30,
  //                             checkboxHorizontalMargin: 0,
  //                             dataRowMaxHeight: 80,
  //                             border: TableBorder(
  //                                 horizontalInside:
  //                                     BorderSide(color: appTheme.grayScale2)),
  //                             columns: [
  //                               DataColumn(
  //                                   label: Text(
  //                                 "Content name".tr,
  //                                 style: CustomTextStyles.labelLargeGray,
  //                                 textAlign: TextAlign.center,
  //                               )),
  //                               DataColumn(
  //                                   label: Text(
  //                                 "Share rate".tr,
  //                                 style: CustomTextStyles.labelLargeRed,
  //                                 textAlign: TextAlign.center,
  //                               )),
  //                               DataColumn(
  //                                   label: Text("Play count".tr,
  //                                       style:
  //                                           CustomTextStyles.labelLargeGray)),
  //                               DataColumn(
  //                                   label: Text(
  //                                 "View rate per content".tr,
  //                                 style: CustomTextStyles.labelLargeGray,
  //                                 textAlign: TextAlign.center,
  //                               )),
  //                               DataColumn(
  //                                   label: Text("Settlement per content".tr,
  //                                       style:
  //                                           CustomTextStyles.labelLargeGray)),
  //                             ],
  //                             rows: List.generate(
  //                                 controller.masterContentSettlementListModel
  //                                     .value.length, (index2) {
  //                               return DataRow(
  //                                   selected: false,
  //                                   onSelectChanged: (bool? value) {},
  //                                   cells: [
  //                                     DataCell(Padding(
  //                                       padding: const EdgeInsets.symmetric(
  //                                           vertical: 24.0),
  //                                       child: InkWell(
  //                                         child: Text(
  //                                             controller
  //                                                 .masterContentSettlementListModel
  //                                                 .value
  //                                                 .name![index2],
  //                                             style: CustomTextStyles
  //                                                 .bodyLargeBlack),
  //                                         onTap: () {},
  //                                       ),
  //                                     )),
  //                                     DataCell(Padding(
  //                                       padding: const EdgeInsets.symmetric(
  //                                           vertical: 24.0),
  //                                       child: Text(
  //                                           "${controller.masterSettlementListModel.currentProfitRate![index]}%",
  //                                           style: CustomTextStyles
  //                                               .bodyLargeBlack),
  //                                     )),
  //                                     DataCell(Padding(
  //                                       padding: const EdgeInsets.symmetric(
  //                                           vertical: 24.0),
  //                                       child: Text(
  //                                           controller
  //                                               .masterContentSettlementListModel
  //                                               .value
  //                                               .playCount![index2]
  //                                               .toString(),
  //                                           style: CustomTextStyles
  //                                               .bodyLargeBlack),
  //                                     )),
  //                                     DataCell(Padding(
  //                                       padding: const EdgeInsets.symmetric(
  //                                           vertical: 24.0),
  //                                       child: Text(
  //                                           "${controller.getViewRate(controller.masterContentSettlementListModel.value.playCount![index2], controller.settlementSummaryModel.playCount!)}%",
  //                                           style: CustomTextStyles
  //                                               .bodyLargeBlack),
  //                                     )),
  //                                     DataCell(Padding(
  //                                       padding: const EdgeInsets.symmetric(
  //                                           vertical: 24.0),
  //                                       child: Text(
  //                                           controller.getSettlementAmount(
  //                                               controller
  //                                                   .masterContentSettlementListModel
  //                                                   .value
  //                                                   .playCount![index2],
  //                                               controller
  //                                                   .settlementSummaryModel
  //                                                   .playCount!,
  //                                               controller
  //                                                   .masterSettlementListModel
  //                                                   .currentProfitRate![index],
  //                                               controller
  //                                                   .settlementSummaryModel
  //                                                   .finalSales!),
  //                                           style: CustomTextStyles
  //                                               .bodyLargeBlack),
  //                                     )),
  //                                   ]);
  //                             }).toList(),
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 32,
  //                         ),
  //                         Stack(
  //                           alignment: Alignment.centerLeft,
  //                           children: [
  //                             CustomElevatedButton(
  //                               text: "Download Excel".tr,
  //                               buttonTextStyle:
  //                                   CustomTextStyles.bodyMediumSkyBlueBold,
  //                               buttonStyle:
  //                                   CustomButtonStyles.fillPrimaryTransparent,
  //                               height: 44,
  //                             ),
  //                             Pages(
  //                                 pages: (controller
  //                                             .masterContentSettlementListModel
  //                                             .value
  //                                             .total! /
  //                                         4)
  //                                     .ceil(),
  //                                 activePage: controller
  //                                     .activePageMasterContentSettlementList
  //                                     .value,
  //                                 onTap: (int pageNum) async {
  //                                   await controller.loadPage(pageNum);
  //                                 }),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           )));
  // }
}

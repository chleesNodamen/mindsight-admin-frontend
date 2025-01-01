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
                                    name: "스트리밍 정산".tr,
                                    searchShow: false,
                                    viewCount: false,
                                    searchText: "마스터 이름 검색".tr,
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
            Text("${"매출 집계기간".tr} ${controller.selectedMonth}월   ",
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
            InkWell(
                onTap: _buildTotalSalesDetailModal,
                child: _buildSummaryCard(
                    "${"월 전체 매출액".tr} >",
                    CustomTextStyles.labelLargeGray,
                    controller.settlementSummaryModel.totalSales!)),
            _buildSummaryCard("월 PG 수수료".tr, CustomTextStyles.labelLargeRed, 0),
            _buildSummaryCard(
                "월 스토어 수수료".tr, CustomTextStyles.labelLargeRed, 0),
            _buildSummaryCard("월 기타 수수료".tr, CustomTextStyles.labelLargeRed, 0),
            InkWell(
              onTap: _buildTotalSalesDetailModal,
              child: _buildSummaryCard(
                  "${"월 전체 순 매출액".tr} >",
                  CustomTextStyles.labelLargeGray,
                  controller.settlementSummaryModel.netSales!),
            ),
            _buildSummaryCard("월 총 플레이 횟수".tr, CustomTextStyles.labelLargeGray,
                controller.settlementSummaryModel.playCount!.toDouble()),
            _buildSummaryCard(
                "월 전체 지급 금액".tr, CustomTextStyles.labelLargeRed, 0),
            _buildSummaryCard("월 영업이익".tr, CustomTextStyles.labelLargeGray,
                controller.settlementSummaryModel.finalSales!),
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
                      SizedBox(
                        width: 85,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
                              title: Row(
                                children: <Widget>[
                                  Radio<Type>(
                                    value: Type.all,
                                    groupValue: controller.type.value,
                                    onChanged: (Type? value) {
                                      controller.changeType(value);
                                    },
                                  ),
                                  Text(controller.typeLabels[0],
                                      style: CustomTextStyles.bodyMediumBlack
                                          .copyWith(
                                              fontWeight: FontWeight.w500)),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 85,
                        child: ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: 0.0, right: 0.0),
                            title: Row(
                              children: <Widget>[
                                Radio<Type>(
                                  value: Type.notIssued,
                                  groupValue: controller.type.value,
                                  onChanged: (Type? value) {
                                    controller.changeType(value);
                                  },
                                ),
                                Text(controller.typeLabels[1],
                                    style: CustomTextStyles.bodyMediumBlack
                                        .copyWith(fontWeight: FontWeight.w500)),
                              ],
                            )),
                      ),
                      SizedBox(
                        width: 85,
                        child: ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: 0.0, right: 0.0),
                            title: Row(
                              children: <Widget>[
                                Radio<Type>(
                                  value: Type.notSettled,
                                  groupValue: controller.type.value,
                                  onChanged: (Type? value) {
                                    controller.changeType(value);
                                  },
                                ),
                                Text(controller.typeLabels[2],
                                    style: CustomTextStyles.bodyMediumBlack
                                        .copyWith(fontWeight: FontWeight.w500)),
                              ],
                            )),
                      ),
                      CustomElevatedButton(
                        text: "지난 달".tr,
                        buttonTextStyle: controller.selectedMonthType.value ==
                                MonthType.lastMonth
                            ? CustomTextStyles.bodyMediumWhiteBold
                            : CustomTextStyles.bodyMediumSkyBlueBold,
                        buttonStyle: controller.selectedMonthType.value ==
                                MonthType.lastMonth
                            ? CustomButtonStyles.fillPrimary
                            : CustomButtonStyles.fillPrimaryTransparent,
                        margin: const EdgeInsets.only(left: 30),
                        width: 94,
                        height: 44,
                        onPressed: () async =>
                            await controller.changeMonth(MonthType.lastMonth),
                      ),
                      CustomElevatedButton(
                        text: "이번 달".tr,
                        buttonTextStyle: controller.selectedMonthType.value ==
                                MonthType.thisMonth
                            ? CustomTextStyles.bodyMediumWhiteBold
                            : CustomTextStyles.bodyMediumSkyBlueBold,
                        buttonStyle: controller.selectedMonthType.value ==
                                MonthType.thisMonth
                            ? CustomButtonStyles.fillPrimary
                            : CustomButtonStyles.fillPrimaryTransparent,
                        margin: const EdgeInsets.only(left: 10),
                        width: 94,
                        height: 44,
                        onPressed: () async =>
                            await controller.changeMonth(MonthType.thisMonth),
                      ),
                      CustomElevatedButton(
                        text: "${"월 선택".tr}   ",
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
                        width: 114,
                        height: 44,
                        onPressed: () {
                          // 커스텀 월 선택 다이얼로그 열기
                          showDialog(
                            context: context,
                            builder: (context) =>
                                const CustomMonthPickerDialog(),
                          );
                        },
                      ),
                    ],
                  ),
                ]),
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
                columnSpacing: 20,
                checkboxHorizontalMargin: 0,
                dataRowMaxHeight: 110,
                border: TableBorder(
                    horizontalInside: BorderSide(color: appTheme.grayScale2)),
                columns: [
                  // DataColumn(
                  //     label:
                  //         Text("집계기간", style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text(
                    "마스터 이름".tr,
                    style: CustomTextStyles.labelLargeGray,
                  )),
                  DataColumn(
                      label: Text("수익률".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text(
                    "총 플레이\n횟수".tr,
                    style: CustomTextStyles.labelLargeGray,
                    textAlign: TextAlign.center,
                  )),
                  DataColumn(
                      label: Text("월 시청률".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text(
                    "실정산금액\n(부가세포함)".tr,
                    style: CustomTextStyles.labelLargeGray,
                    textAlign: TextAlign.center,
                  )),
                  DataColumn(
                      label: Text("상태".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text(
                    "마스터별\n상세".tr,
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
                        // DataCell(Text(
                        //     controller.dateRange.replaceAll(" ~ ", "~\n"),
                        //     style: CustomTextStyles.labelLargeBlack)),
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
                        DataCell(Text(
                            "${controller.getViewRate(controller.masterSettlementListModel.playCount![index], controller.settlementSummaryModel.playCount!)}%",
                            style: CustomTextStyles.bodyLargeBlack)),
                        DataCell(Text(
                            // "${(controller.settlementSummaryModel.finalSales! * (((controller.masterSettlementListModel.playCount![index] / controller.settlementSummaryModel.playCount!) * 100) / 100) * (controller.masterSettlementListModel.currentProfitRate![index] / 100))}",
                            controller.getSettlementAmount(
                                controller.masterSettlementListModel
                                    .playCount![index],
                                controller.settlementSummaryModel.playCount!,
                                controller.masterSettlementListModel
                                    .currentProfitRate![index],
                                controller.settlementSummaryModel.finalSales!),
                            style: CustomTextStyles.bodyLargeBlack)),
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("미발행".tr,
                                style: CustomTextStyles.bodyLargeBlack),
                            CustomElevatedButton(
                              text: "발행".tr,
                              buttonTextStyle:
                                  CustomTextStyles.bodyMediumWhiteBold,
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              width: 60,
                              height: 30,
                              margin: const EdgeInsets.only(top: 10),
                              // onPressed: _buildTotalSalesDetailModal,
                            )
                          ],
                        )),
                        DataCell(CustomElevatedButton(
                          text: "보기".tr,
                          buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
                          buttonStyle: CustomButtonStyles.fillBlack,
                          width: 60,
                          height: 30,
                          onPressed: () =>
                              _buildMasterContentSettlementListModal(index),
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
                  CustomElevatedButton(
                    text: "엑셀 다운로드".tr,
                    buttonTextStyle: CustomTextStyles.bodyMediumSkyBlueBold,
                    buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
                    width: 135,
                    height: 44,
                    // onPressed: controller.onStatusChangeForAll,
                  ),
                  Positioned(
                    left: 150,
                    child: CustomElevatedButton(
                      text: "선택 집계".tr,
                      buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
                      buttonStyle: CustomButtonStyles.fillPrimary,
                      width: 107,
                      height: 44,
                      // onPressed: controller.onStatusChangeForAll,
                    ),
                  ),
                  Pages(
                      pages: (controller.masterSettlementListModel.total! / 20)
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
                        "월 구독 전체 매출액 상세".tr,
                        style: CustomTextStyles.headlineLargeBlack,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${controller.selectedMonth}월 (${controller.dateRange})",
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 85,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ListTile(
                                        contentPadding: const EdgeInsets.only(
                                            left: 0.0, right: 0.0),
                                        title: Row(
                                          children: <Widget>[
                                            Radio<Type>(
                                              value: Type.all,
                                              groupValue: controller.type.value,
                                              onChanged: (Type? value) {
                                                controller.changeType(value);
                                              },
                                            ),
                                            Text("전체".tr,
                                                style: CustomTextStyles
                                                    .bodyMediumBlack
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500)),
                                          ],
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 85,
                                  child: ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0.0, right: 0.0),
                                      title: Row(
                                        children: <Widget>[
                                          Radio<Type>(
                                            value: Type.notIssued,
                                            groupValue: controller.type.value,
                                            onChanged: (Type? value) {
                                              controller.changeType(value);
                                            },
                                          ),
                                          Text("PG",
                                              style: CustomTextStyles
                                                  .bodyMediumBlack
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  width: 85,
                                  child: ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0.0, right: 0.0),
                                      title: Row(
                                        children: <Widget>[
                                          Radio<Type>(
                                            value: Type.notSettled,
                                            groupValue: controller.type.value,
                                            onChanged: (Type? value) {
                                              controller.changeType(value);
                                            },
                                          ),
                                          Text("앱결제".tr,
                                              style: CustomTextStyles
                                                  .bodyMediumBlack
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0.0, right: 0.0),
                                      title: Row(
                                        children: <Widget>[
                                          Radio<Type>(
                                            value: Type.notSettled,
                                            groupValue: controller.type.value,
                                            onChanged: (Type? value) {
                                              controller.changeType(value);
                                            },
                                          ),
                                          Text("기타".tr,
                                              style: CustomTextStyles
                                                  .bodyMediumBlack
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ]),
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
                              "구매자명\n(회원 ID)".tr,
                              style: CustomTextStyles.labelLargeGray,
                              textAlign: TextAlign.center,
                            )),
                            DataColumn(
                                label: Text(
                              "거래일시".tr,
                              style: CustomTextStyles.labelLargeGray,
                              textAlign: TextAlign.center,
                            )),
                            DataColumn(
                                label: Text("취소일시".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text(
                              "멤버쉽명".tr,
                              style: CustomTextStyles.labelLargeGray,
                              textAlign: TextAlign.center,
                            )),
                            DataColumn(
                                label: Text("금액".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text("승인번호".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text("결제대행사".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text("수수료".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text("순매출액".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text("기타 수수료\n(저작권료)".tr,
                                    style: CustomTextStyles.labelLargeGray)),
                            DataColumn(
                                label: Text("순매출액".tr,
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
                              text: "엑셀 다운로드".tr,
                              buttonTextStyle:
                                  CustomTextStyles.bodyMediumSkyBlueBold,
                              buttonStyle:
                                  CustomButtonStyles.fillPrimaryTransparent,
                              width: 135,
                              height: 44,
                              // onPressed: controller.onStatusChangeForAll,
                            ),
                            Pages(
                                pages: (controller
                                            .masterSettlementListModel.total! /
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
              )
            ],
          ),
        ));
  }

  Future<dynamic> _buildMasterContentSettlementListModal(int index) async {
    await controller.reqMasterContentSettlementList(index, 1);

    return Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.zero,
        backgroundColor: appTheme.background,
        radius: 12,
        content: Obx(() => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  color: appTheme.background),
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
                            "${controller.masterSettlementListModel.name![index]} (${controller.masterSettlementListModel.email![index]})님의",
                            style: CustomTextStyles.headlineLargeBlack.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "작품별 플레이 횟수에 따른 정산 상세".tr,
                            style: CustomTextStyles.titleLargeBlack,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "${controller.selectedMonth}월",
                                style: CustomTextStyles.labelLargeBlack,
                              ),
                              Text(
                                " (${controller.dateRange})",
                                style: CustomTextStyles.labelLargeGray,
                              ),
                            ],
                          ),
                        ],
                      ),
                      CustomImageView(
                        imagePath: IconConstant.close,
                        onTap: () => Get.back(),
                        margin: const EdgeInsets.only(left: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: appTheme.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
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
                                  "콘텐츠명".tr,
                                  style: CustomTextStyles.labelLargeGray,
                                  textAlign: TextAlign.center,
                                )),
                                DataColumn(
                                    label: Text(
                                  "쉐어율".tr,
                                  style: CustomTextStyles.labelLargeRed,
                                  textAlign: TextAlign.center,
                                )),
                                DataColumn(
                                    label: Text("플레이 횟수".tr,
                                        style:
                                            CustomTextStyles.labelLargeGray)),
                                DataColumn(
                                    label: Text(
                                  "콘텐츠 별 시청율".tr,
                                  style: CustomTextStyles.labelLargeGray,
                                  textAlign: TextAlign.center,
                                )),
                                DataColumn(
                                    label: Text("콘텐츠 별 정산금액".tr,
                                        style:
                                            CustomTextStyles.labelLargeGray)),
                              ],
                              rows: List.generate(
                                  controller.masterContentSettlementListModel
                                      .value.length, (index2) {
                                return DataRow(
                                    selected: false,
                                    onSelectChanged: (bool? value) {},
                                    cells: [
                                      DataCell(Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24.0),
                                        child: InkWell(
                                          child: Text(
                                              controller
                                                  .masterContentSettlementListModel
                                                  .value
                                                  .name![index2],
                                              style: CustomTextStyles
                                                  .bodyLargeBlack),
                                          onTap: () {},
                                        ),
                                      )),
                                      DataCell(Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24.0),
                                        child: Text(
                                            "${controller.masterSettlementListModel.currentProfitRate![index]}%",
                                            style: CustomTextStyles
                                                .bodyLargeBlack),
                                      )),
                                      DataCell(Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24.0),
                                        child: Text(
                                            controller
                                                .masterContentSettlementListModel
                                                .value
                                                .playCount![index2]
                                                .toString(),
                                            style: CustomTextStyles
                                                .bodyLargeBlack),
                                      )),
                                      DataCell(Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24.0),
                                        child: Text(
                                            "${controller.getViewRate(controller.masterContentSettlementListModel.value.playCount![index2], controller.settlementSummaryModel.playCount!)}%",
                                            style: CustomTextStyles
                                                .bodyLargeBlack),
                                      )),
                                      DataCell(Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24.0),
                                        child: Text(
                                            controller.getSettlementAmount(
                                                controller
                                                    .masterContentSettlementListModel
                                                    .value
                                                    .playCount![index2],
                                                controller
                                                    .settlementSummaryModel
                                                    .playCount!,
                                                controller
                                                    .masterSettlementListModel
                                                    .currentProfitRate![index],
                                                controller
                                                    .settlementSummaryModel
                                                    .finalSales!),
                                            style: CustomTextStyles
                                                .bodyLargeBlack),
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
                              CustomElevatedButton(
                                text: "엑셀 다운로드".tr,
                                buttonTextStyle:
                                    CustomTextStyles.bodyMediumSkyBlueBold,
                                buttonStyle:
                                    CustomButtonStyles.fillPrimaryTransparent,
                                width: 135,
                                height: 44,
                                // onPressed: controller.onStatusChangeForAll,
                              ),
                              Pages(
                                  pages: (controller
                                              .masterContentSettlementListModel
                                              .value
                                              .total! /
                                          4)
                                      .ceil(),
                                  activePage: controller
                                      .activePageMasterContentSettlementList
                                      .value,
                                  onTap: (int pageNum) async {
                                    await controller
                                        .reqMasterContentSettlementList(
                                            index, pageNum);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}

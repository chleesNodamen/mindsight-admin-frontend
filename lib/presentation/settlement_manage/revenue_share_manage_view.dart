import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/settlement_manage/revenue_share_manage_controller.dart';

class RevenueShareManageView extends GetWidget<RevenueShareManageController> {
  const RevenueShareManageView({super.key});

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
                                    name: "Revenue share".tr,
                                    searchShow: false,
                                    viewCount: false,
                                    searchText: "Search master name".tr,
                                    onSearch: controller.onSearch,
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

  Widget _buildPage() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: appTheme.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        // height: 1016,
        // width: double.infinity,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 20,
                checkboxHorizontalMargin: 0,
                dataRowMaxHeight: 80,
                border: TableBorder(
                    horizontalInside: BorderSide(color: appTheme.grayScale2)),
                columns: [
                  // DataColumn(
                  //     label: Text(
                  //   "집계Period",
                  //   style: CustomTextStyles.labelLargeGray,
                  // )),
                  DataColumn(
                      label: Text(
                    "Master name".tr,
                    style: CustomTextStyles.labelLargeGray,
                    textAlign: TextAlign.center,
                  )),
                  DataColumn(
                      label: Text("Master ID".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Previous profit margin".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text(
                    "Current profit margin".tr,
                    style: CustomTextStyles.labelLargeGray,
                    textAlign: TextAlign.center,
                  )),
                  DataColumn(
                      label: Text("Monthly View Rate".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Master detail".tr,
                          style: CustomTextStyles.labelLargeGray)),
                ],
                rows: List.generate(
                    controller.masterProfitRateListModel.value.length, (index) {
                  return DataRow(
                      selected: false,
                      onSelectChanged: (bool? value) {},
                      cells: [
                        // DataCell(Text(
                        //     "YYYY-MM-DD 00:00:00\nYYYY-MM-DD 23:59:59",
                        //     style: CustomTextStyles.labelLargeBlack)),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: InkWell(
                            child: Text(
                                controller.masterProfitRateListModel.value
                                    .name![index],
                                style: CustomTextStyles.bodyLargeBlack.copyWith(
                                    decoration: TextDecoration.underline)),
                            onTap: () {},
                          ),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.masterProfitRateListModel.value
                                  .email![index],
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              "${controller.masterProfitRateListModel.value.previousProfitRate![index]}%",
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              "${controller.masterProfitRateListModel.value.currentProfitRate![index]}%",
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child:
                              Text("-", style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomElevatedButton(
                                text: "View".tr,
                                buttonTextStyle:
                                    CustomTextStyles.bodyMediumWhiteBold,
                                buttonStyle: CustomButtonStyles.fillBlack,
                                // width: 60,
                                height: 30,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomElevatedButton(
                                text: "Change".tr,
                                buttonTextStyle:
                                    CustomTextStyles.bodyMediumWhiteBold,
                                buttonStyle: CustomButtonStyles.fillPrimary,
                                // width: 60,
                                height: 30,
                                onPressed: () =>
                                    _buildProfitRateChangeModal(index),
                              ),
                            ],
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
                        text: "Download Excel".tr,
                        buttonTextStyle: CustomTextStyles.bodyMediumSkyBlueBold,
                        buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
                        // width: 135,
                        height: 44,
                        // onPressed: controller.onStatusChangeForAll,
                      ),
                      CustomElevatedButton(
                        text: "Select aggregation".tr,
                        buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
                        buttonStyle: CustomButtonStyles.fillPrimary,
                        // width: 107,
                        height: 44,
                        margin: const EdgeInsets.only(left: 16),
                      ),
                    ],
                  ),
                  Pages(
                      pages:
                          (controller.masterProfitRateListModel.value.total! /
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

  Future<dynamic> _buildProfitRateChangeModal(int index) {
    controller.profitChangeController.clear();

    return Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.zero,
        backgroundColor: appTheme.background,
        radius: 12,
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder12,
              color: appTheme.background),
          // width: 632,
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
                        controller.masterProfitRateListModel.value.name![index],
                        style: CustomTextStyles.headlineLargeBlack.copyWith(
                          decoration: TextDecoration.underline,
                          // decorationColor: appTheme.skyBlue
                        ),
                      ),
                      Text(
                        "Change share rate.".tr,
                        style: CustomTextStyles.headlineMediumBlack,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current".tr,
                        style: CustomTextStyles.labelLargeBlack,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CustomTextFormField(
                            enabled: false,
                            width: 100,
                            hintText:
                                "${controller.masterProfitRateListModel.value.currentProfitRate![index]}",
                            contentPadding: const EdgeInsets.all(16),
                            hintStyle: CustomTextStyles.titleLargeGray,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "%",
                            style: CustomTextStyles.titleLargeGray,
                          )
                        ],
                      ),
                    ],
                  ),
                  CustomImageView(
                    width: 40,
                    height: 40,
                    imagePath: IconConstant.arrowRight,
                    color: appTheme.skyBlue,
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 40),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "After change".tr,
                        style: CustomTextStyles.labelLargeBlack,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CustomTextFormField(
                            width: 100,
                            contentPadding: const EdgeInsets.all(16),
                            textStyle: CustomTextStyles.titleLargeSkyBlue,
                            textInputType: TextInputType.number,
                            controller: controller.profitChangeController,
                            onSubmitted: (value) =>
                                controller.onProfitChange(index),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "%",
                            style: CustomTextStyles.titleLargeBlack,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    text: 'Change'.tr,
                    buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    // width: 120,
                    height: 44,
                    onPressed: () => controller.onProfitChange(index),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

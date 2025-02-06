import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/master_manage/inactive_master_manage/inactive_master_manage_controller.dart';

class InactiveMasterManageView
    extends GetWidget<InactiveMasterManageController> {
  const InactiveMasterManageView({super.key});

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
      name: "Inactive Master management".tr,
      searchShow: true,
      viewCount: false,
      searchText: "Email address, Name Search".tr,
      memberShow: true,
      memberCount: controller.masterListModel.total,
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
                      label: Text('소속'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('Email address'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('Nickname'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('Conversion date'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Approval status".tr,
                          style: CustomTextStyles.labelLargeGray)),
                ],
                rows: List.generate(controller.masterListModel.length, (index) {
                  return DataRow(
                      selected: controller.selectedMaster[index],
                      onSelectChanged: (bool? value) {
                        controller.onMasterSelectChanged(index);
                      },
                      cells: [
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.masterListModel.companyName![index],
                              style: controller.masterListModel.verified![index]
                                  ? CustomTextStyles.bodyLargeBlack
                                  : CustomTextStyles.bodyLargeGray),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: InkWell(
                            child: Text(
                                controller.masterListModel.email![index],
                                style: controller
                                        .masterListModel.verified![index]
                                    ? CustomTextStyles.bodyLargeBlack.copyWith(
                                        decoration: TextDecoration.underline)
                                    : CustomTextStyles.bodyLargeGray.copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationColor: appTheme.grayScale5)),
                            onTap: () {
                              controller.onMasterTap(
                                  controller.masterListModel.id![index]);
                            },
                          ),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.masterListModel.nickname![index],
                              style: controller.masterListModel.verified![index]
                                  ? CustomTextStyles.bodyLargeBlack
                                  : CustomTextStyles.bodyLargeGray),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.masterListModel.createdAt != null
                                  ? DateFormat('yyyy-MM-dd').format(controller
                                      .masterListModel.createdAt![index])
                                  : "",
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(StatusDropdown(
                          isEnable: Account.isAdmin,
                          isActive: controller.masterListModel.verified![index],
                          onChanged: (newState) {
                            controller.onVerifiedChanged(index);
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
                          text: 'Active'.tr,
                          buttonTextStyle:
                              CustomTextStyles.bodyMediumSkyBlueBold,
                          buttonStyle:
                              CustomButtonStyles.fillPrimaryTransparent,
                          // margin: const EdgeInsets.symmetric(
                          //     vertical: 11, horizontal: 24),
                          // width: 90,
                          height: 44,
                          onPressed: controller.onVerfiedButtonPressed,
                        ),
                      ),
                      // CustomElevatedButton(
                      //   text: 'Inactive',
                      // buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
                      //   buttonStyle: CustomButtonStyles.fillRedTransparent,
                      //   margin: const EdgeInsets.symmetric(horizontal: 16),
                      //   width: 90,
                      //   height: 44,
                      // ),
                    ],
                  ),
                  Pages(
                      pages: (controller.masterListModel.total! / 20).ceil(),
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

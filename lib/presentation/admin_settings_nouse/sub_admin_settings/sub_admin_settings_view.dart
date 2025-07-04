import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/admin_settings_nouse/sub_admin_settings/sub_admin_settings_controller.dart';

class SubAdminSettingsView extends GetWidget<SubAdminSettingsController> {
  const SubAdminSettingsView({super.key});

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
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                          child: ListView(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildTitle(),
                                  const SizedBox(height: 32),
                                  _buildRegisterButton(),
                                  const SizedBox(height: 32),
                                  _buildPage()
                                ],
                              ),
                            ],
                          ),
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

  CustomElevatedButton _buildRegisterButton() {
    return CustomElevatedButton(
      onPressed: controller.onRegister,
      text: "New registration".tr,
      height: 44,
      // width: 107,
      decoration:
          BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder12),
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Sub admin management".tr,
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }

  SingleChildScrollView _buildPage() {
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
                      label: Text('ID'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('Department'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('Manager'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('Permission'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                ],
                rows: List.generate(controller.adminListModel.length, (index) {
                  String id = controller.adminListModel.id![index];
                  return DataRow(
                      selected: controller.selectedIds[id] ?? false,
                      onSelectChanged: (bool? value) {
                        controller.updateSelected(id, value ?? false);
                      },
                      cells: [
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: InkWell(
                            onTap: () {
                              controller.onEdit(index);
                            },
                            child: Text(controller.adminListModel.email![index],
                                style:
                                    CustomTextStyles.bodyMediumBlack.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.adminListModel.department![index],
                              style: CustomTextStyles.bodyMediumBlack.copyWith(
                                fontWeight: FontWeight.w500,
                              )),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(controller.adminListModel.manager![index],
                              style: CustomTextStyles.bodyMediumBlack.copyWith(
                                fontWeight: FontWeight.w500,
                              )),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(controller.adminListModel.role![index],
                              style: CustomTextStyles.bodyMediumBlack.copyWith(
                                fontWeight: FontWeight.w500,
                              )),
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
                  text: 'Delete'.tr,
                  buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
                  buttonStyle: CustomButtonStyles.fillRedTransparent.copyWith(),
                  // width: 76,
                  height: 44,
                  onPressed: () async {
                    await controller.onDeleteSelected();
                  },
                ),
                Pages(
                    pages: (controller.adminListModel.length / 20).ceil(),
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

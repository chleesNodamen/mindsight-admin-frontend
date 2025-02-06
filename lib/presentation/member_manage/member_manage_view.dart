import 'package:intl/intl.dart';
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
                              margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildTitle(),
                                  const SizedBox(height: 32),
                                  // Row(
                                  //   children: [
                                  //     _buildRegisterButton(),
                                  //     const SizedBox(width: 16),
                                  //     _buildMassRegisterButton(),
                                  //   ],
                                  // ),
                                  // const SizedBox(height: 32),
                                  _buildCheckBox(),
                                  const SizedBox(height: 16),
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
      name: "Member list".tr,
      searchShow: true,
      viewCount: false,
      searchText: "Email address, Name Search".tr,
      memberShow: true,
      memberCount: controller.membersModel.total,
      onSearch: controller.onSearch,
    );
  }

  CustomElevatedButton _buildRegisterButton() {
    return CustomElevatedButton(
      onPressed: () {
        Get.offAllNamed(AppRoutes.memberRegister);
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
        Get.offAllNamed(AppRoutes.memberMassRegister);
      },
      text: "Mass New registration".tr,
      height: 44,
      // width: 107,
      decoration:
          BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder12),
    );
  }

  Widget _buildCheckBox() {
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
          Text('소속'.tr, style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Wrap(
                runSpacing: 18,
                children:
                    List.generate(controller.membershipValues.length, (index) {
                  return CustomCheckboxWidget(
                    isChecked: controller.membershipValues[index],
                    label: controller.membershipLabels[index],
                    onChanged: (value) =>
                        controller.onCheckMembership(index, value),
                  );
                }),
              ),
            ],
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
                  // DataColumn(
                  //   label: Checkbox(
                  //       activeColor: appTheme.skyBlue,
                  //       checkColor: Colors.white,
                  //       fillColor: MaterialStateProperty.resolveWith(
                  //         (states) {
                  //           if (!states.contains(MaterialState.selected)) {
                  //             return Colors.transparent;
                  //           }
                  //           return null;
                  //         },
                  //       ),
                  //       value: false,
                  //       onChanged: (bool? value) {}),
                  // ),
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
                  DataColumn(
                      label: Text('Edit'.tr,
                          style: CustomTextStyles.labelLargeGray)),
                ],
                rows: List.generate(controller.membersModel.length, (index) {
                  return DataRow(
                      selected: controller.selectedMembers[index],
                      onSelectChanged: (bool? value) {
                        controller.updateValue(index);
                      },
                      cells: [
                        // DataCell(
                        //   Padding(
                        //     padding: const EdgeInsets.only(right: 8.0),
                        //     child: Checkbox(
                        //       value: controller.selected.value,
                        //       onChanged: (bool? value) {
                        //         controller.updateValue();
                        //       },
                        //     ),
                        //   ),
                        // ), // Checkbox cell
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.membersModel.affiliation == null
                                  ? "-"
                                  : controller.membersModel.affiliation![index],
                              style: controller.memberState![index]
                                  ? CustomTextStyles.bodyLargeBlack
                                  : CustomTextStyles.bodyLargeGray),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: InkWell(
                            child: Text(controller.membersModel.email![index],
                                style: controller.memberState![index]
                                    ? CustomTextStyles.bodyLargeBlack.copyWith(
                                        decoration: TextDecoration.underline)
                                    : CustomTextStyles.bodyLargeGray.copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationColor: appTheme.grayScale5)),
                            onTap: () {
                              controller.onMemberTap(
                                  controller.membersModel.id![index]);
                            },
                          ),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(controller.membersModel.username![index],
                              style: controller.memberState![index]
                                  ? CustomTextStyles.bodyLargeBlack
                                  : CustomTextStyles.bodyLargeGray),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.membersModel.createdAt != null
                                  ? DateFormat('yyyy-MM-dd').format(
                                      controller.membersModel.createdAt![index])
                                  : "",
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(StatusDropdown(
                          isEnable: Account.isAdmin,
                          isActive: controller.memberState![index],
                          onChanged: (newState) {
                            controller.onStatusChange(index, newState);
                          },
                        )),
                        DataCell(CustomElevatedButton(
                            text: "Edit".tr,
                            buttonTextStyle:
                                CustomTextStyles.bodyMediumWhiteBold,
                            buttonStyle: CustomButtonStyles.fillBlack,
                            // width: 60,
                            height: 30,
                            onPressed: () => Get.offAllNamed(
                                    AppRoutes.memberEdit,
                                    arguments: {
                                      RouteArguments.id:
                                          controller.membersModel.id![index],
                                    }))),
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
                  text: 'Inactive'.tr,
                  buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
                  buttonStyle: CustomButtonStyles.fillRedTransparent,
                  // margin: const EdgeInsets.symmetric(
                  //     vertical: 11, horizontal: 24),
                  // width: 90,
                  height: 44,
                  onPressed: controller.onButtonPressed,
                ),
                Pages(
                    pages: (controller.membersModel.total! / 20).ceil(),
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

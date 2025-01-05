import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_edit/sub_admin_edit_controller.dart';

class SubAdminEditView extends GetWidget<SubAdminEditController> {
  const SubAdminEditView({super.key});

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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildTitle(),
                              const SizedBox(height: 32),
                              _buildSubMenu(),
                              const SizedBox(height: 32),
                              _buildInfo()
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

  Column _buildInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfo0(),
        const SizedBox(height: 24),
        _buildInfo1(),
        const SizedBox(height: 24),
        _buildInfo2(),
        const SizedBox(height: 24),
        _buildInfo3(),
      ],
    );
  }

  Column _buildInfo3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Contact email Address".tr,
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: " *", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        CustomTextFormField(
            controller: controller.adminEmailController,
            width: 353,
            hintText: "Input text".tr,
            hintStyle: CustomTextStyles.bodyMediumGray,
            onChange: (value) {},
            contentPadding:
                const EdgeInsets.only(left: 16, top: 17, bottom: 17),
            filled: true),
        const SizedBox(height: 44),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomElevatedButton(
              text: 'Save'.tr,
              buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
              buttonStyle: CustomButtonStyles.fillPrimary,
              // width: 90,
              height: 44,
              onPressed: controller.onSave,
            ),
            CustomElevatedButton(
              text: 'Cancel'.tr,
              buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
              buttonStyle: CustomButtonStyles.fillRedTransparent,
              margin: const EdgeInsets.only(left: 16),
              // width: 90,
              height: 44,
              onPressed: () => Get.offAllNamed(AppRoutes.subAdminDetails,
                  arguments: {RouteArguments.id: controller.id}),
            ),
          ],
        )
      ],
    );
  }

  Row _buildInfo2() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Manager".tr,
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
              TextSpan(text: " *", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.managerController,
                width: 353,
                hintText: "Input text".tr,
                hintStyle: CustomTextStyles.bodyMediumGray,
                onChange: (value) {},
                contentPadding:
                    const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                filled: true),
          ],
        ),
        const SizedBox(width: 24),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Contact number".tr,
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
            ])),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.phoneController,
                width: 353,
                hintText: "Input text".tr,
                hintStyle: CustomTextStyles.bodyMediumGray,
                onChange: (value) {},
                contentPadding:
                    const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                filled: true),
          ],
        ),
      ],
    );
  }

  Row _buildInfo1() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Permission".tr,
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
              TextSpan(text: " *", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            Container(
              width: 353,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: appTheme.grayScale3,
                ),
                color: appTheme.white,
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: controller.selectedOrder.value,
                underline: Container(),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 2, bottom: 2),
                borderRadius: BorderRadiusStyle.roundedBorder12,
                elevation: 16,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.updateSelectedOrder(newValue);
                  }
                },
                items: <String>[
                  'role'.tr,
                  'Operation'.tr,
                  'Product management'.tr,
                  'Development'.tr
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: CustomTextStyles.bodyMediumBlack,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(width: 24),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Department".tr,
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
              TextSpan(text: " *", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.departmentController,
                width: 353,
                hintText: "Input text".tr,
                hintStyle: CustomTextStyles.bodyMediumGray,
                onChange: (value) {
                  // controller.checkPasswordValid(value, false);
                },
                contentPadding:
                    const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                // focusedBorderDecoration:
                //     TextFormFieldStyleHelper.outlineSkyBlue,
                filled: true),
          ],
        ),
      ],
    );
  }

  Row _buildInfo0() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "ID".tr,
                      style: CustomTextStyles.labelLargeBlack
                          .copyWith(fontWeight: FontWeight.w600)),
                  TextSpan(text: " *", style: TextStyle(color: appTheme.red))
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 353,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  border: Border.all(color: appTheme.grayScale3),
                  color: appTheme.grayScale2),
              padding: const EdgeInsets.all(16),
              child: Text(controller.adminDetailsModel.email!,
                  style: CustomTextStyles.bodyMediumGray),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
          onTap: () => Get.offAllNamed(AppRoutes.subAdminSettings),
          child: Text("Sub admin management".tr,
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              )),
        ),
        CustomImageView(
          width: 20,
          height: 20,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          imagePath: IconConstant.arrowRight,
        ),
        InkWell(
            onTap: () => Get.offAllNamed(AppRoutes.subAdminDetails,
                arguments: {RouteArguments.id: controller.id}),
            child: Text("관리자 Details".tr,
                style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: appTheme.skyBlue,
                ))),
        CustomImageView(
          width: 20,
          height: 20,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          imagePath: IconConstant.arrowRight,
        ),
        Text("Edit admin account".tr, style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Edit admin account".tr,
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}

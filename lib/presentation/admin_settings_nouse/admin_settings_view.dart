import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/admin_settings_nouse/admin_settings_controller.dart';

class AdminSettingsView extends GetWidget<AdminSettingsController> {
  const AdminSettingsView({super.key});

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
                                  _buildInfo(),
                                  const SizedBox(height: 16),
                                  _buildChangePassword(),
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
      name: "My account detail".tr,
      searchShow: false,
      memberShow: false,
      memberCount: 0,
      searchText: '',
      viewNumber: 0,
      viewCount: false,
    );
  }

  Widget _buildInfo() {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      // height: 340,
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Admin basic info".tr, style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.adminMyDataModel.email ?? "",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Department".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.adminMyDataModel.department ?? "",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Permission'.tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.adminMyDataModel.role ?? "",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              )
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Manager'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.adminMyDataModel.manager ?? "",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact number'.tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.adminMyDataModel.phone ?? "",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email address'.tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.adminMyDataModel.adminEmail ?? "",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadiusStyle.roundedBorder12,
                color: appTheme.background),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Recent activity'.tr,
                    style: CustomTextStyles.labelLargeGray),
                const SizedBox(
                  width: 8,
                ),
                Container(
                    height: 14,
                    width: 1,
                    decoration: BoxDecoration(color: appTheme.grayScale3)),
                const SizedBox(
                  width: 8,
                ),
                Text(
                    controller.adminMyDataModel.lastActivity != null
                        ? DateFormat('yyyy-MM-dd-HH:mm:ss')
                            .format(controller.adminMyDataModel.lastActivity!)
                        : "",
                    style: CustomTextStyles.labelLargeGray),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildChangePassword() {
    return Container(
        decoration: BoxDecoration(
          color: appTheme.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        // height: 1016,
        width: double.infinity,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Change password'.tr, style: CustomTextStyles.labelLargeBlack),
            const SizedBox(height: 24),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current password'.tr,
                        style: CustomTextStyles.labelLargeBlack),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                        controller: controller.oldPasswordController,
                        width: 353,
                        hintText: "Input text".tr,
                        hintStyle: CustomTextStyles.bodyMediumGray,
                        suffix: InkWell(
                            onTap: () {
                              controller.isShowPasswordOne.value =
                                  !controller.isShowPasswordOne.value;
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(30, 16, 16, 16),
                                child: CustomImageView(
                                    imagePath:
                                        controller.isShowPasswordOne.value
                                            ? IconConstant.visibilityFalse
                                            : IconConstant.visibilityTrue,
                                    color: controller.isShowPasswordOne.value
                                        ? appTheme.grayScale5
                                        : appTheme.black,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize))),
                        suffixConstraints: const BoxConstraints(maxHeight: 56),
                        onChange: (value) {},
                        obscureText: controller.isShowPasswordOne.value,
                        contentPadding: const EdgeInsets.only(
                            left: 16, top: 17, bottom: 17),
                        filled: true),
                  ],
                ),
                const SizedBox(width: 24),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New password'.tr,
                        style: CustomTextStyles.labelLargeBlack),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                        controller: controller.newPasswordController,
                        width: 353,
                        hintText: "Input text".tr,
                        hintStyle: CustomTextStyles.bodyMediumGray,
                        suffix: InkWell(
                            onTap: () {
                              controller.isShowPasswordTwo.value =
                                  !controller.isShowPasswordTwo.value;
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(30, 16, 16, 16),
                                child: CustomImageView(
                                    imagePath:
                                        controller.isShowPasswordTwo.value
                                            ? IconConstant.visibilityFalse
                                            : IconConstant.visibilityTrue,
                                    color: appTheme.grayScale5,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize))),
                        suffixConstraints: const BoxConstraints(maxHeight: 56),
                        onChange: (value) {},
                        obscureText: controller.isShowPasswordTwo.value,
                        contentPadding: const EdgeInsets.only(
                            left: 16, top: 17, bottom: 17),
                        filled: true),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(
              text: 'Save'.tr,
              buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
              buttonStyle: CustomButtonStyles.fillPrimary,
              // width: 90,
              height: 44,
              onPressed: controller.onContinue,
            )
          ],
        ));
  }
}

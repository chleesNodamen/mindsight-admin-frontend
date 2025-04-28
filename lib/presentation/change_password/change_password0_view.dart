import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/change_password/change_password0_controller.dart';

class ChangePassword0View extends GetWidget<ChangePassword0Controller> {
  const ChangePassword0View({super.key});

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
                                  _build123(),
                                  SizedBox(height: 17.v),
                                  Text(
                                      "Enter the email address associated with the account you’re trying to access."
                                          .tr,
                                      style: CustomTextStyles.bodyMediumBlack),
                                  SizedBox(height: 33.v),
                                  BuildInput(
                                      label: "Email".tr,
                                      essential: true,
                                      textController:
                                          controller.emailController),
                                  const SizedBox(height: 32),
                                  _buildContinueNCancel()
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

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Change Password".tr,
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }

  Row _build123() {
    return Row(children: [
      Container(
          width: 40.adaptSize,
          height: 40.adaptSize,
          alignment: Alignment.center,
          decoration: AppDecoration.fillSkyBlue
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: Text("1", style: CustomTextStyles.bodyMediumWhite)),
      SizedBox(width: 8.h),
      Container(
          width: 40.adaptSize,
          height: 40.adaptSize,
          alignment: Alignment.center,
          decoration: AppDecoration.fillGrayScale1
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: Text("2", style: CustomTextStyles.bodyMediumGray)),
      SizedBox(width: 8.h),
      Container(
          width: 40.adaptSize,
          height: 40.adaptSize,
          alignment: Alignment.center,
          decoration: AppDecoration.fillGrayScale1
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: Text("3", style: CustomTextStyles.bodyMediumGray)),
    ]);
  }

  Row _buildContinueNCancel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomElevatedButton(
          text: "Continue".tr,
          buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
          buttonStyle: CustomButtonStyles.fillPrimary,
          // width: 90,
          height: 44,
          onPressed: () {
            // Get.toNamed(AppRoutes.changePassword1);
            controller.onContinue();
          },
        ),
        CustomElevatedButton(
          text: 'Cancel'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
          buttonStyle: CustomButtonStyles.fillRedTransparent,
          margin: const EdgeInsets.only(left: 16),
          // width: 90,
          height: 44,
          onPressed: () => Account.isLogined
              ? Get.offAllNamed(AppRoutes.masterManage)
              : Get.offAllNamed(AppRoutes.auth),
        ),
      ],
    );
  }
}

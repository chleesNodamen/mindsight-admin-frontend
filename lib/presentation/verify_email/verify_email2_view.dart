import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/verify_email/verify_email2_controller.dart';

class VerifyEmail2View extends GetWidget<VerifyEmail2Controller> {
  const VerifyEmail2View({super.key});

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
                                  Text("Enter a new password.".tr,
                                      style: CustomTextStyles.bodyMediumBlack),
                                  const SizedBox(height: 32),
                                  Row(
                                    children: [
                                      BuildInput(
                                          label: "Password".tr,
                                          essential: true,
                                          textController:
                                              controller.passwordController),
                                      const SizedBox(width: 24),
                                      BuildInput(
                                          label: "Password Confirm".tr,
                                          essential: true,
                                          textController: controller
                                              .passwordCofirmController),
                                    ],
                                  ),
                                  const SizedBox(height: 32),
                                  _buildBottomButton()
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
      name: "Verify Email".tr,
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }

  Row _build123() {
    return Row(children: [
      Container(
          width: 30.adaptSize,
          height: 30.adaptSize,
          alignment: Alignment.center,
          decoration: AppDecoration.fillGrayScale1
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: Text("1", style: CustomTextStyles.bodyMediumGray)),
      SizedBox(width: 8.h),
      Container(
          width: 30.adaptSize,
          height: 30.adaptSize,
          alignment: Alignment.center,
          decoration: AppDecoration.fillGrayScale1
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: Text("2", style: CustomTextStyles.bodyMediumGray)),
      SizedBox(width: 8.h),
      Container(
          width: 30.adaptSize,
          height: 30.adaptSize,
          alignment: Alignment.center,
          decoration: AppDecoration.fillSkyBlue
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: Text("3", style: CustomTextStyles.bodyMediumWhite)),
    ]);
  }

  Row _buildBottomButton() {
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

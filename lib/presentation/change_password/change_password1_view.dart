import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/change_password/change_password0_controller.dart';
import 'package:mindsight_admin_page/presentation/change_password/change_password1_controller.dart';

class ChangePassword1View extends GetWidget<ChangePassword1Controller> {
  const ChangePassword1View({super.key});

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
                                      "Enter the verification code sent to the following email address."
                                          .tr,
                                      style: CustomTextStyles.bodyMediumBlack),
                                  const SizedBox(height: 32),
                                  Container(
                                    width: 353,
                                    height: 60,
                                    alignment: Alignment.center,
                                    decoration:
                                        AppDecoration.fillGrayScale2.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder8,
                                    ),
                                    child: Text(controller.email,
                                        style: CustomTextStyles.bodyLargeBlack),
                                  ),
                                  const SizedBox(height: 32),
                                  BuildInput(
                                      label: "Code".tr,
                                      essential: true,
                                      textController:
                                          controller.codeController),
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
      name: "Change Password".tr,
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
          decoration: AppDecoration.fillSkyBlue
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: Text("2", style: CustomTextStyles.bodyMediumWhite)),
      SizedBox(width: 8.h),
      Container(
          width: 30.adaptSize,
          height: 30.adaptSize,
          alignment: Alignment.center,
          decoration: AppDecoration.fillGrayScale1
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: Text("3", style: CustomTextStyles.bodyMediumGray)),
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
          text: "Resend code".tr,
          buttonTextStyle: CustomTextStyles.bodyMediumBlack.copyWith(
            fontWeight: FontWeight.w700,
          ),
          buttonStyle: CustomButtonStyles.fillWhite,
          margin: const EdgeInsets.only(left: 16),
          height: 44,
          onPressed: () {
            controller.onResendCode();
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

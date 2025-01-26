import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/inquiry_board_manage/inquiry_board_detail/inquiry_board_detail_controller.dart';

class InquiryBoardDetailView extends GetWidget<InquiryBoardDetailController> {
  const InquiryBoardDetailView({super.key});

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
                                    name: "Inquiry Board detail".tr,
                                    searchShow: false,
                                    viewCount: false,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildSubMenu(),
                                  const SizedBox(height: 32),
                                  _buildInfo(),
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

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
          child: Text(
            "Inquiry Board list".tr,
            style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: appTheme.skyBlue,
            ),
          ),
          onTap: () => Get.offAllNamed(AppRoutes.inquiryBoardManage),
        ),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text("Inquiry Board detail".tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  Widget _buildInfo() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder12,
          color: appTheme.white),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Subject".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.inquiryBoardDetailModel.subject!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              Visibility(
                visible: Account.isMaster(
                    controller.inquiryBoardDetailModel.masterEmail!),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () => controller.onTapDelete(),
                        child: Text(
                          "Delete".tr,
                          style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: appTheme.skyBlue),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () => Get.offAllNamed(AppRoutes.inquiryBoardEdit,
                            arguments: {RouteArguments.id: controller.id}),
                        child: Text(
                          "Edit".tr,
                          style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: appTheme.skyBlue),
                        )),
                  ],
                ),
              )
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Message".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.inquiryBoardDetailModel.message!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Author".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.inquiryBoardDetailModel.masterNickname!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Date".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(
                          controller.inquiryBoardDetailModel.createdAt!),
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Text("Response".tr, style: CustomTextStyles.labelMediumGray),
          const SizedBox(
            height: 8,
          ),
          Account.isAdmin
              ? Visibility(visible: true, child: _buildResponseInput())
              : Text(
                  controller.inquiryBoardDetailModel.response ?? "Pending".tr,
                  style: CustomTextStyles.bodyMediumBlack),
        ],
      ),
    );
  }

  Widget _buildResponseInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            KeyboardListener(
              focusNode: controller.focusNode,
              onKeyEvent: (KeyEvent evt) {
                if (evt.logicalKey.keyLabel == 'Enter') {
                  if (evt is KeyDownEvent) {
                    controller.nextLine();
                  }
                }
              },
              child: CustomTextFormField(
                textInputAction: TextInputAction.newline,
                width: 730,
                textInputType: TextInputType.multiline,
                maxLines: 3,
                controller: controller.responseController,
                hintText: "Input text".tr,
                contentPadding: const EdgeInsets.all(16),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return "This field is required.".tr;
                //   }
                //   return null;
                // },
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            CustomElevatedButton(
              text: 'Save'.tr,
              buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
              buttonStyle: CustomButtonStyles.fillPrimary,
              // width: 90,
              height: 44,
              onPressed: () {
                controller.onSave();
              },
            ),
          ],
        ),
      ],
    );
  }
}

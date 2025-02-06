import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/faq_board_manage/faq_board_detail/faq_detail_controller.dart';
import 'package:mindsight_admin_page/widgets/image_actions_widget.dart';

class FAQBoardDetailView extends GetWidget<FAQBoardDetailController> {
  const FAQBoardDetailView({super.key});

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
                                    name: "FAQ detail".tr,
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
            "FAQ list".tr,
            style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: appTheme.skyBlue,
            ),
          ),
          onTap: () => Get.offAllNamed(AppRoutes.faqBoardManage),
        ),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text("FAQ detail".tr, style: CustomTextStyles.bodyMediumGray),
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
                  Text("Question".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.faqBoardDetailModel.question!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              Visibility(
                visible: Account.isAdmin,
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
                        onTap: () => Get.offAllNamed(AppRoutes.faqBoardEdit,
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
                  Text("Answer".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.faqBoardDetailModel.answer!,
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
          Text('Attached File'.tr, style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 16),
          controller.faqBoardDetailModel.attachedFile != null
              ? ImageActionsWidget(
                  imageUrl: controller.faqBoardDetailModel.attachedFile!,
                )
              : const SizedBox.shrink(),
          // Divider(
          //   height: 49,
          //   thickness: 1,
          //   color: appTheme.grayScale2,
          // ),
          // Row(
          //   children: [
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Text("Date".tr, style: CustomTextStyles.labelMediumGray),
          //         const SizedBox(
          //           height: 16,
          //         ),
          //         Text(
          //             DateFormat('yyyy-MM-dd HH:mm')
          //                 .format(controller.faqBoardDetailModel.createdAt!),
          //             style: CustomTextStyles.bodyMediumBlack),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

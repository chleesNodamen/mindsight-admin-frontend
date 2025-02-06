import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/free_board_manage/free_board_edit/free_board_edit_controller.dart';
import 'package:mindsight_admin_page/presentation/inquiry_board_manage/inquiry_board_edit/inquiry_board_edit_controller.dart';

class InquiryBoardEditView extends GetWidget<InquiryBoardEditController> {
  const InquiryBoardEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildTitle(),
                                    const SizedBox(height: 16),
                                    _buildSubMenu(),
                                    const SizedBox(height: 32),
                                    _buildBody(),
                                    const SizedBox(height: 32),
                                    _buildSaveNCancel(formKey)
                                  ],
                                ),
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

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BuildInput(
              label: "Title".tr,
              essential: true,
              textController: controller.subjectController,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildContent(),
        const SizedBox(height: 24),
        // 첨부파일
        PickFileFormField(
          labelText: "Attached File".tr,
          essential: false,
          initialUrl: controller.inquiryBoardDetailModel.attachedFile,
          hintText: ".jpg",
          fileExtension: [FileExtension.jpg.keywordName],
          onFilePicked: (pickedFile) {
            controller.onPickFile(pickedFile);
          },
        )
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Content".tr,
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: " *", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(
          height: 8,
        ),
        KeyboardListener(
          focusNode: controller.focusNode,
          onKeyEvent: (KeyEvent evt) {
            if (evt.logicalKey.keyLabel == 'Enter') {
              if (evt is KeyDownEvent) {
                controller.nextList();
              }
            }
          },
          child: CustomTextFormField(
            textInputAction: TextInputAction.newline,
            width: 730,
            textInputType: TextInputType.multiline,
            maxLines: 6,
            controller: controller.messageController,
            hintText: "Input text".tr,
            contentPadding: const EdgeInsets.all(16),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required.".tr;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Row _buildSaveNCancel(GlobalKey<FormState> formKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomElevatedButton(
          text: 'Save'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
          buttonStyle: CustomButtonStyles.fillPrimary,
          // width: 90,
          height: 44,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              controller.onSave();
            }
          },
        ),
        CustomElevatedButton(
          text: 'Cancel'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
          buttonStyle: CustomButtonStyles.fillRedTransparent,
          margin: const EdgeInsets.only(left: 16),
          // width: 90,
          height: 44,
          onPressed: () => Get.offAllNamed(AppRoutes.inquiryBoardDetail,
              arguments: {RouteArguments.id: controller.id}),
        ),
      ],
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
            onTap: () {
              Get.offAllNamed(AppRoutes.inquiryBoardManage);
            }),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        InkWell(
          child: Text(
            "Inquiry Board detail".tr,
            style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: appTheme.skyBlue,
            ),
          ),
          onTap: () => Get.offAllNamed(AppRoutes.inquiryBoardDetail,
              arguments: {RouteArguments.id: controller.id}),
        ),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text("Inquiry Board Edit".tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Inquiry Board Edit".tr,
      searchShow: false,
      viewCount: false,
    );
  }
}

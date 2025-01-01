import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_mass_register_controller.dart';

class CompanyMassRegisterView extends GetWidget<CompanyMassRegisterController> {
  const CompanyMassRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildTitle(),
                                    const SizedBox(height: 16),
                                    _buildSubMenu(),
                                    const SizedBox(height: 24),
                                    _buildFile(),
                                    const SizedBox(height: 32),
                                    _buildSaveNCancel(_formKey)
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

  Widget _buildFile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "등록 파일".tr,
                      style: CustomTextStyles.labelLargeBlack),
                  TextSpan(text: " *", style: TextStyle(color: appTheme.red))
                ])),
                const SizedBox(height: 8),
                Container(
                  width: 353,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder12,
                      border: Border.all(color: appTheme.grayScale3),
                      color: appTheme.white),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 280,
                        child: Text(
                          controller.fileName == "".obs
                              ? "최대 10메가 (엑셀 파일)".tr
                              : controller.fileName.value,
                          style: controller.fileName == "".obs
                              ? CustomTextStyles.bodyMediumGray
                              : CustomTextStyles.bodyMediumBlack,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CustomImageView(
                        imagePath: IconConstant.upload,
                        onTap: () {
                          // controller.pickFile("thumbnail");
                        },
                      )
                    ],
                  ),
                ),
                controller.enableFileError.value
                    ? Column(
                        children: [
                          const SizedBox(height: 8),
                          Text('필수 입력 항목입니다.'.tr,
                              style: CustomTextStyles.labelMediumRed),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                _buildFormatFileDownload(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Row _buildSaveNCancel(GlobalKey<FormState> formKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomElevatedButton(
          text: '저장'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
          buttonStyle: CustomButtonStyles.fillPrimary,
          width: 90,
          height: 44,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              controller.onSave();
            }
          },
        ),
        CustomElevatedButton(
          text: '취소'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
          buttonStyle: CustomButtonStyles.fillRedTransparent,
          margin: const EdgeInsets.only(left: 16),
          width: 90,
          height: 44,
          onPressed: () => Get.offAllNamed(AppRoutes.companyManage),
        ),
      ],
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
            child: Text(
              "회사 목록".tr,
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () {
              if (Account.isAdmin) {
                if (SideMenuController.to.isActiveSubItem("회사 목록".tr)) {
                  Get.offAllNamed(AppRoutes.companyManage);
                } else {
                  Get.offAllNamed(AppRoutes.inactiveCompanyManage);
                }
              } else {
                Get.offAllNamed(AppRoutes.companyManage);
              }
            }),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text("대량 사전 신규 등록".tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  Row _buildFormatFileDownload() {
    return Row(
      children: [
        Text(
          '서식 엑셀 파일 다운로드'.tr,
          style: CustomTextStyles.labelLargeGray,
          overflow: TextOverflow.ellipsis,
        ),
        CustomImageView(
          imagePath: IconConstant.download,
          onTap: () {},
        )
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "대량 사전 신규 등록".tr,
      searchShow: false,
      viewCount: false,
    );
  }
}

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_edit_controller.dart';

class CompanyEditView extends GetWidget<CompanyEditController> {
  const CompanyEditView({super.key});

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
                                    _buildCompanyInfo(),
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

  Widget _buildCompanyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("회사 정보", style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildInput("회사 이름", true, controller.companyNameController),
            const SizedBox(width: 24),
            _buildInput("대표자", true, controller.representativeController),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildInput("사업자 번호", true, controller.businessNumberController),
            const SizedBox(width: 24),
            _buildInput("전화", true, controller.phoneController),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildInput("담당자 명", true, controller.contactNameController),
            const SizedBox(width: 24),
            _buildInput("담당자 이메일", true, controller.contactEmailController),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildInput("담당자 전화번호", true, controller.contactPhoneController),
            const SizedBox(width: 24),
            _buildInput("주소", true, controller.addressController),
          ],
        ),
      ],
    );
  }

  Column _buildInput(
      String text, bool essential, TextEditingController textController,
      {String? hint}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "$text ",
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(
              text: essential ? "*" : "", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        CustomTextFormField(
            controller: textController,
            width: 353,
            hintText: hint ?? "Input text",
            hintStyle: CustomTextStyles.bodyMediumGray,
            validator: (value) {
              if (value == null) {
                return "필수 입력 항목입니다.".tr;
              }
              return null;
            },
            contentPadding:
                const EdgeInsets.only(left: 16, top: 17, bottom: 17),
            filled: true),
      ],
    );
  }

  Row _buildSaveNCancel(GlobalKey<FormState> formKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomElevatedButton(
          text: '저장',
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
          text: '취소',
          buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
          buttonStyle: CustomButtonStyles.fillRedTransparent,
          margin: const EdgeInsets.only(left: 16),
          width: 90,
          height: 44,
          onPressed: () => controller.goCompanyDatail(),
        ),
      ],
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
            child: Text(
              "회사 목록",
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () {
              if (SideMenuController.to.isActiveSubItem("회사 목록")) {
                Get.offAllNamed(AppRoutes.companyManage);
              } else {
                Get.offAllNamed(AppRoutes.inactiveCompanyManage);
              }
            }),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        InkWell(
          child: Text(
            "회사 상세",
            style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: appTheme.skyBlue,
            ),
          ),
          onTap: () => controller.goCompanyDatail(),
        ),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text("회사 정보 수정", style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "회사 정보 수정",
      searchShow: false,
      viewCount: false,
    );
  }
}

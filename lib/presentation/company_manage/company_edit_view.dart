import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/company_manage/company_edit_controller.dart';

class CompanyEditView extends GetWidget<CompanyEditController> {
  const CompanyEditView({super.key});

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
                                    const SizedBox(height: 32),
                                    _buildCompanyInfo(),
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

  Widget _buildCompanyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Company info".tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Row(
          children: [
            BuildInput(
              label: "Company name".tr,
              essential: true,
              textController: controller.companyNameController,
            ),
            const SizedBox(width: 24),
            BuildInput(
              label: "Representative".tr,
              essential: true,
              textController: controller.representativeController,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            BuildInput(
              label: "Business number".tr,
              essential: true,
              textController: controller.businessNumberController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required.".tr;
                }
                // final regex = RegExp(r"^\d{10,}$");
                // if (!regex.hasMatch(value)) {
                //   return "Business number는 최소 10자리의 숫자여야 합니다.";
                // }
                return null;
              },
            ),
            const SizedBox(width: 24),
            BuildInput(
              label: "Phone".tr,
              essential: true,
              textController: controller.phoneController,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            BuildInput(
              label: "Contact name".tr,
              essential: true,
              textController: controller.contactNameController,
            ),
            const SizedBox(width: 24),
            BuildInput(
              label: "Contact email".tr,
              essential: true,
              textController: controller.contactEmailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required.".tr;
                }
                final regex = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                if (!regex.hasMatch(value)) {
                  return "Enter a valid email.".tr;
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            BuildInput(
              label: "Contact phone".tr,
              essential: true,
              textController: controller.contactPhoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(width: 24),
            BuildInput(
              label: "Address".tr,
              essential: true,
              textController: controller.addressController,
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
          onPressed: () => controller.onCompanyDatail(),
        ),
      ],
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
            child: Text(
              "Company list".tr,
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () {
              if (Account.isAdmin) {
                if (SideMenuController.to.isActiveSubItem("Company list".tr)) {
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
        InkWell(
          child: Text(
            "Company detail".tr,
            style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: appTheme.skyBlue,
            ),
          ),
          onTap: () => controller.onCompanyDatail(),
        ),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text("Company info Edit".tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Company info Edit".tr,
      searchShow: false,
      viewCount: false,
    );
  }
}

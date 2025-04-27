import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/gender.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_register/member_register_controller.dart';

class MemberRegisterView extends GetWidget<MemberRegisterController> {
  const MemberRegisterView({super.key});

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
                                    const SizedBox(height: 24),
                                    _buildAffiliation(),
                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        BuildInput(
                                          label: "부서".tr,
                                          essential: true,
                                          textController:
                                              controller.departmentController,
                                        ),
                                        const SizedBox(width: 24),
                                        BuildInput(
                                          label: "직책 또는 직급".tr,
                                          essential: true,
                                          textController:
                                              controller.positionController,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        BuildInput(
                                          label: "Name (First name)".tr,
                                          essential: true,
                                          textController:
                                              controller.firstNameController,
                                        ),
                                        const SizedBox(width: 24),
                                        BuildInput(
                                          label: "성 (Last name)".tr,
                                          essential: true,
                                          textController:
                                              controller.lastNameController,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        _buildGender(),
                                        const SizedBox(width: 24),
                                        BuildInput(
                                          label: "태어난 Year".tr,
                                          essential: true,
                                          textController:
                                              controller.yearController,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This field is required."
                                                  .tr;
                                            }
                                            // final RegExp regex =
                                            //     RegExp(r'^\d{4}$');
                                            if (!RegExp(r'^\d{4}$')
                                                .hasMatch(value)) {
                                              return "Please enter a 4-digit number."
                                                  .tr;
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    BuildInput(
                                        label: "Email address".tr,
                                        essential: true,
                                        textController:
                                            controller.emailController,
                                        keyboardType:
                                            TextInputType.emailAddress),
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
          onPressed: () => Get.offAllNamed(AppRoutes.memberManage),
        ),
      ],
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
            child: Text(
              "Member list".tr,
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () {
              Get.offAllNamed(AppRoutes.memberManage);
            }),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text("Pre registration".tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Pre registration".tr,
      searchShow: false,
      viewCount: false,
    );
  }

  Widget _buildAffiliation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "소속".tr, style: CustomTextStyles.labelLargeBlack),
              TextSpan(text: " *", style: TextStyle(color: appTheme.red))
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 353,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: appTheme.grayScale3,
            ),
            color: appTheme.white,
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: DropdownButton<String>(
            hint: Text('Select Option'.tr,
                style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value: controller.affiliation.value == "-" ||
                    controller.affiliation.value == ""
                ? null
                : controller.affiliation.value,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.affiliation.value = newValue;
              }
            },
            items: controller.affiliationModel.affiliation!
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: CustomTextStyles.bodyMediumBlack,
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildGender() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "성별".tr, style: CustomTextStyles.labelLargeBlack),
              TextSpan(text: " *", style: TextStyle(color: appTheme.red))
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 353,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: appTheme.grayScale3,
            ),
            color: appTheme.white,
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: DropdownButton<Gender>(
            hint: Text('Select Option'.tr,
                style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value: controller.gender.value,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (Gender? newValue) {
              if (newValue != null) {
                controller.gender.value = newValue;
              }
            },
            items: <Gender>[Gender.male, Gender.female, Gender.nonbinary]
                .map<DropdownMenuItem<Gender>>((Gender value) {
              return DropdownMenuItem<Gender>(
                value: value,
                child: Text(
                  value.displayName.tr,
                  style: CustomTextStyles.bodyMediumBlack,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

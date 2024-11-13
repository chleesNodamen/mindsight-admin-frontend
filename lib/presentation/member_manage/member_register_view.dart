import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/gender.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_register_controller.dart';

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
                      Obx(
                        () => Expanded(
                          child: ListView(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(0, 48, 40, 48),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      _buildTitle(),
                                      const SizedBox(height: 16),
                                      _buildSubMenu(),
                                      const SizedBox(height: 24),
                                      _buildCompany(),
                                      const SizedBox(height: 24),
                                      _buildPart(),
                                      const SizedBox(height: 24),
                                      _buildName(),
                                      const SizedBox(height: 24),
                                      _buildGenderNYear(),
                                      const SizedBox(height: 24),
                                      _buildEmail(),
                                      const SizedBox(height: 32),
                                      _buildSaveNCancel(formKey)
                                    ],
                                  ),
                                ),
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
              "회원 목록",
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
        Text("사전 신규 등록", style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "사전 신규 등록",
      searchShow: false,
      viewCount: false,
    );
  }

  Widget _buildCompany() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('소속', style: CustomTextStyles.labelLargeBlack),
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
            hint: Text('Select Option', style: CustomTextStyles.bodyMediumGray),
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

  Row _buildGenderNYear() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("성별 ", style: CustomTextStyles.labelLargeBlack),
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
                hint: Text('Select Option',
                    style: CustomTextStyles.bodyMediumGray),
                isExpanded: true,
                value: controller.gender.value,
                underline: Container(),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 2, bottom: 2),
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
                      value.displayName,
                      style: CustomTextStyles.bodyMediumBlack,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(width: 24),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("태어난 연도 ", style: CustomTextStyles.labelLargeBlack),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.yearController,
                width: 353,
                validator: (value) {
                  final RegExp regex = RegExp(r'^\d{4}$');
                  if (value != null &&
                      value.isNotEmpty &&
                      !regex.hasMatch(value)) {
                    return 'Please enter a 4-digit integer';
                  }
                  return null;
                },
                contentPadding:
                    const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                filled: true),
          ],
        ),
      ],
    );
  }

  Row _buildPart() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("부서 ", style: CustomTextStyles.labelLargeBlack),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.departmentController,
                width: 353,
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length > 25) {
                    return "Input is too long".tr;
                  }
                  return null;
                },
                contentPadding:
                    const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                // focusedBorderDecoration:
                //     TextFormFieldStyleHelper.outlineSkyBlue,
                filled: true),
          ],
        ),
        const SizedBox(width: 24),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("직책 또는 직급", style: CustomTextStyles.labelLargeBlack),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.positionController,
                width: 353,
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length > 25) {
                    return "Input is too long".tr;
                  }
                  return null;
                },
                contentPadding:
                    const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                // focusedBorderDecoration:
                //     TextFormFieldStyleHelper.outlineSkyBlue,
                filled: true),
          ],
        ),
      ],
    );
  }

  Row _buildName() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("이름 (First name) ", style: CustomTextStyles.labelLargeBlack),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.firstNameController,
                width: 353,
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length > 25) {
                    return "Input is too long".tr;
                  }
                  return null;
                },
                contentPadding:
                    const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                filled: true),
          ],
        ),
        const SizedBox(width: 24),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("성 (Last name)", style: CustomTextStyles.labelLargeBlack),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.lastNameController,
                width: 353,
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length > 25) {
                    return "Input is too long".tr;
                  }
                  return null;
                },
                contentPadding:
                    const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                filled: true),
          ],
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "이메일 주소 ", style: CustomTextStyles.labelLargeBlack),
                  TextSpan(text: "*", style: TextStyle(color: appTheme.red))
                ],
              ),
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.emailController,
                width: 353,
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length > 50) {
                    return "Input is too long".tr;
                  }
                  return null;
                },
                contentPadding:
                    const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                filled: true),
            // Container(
            //   width: 353,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadiusStyle.roundedBorder12,
            //       border: Border.all(color: appTheme.grayScale3),
            //       color: appTheme.grayScale2),
            //   padding: const EdgeInsets.all(16),
            //   child: Text(controller.membersDataModel.email ?? "-",
            //       style: CustomTextStyles.bodyMediumGray),
            // ),
          ],
        ),
      ],
    );
  }
}

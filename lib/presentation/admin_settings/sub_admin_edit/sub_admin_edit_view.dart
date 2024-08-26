import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/sub_admin_edit/sub_admin_edit_controller.dart';

class SubAdminEditView extends GetWidget<SubAdminEditController> {
  const SubAdminEditView({super.key});

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
                          margin: const EdgeInsets.all(48.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildTopBar(),
                              const SizedBox(height: 32),
                              buildSubHeader(),
                              const SizedBox(height: 32),
                              buildTextFields()
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

  Column buildTextFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFirstRow(),
        const SizedBox(height: 24),
        buildSecondRow(),
        const SizedBox(height: 24),
        buildThirdRow(),
        const SizedBox(height: 24),
        buildLastRow(),
      ],
    );
  }

  Column buildLastRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "담당자 이메일 주소 ",
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: "*", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        CustomTextFormField(
            controller: controller.adminEmailController,
            width: 353,
            hintText: "Input text",
            hintStyle: CustomTextStyles.bodyMediumGray,
            onChange: (value) {
              // controller.checkPasswordValid(value, false);
            },
            // validator: (value) {
            //   // if (value == null ||
            //   //     !controller.checkPasswordValid(value, true) ||
            //   //     !controller.authPasswordResetModel.isSuccess) {
            //   //   return "Code is invalid or has expired".tr;
            //   // }
            //   // return null;
            // },
            contentPadding:
                const EdgeInsets.only(left: 16, top: 17, bottom: 17),
            // focusedBorderDecoration:
            //     TextFormFieldStyleHelper.outlineSkyBlue,
            filled: true),
        const SizedBox(height: 44),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomElevatedButton(
              text: '저장',
              buttonTextStyle: CustomTextStyles.bodyMediumWhite.copyWith(
                fontWeight: FontWeight.w700,
              ),
              buttonStyle: CustomButtonStyles.fillPrimary,
              width: 90,
              height: 44,
              onPressed: controller.saveChanges,
            ),
            CustomElevatedButton(
              text: '취소',
              buttonTextStyle: CustomTextStyles.bodyMediumRed.copyWith(
                fontWeight: FontWeight.w700,
              ),
              buttonStyle: CustomButtonStyles.fillRedTransparent,
              margin: const EdgeInsets.only(left: 16),
              width: 90,
              height: 44,
              onPressed: () => Get.back(),
            ),
          ],
        )
      ],
    );
  }

  Row buildThirdRow() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "담당자 ",
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
              TextSpan(text: "*", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.managerController,
                width: 353,
                hintText: "Input text",
                hintStyle: CustomTextStyles.bodyMediumGray,
                onChange: (value) {
                  // controller.checkPasswordValid(value, false);
                },
                // validator: (value) {
                //   // if (value == null ||
                //   //     !controller.checkPasswordValid(value, true) ||
                //   //     !controller.authPasswordResetModel.isSuccess) {
                //   //   return "Code is invalid or has expired".tr;
                //   // }
                //   // return null;
                // },
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
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "연락처 ",
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
            ])),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.phoneController,
                width: 353,
                hintText: "Input text",
                hintStyle: CustomTextStyles.bodyMediumGray,
                onChange: (value) {
                  // controller.checkPasswordValid(value, false);
                },
                // validator: (value) {
                //   // if (value == null ||
                //   //     !controller.checkPasswordValid(value, true) ||
                //   //     !controller.authPasswordResetModel.isSuccess) {
                //   //   return "Code is invalid or has expired".tr;
                //   // }
                //   // return null;
                // },
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

  Row buildSecondRow() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "권한 ",
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
              TextSpan(text: "*", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            Container(
              width: 353,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: appTheme.grayScale3,
                ),
                color: appTheme.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: controller.selectedOrder.value,
                underline: Container(),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 2, bottom: 2),
                borderRadius: BorderRadius.circular(12),
                // icon: const Icon(Icons.),
                elevation: 16,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.updateSelectedOrder(newValue);
                  }
                },
                items: <String>['role', '운영', '제품 관리', '개발']
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
            ),
          ],
        ),
        const SizedBox(width: 24),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "담당 부서 ",
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
              TextSpan(text: "*", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.departmentController,
                width: 353,
                hintText: "Input text",
                hintStyle: CustomTextStyles.bodyMediumGray,
                onChange: (value) {
                  // controller.checkPasswordValid(value, false);
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

  Row buildFirstRow() {
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
                      text: "아이디 ",
                      style: CustomTextStyles.labelLargeBlack
                          .copyWith(fontWeight: FontWeight.w600)),
                  TextSpan(text: "*", style: TextStyle(color: appTheme.red))
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 353,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: appTheme.grayScale3),
                  color: appTheme.grayScale2),
              padding: const EdgeInsets.all(16),
              child: Text(controller.adminDetailsModel.email!,
                  style: CustomTextStyles.bodyMediumGray),
            ),
          ],
        ),
      ],
    );
  }

  Row buildSubHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Text("서브 관리자 관리",
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              )),
        ),
        CustomImageView(
          width: 20,
          height: 20,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          imagePath: IconConstant.arrowRight,
        ),
        Text("관리자 계정 수정", style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch buildTopBar() {
    return TobBarSearch(
      name: "관리자 계정 수정",
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}

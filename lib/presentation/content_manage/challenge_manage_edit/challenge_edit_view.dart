import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_edit/challenge_edit_controller.dart';

class ChallengeEditView extends GetWidget<ChallengeEditController> {
  const ChallengeEditView({super.key});

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
                          child: SingleChildScrollView(
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
        Text("기본 정보", style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        buildFirstRow(),
        const SizedBox(height: 24),
        buildSecondRow(),
        const SizedBox(height: 24),
        buildThirdRow(),
        const SizedBox(height: 24),
        buildForthRow(),
        const SizedBox(height: 24),
        buildFifthRow(),
        const SizedBox(height: 24),
        buildLastRow(),
      ],
    );
  }

  Column buildForthRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Day 세션 등록", style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8.0, // Horizontal spacing
          runSpacing: 8.0, // Vertical spacing
          children: _buildNumberWidgets(),
        )
      ],
    );
  }

  List<Widget> _buildNumberWidgets() {
    List<Widget> widgets = [];
    for (int i = 0; i < controller.numbers.length; i++) {
      if (i > 0 && i % 14 == 0) {
        widgets.add(SizedBox(width: double.infinity)); // Line break
      }
      widgets.add(
        InkWell(
          onTap: () {
            controller.setActiveNumber(controller.numbers[i]);
          },
          child: Container(
            width: 33,
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
              color: controller.activeNumber.value == controller.numbers[i]
                  ? appTheme.skyBlue
                  : appTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Text(
              controller.numbers[i].toString(),
              style: controller.activeNumber.value == controller.numbers[i]
                  ? CustomTextStyles.labelMediumWhite
                  : CustomTextStyles.labelMediumBlack,
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  Row buildFifthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(text: "제목 ", style: CustomTextStyles.labelLargeBlack),
              TextSpan(text: "*", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            CustomTextFormField(
                // controller: controller.passwordController,
                width: 353,
                hintText: "Input text",
                hintStyle: CustomTextStyles.bodyMediumGray,
                onChange: (value) {
                  // controller.checkPasswordValid(value, false);
                },
                validator: (value) {
                  // if (value == null ||
                  //     !controller.checkPasswordValid(value, true) ||
                  //     !controller.authPasswordResetModel.isSuccess) {
                  //   return "Code is invalid or has expired".tr;
                  // }
                  // return null;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "콘텐츠 등록 ", style: CustomTextStyles.labelLargeBlack),
              TextSpan(text: "*", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            Container(
              width: 353,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: appTheme.grayScale3),
                  color: appTheme.grayScale2),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sunrise 10-Minute Morning Yoga A',
                      style: CustomTextStyles.bodyMediumGray),
                  CustomImageView(
                    imagePath: IconConstant.search,
                  )
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sunrise 10-Minute Morning Yoga B',
                      style: CustomTextStyles.bodyMediumGray),
                  CustomImageView(
                    imagePath: IconConstant.search,
                  )
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sunrise 10-Minute Morning Yoga C',
                      style: CustomTextStyles.bodyMediumGray),
                  CustomImageView(
                    imagePath: IconConstant.search,
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Row buildLastRow() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("파일", style: CustomTextStyles.bodyMediumBlack),
            const SizedBox(height: 24),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "썸네일 파일 ", style: CustomTextStyles.labelLargeBlack),
              TextSpan(text: "*", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            Container(
              width: 353,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: appTheme.grayScale3),
                  color: appTheme.white),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('https://nodamen.akamaized.net/Mi...',
                      style: CustomTextStyles.bodyMediumBlack),
                  CustomImageView(
                    imagePath: IconConstant.upload,
                  )
                ],
              ),
            ),
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
                  // onPressed: controller.saveChanges,
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
        ),
      ],
    );
  }

  Column buildThirdRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(text: "소개 ", style: CustomTextStyles.labelLargeBlack),
          TextSpan(text: "*", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        CustomTextFormField(
            // controller: controller.passwordController,
            maxLines: 5,
            width: 730,
            hintText: "Input text",
            hintStyle: CustomTextStyles.bodyMediumGray,
            onChange: (value) {
              // controller.checkPasswordValid(value, false);
            },
            validator: (value) {
              // if (value == null ||
              //     !controller.checkPasswordValid(value, true) ||
              //     !controller.authPasswordResetModel.isSuccess) {
              //   return "Code is invalid or has expired".tr;
              // }
              // return null;
            },
            contentPadding:
                const EdgeInsets.only(left: 16, top: 17, bottom: 17),
            // focusedBorderDecoration:
            //     TextFormFieldStyleHelper.outlineSkyBlue,
            filled: true),
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
              TextSpan(text: "목적 ", style: CustomTextStyles.labelLargeBlack),
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
                // value: controller.selectedOrder.value,
                underline: Container(),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 2, bottom: 2),
                borderRadius: BorderRadius.circular(12),
                // icon: const Icon(Icons.),
                elevation: 16,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    // controller.updateSelectedOrder(newValue);
                    // controller.updateStyle();
                  }
                },
                items: <String>['Select Option', '운영', '제품 관리', '개발']
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
              TextSpan(text: "기간 ", style: CustomTextStyles.labelLargeBlack),
              TextSpan(text: "*", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            Container(
              width: 353,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: appTheme.grayScale3),
                  color: appTheme.grayScale2),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('30일', style: CustomTextStyles.bodyMediumGray),
                  CustomImageView(
                    imagePath: IconConstant.more,
                  )
                ],
              ),
            ),
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
                      text: "제목 ", style: CustomTextStyles.labelLargeBlack),
                  TextSpan(text: "*", style: TextStyle(color: appTheme.red))
                ],
              ),
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
                // controller: controller.passwordController,
                width: 353,
                hintText: "30-Day Challenge to Strengthen Your",
                hintStyle: CustomTextStyles.bodyMediumGray,
                onChange: (value) {
                  // controller.checkPasswordValid(value, false);
                },
                validator: (value) {
                  // if (value == null ||
                  //     !controller.checkPasswordValid(value, true) ||
                  //     !controller.authPasswordResetModel.isSuccess) {
                  //   return "Code is invalid or has expired".tr;
                  // }
                  // return null;
                },
                contentPadding:
                    const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                // focusedBorderDecoration:
                //     TextFormFieldStyleHelper.outlineSkyBlue,
                filled: true),
            // Container(
            //   width: 353,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       border: Border.all(color: appTheme.grayScale3),
            //       color: appTheme.grayScale2),
            //   padding: const EdgeInsets.all(16),
            //   child: Text('30-Day Challenge to Strengthen Your',
            //       style: CustomTextStyles.bodyMediumGray),
            // ),
          ],
        ),
      ],
    );
  }

  Row buildSubHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: controller.goToChallenge,
          child: Text("Challenge 관리",
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
        GestureDetector(
          onTap: () => Get.back(),
          child: Text("Challenge 상세",
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
        Text("Challenge 수정", style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch buildTopBar() {
    return TobBarSearch(
      name: "Challenge 수정",
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}

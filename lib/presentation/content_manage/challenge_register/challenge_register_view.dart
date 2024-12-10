import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/file_extension.dart';
import 'package:mindsight_admin_page/constants/enum/goal.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_register/challenge_register_controller.dart';
import 'package:mindsight_admin_page/widgets/pick_file.dart';
import 'package:mindsight_admin_page/widgets/select_content_widget.dart';

class ChallengeRegisterView extends GetWidget<ChallengeRegisterController> {
  const ChallengeRegisterView({super.key});

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
                          margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _buildTitle(),
                                const SizedBox(height: 32),
                                _buildSubMenu(),
                                const SizedBox(height: 32),
                                _buildBasicInfo(),
                                const SizedBox(height: 32),
                                _buildDaySessionInfo(),
                                const SizedBox(height: 32),
                                _buildFileInfo(),
                                const SizedBox(height: 32),
                                _buildSaveNCancel(),
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

  Column _buildBasicInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("기본 정보", style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        _buildInput("제목", true, controller.nameController),
        const SizedBox(height: 24),
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "목적 ", style: CustomTextStyles.labelLargeBlack),
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
                    borderRadius: BorderRadiusStyle.roundedBorder12,
                  ),
                  child: DropdownButton<Goal>(
                    isExpanded: true,
                    value: controller.selectedGoal.value,
                    underline: Container(),
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 2, bottom: 2),
                    borderRadius: BorderRadiusStyle.roundedBorder12,
                    // icon: const Icon(Icons.),
                    elevation: 16,
                    onChanged: (Goal? newValue) {
                      if (newValue != null) {
                        controller.selectedGoal.value = newValue;
                      }
                    },
                    items: <Goal>[
                      Goal.improveHealth,
                      Goal.relaxingStretching,
                      Goal.welnessAtWork,
                      Goal.regulateEmotions,
                      Goal.fallAsleepEasily
                    ].map<DropdownMenuItem<Goal>>((Goal value) {
                      return DropdownMenuItem<Goal>(
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
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "기간 ", style: CustomTextStyles.labelLargeBlack),
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
                    borderRadius: BorderRadiusStyle.roundedBorder12,
                  ),
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: controller.selectedPeriod.value,
                    underline: Container(),
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 2, bottom: 2),
                    borderRadius: BorderRadiusStyle.roundedBorder12,
                    // icon: const Icon(Icons.),
                    elevation: 16,
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        controller.selectedPeriod.value = newValue;
                      }
                    },
                    items: <int>[7, 14, 21, 30]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          value.toString(),
                          style: CustomTextStyles.bodyMediumBlack,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        RichText(
            text: TextSpan(children: [
          TextSpan(text: "소개 ", style: CustomTextStyles.labelLargeBlack),
          TextSpan(text: "*", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        CustomTextFormField(
            controller: controller.introController,
            maxLines: 5,
            width: 730,
            contentPadding:
                const EdgeInsets.only(left: 16, top: 17, bottom: 17),
            filled: true)
      ],
    );
  }

  Column _buildDaySessionInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Day 세션 등록", style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8.0, // Horizontal spacing
          runSpacing: 8.0, // Vertical spacing
          children: _buildDay(),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInput("제목", true, controller.dayNameController),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "콘텐츠 ", style: CustomTextStyles.labelLargeBlack),
                  TextSpan(text: "*", style: TextStyle(color: appTheme.red))
                ])),
                const SizedBox(height: 8),
                SelectContentWidget(
                    category: ContentCategory.body,
                    initialName: controller.seletedDayContentName0.value,
                    onSelected: controller.onSelectBody),
                const SizedBox(height: 8),
                SelectContentWidget(
                    category: ContentCategory.breath,
                    initialName: controller.seletedDayContentName1.value,
                    onSelected: controller.onSelectBreath),
              ],
            ),
          ],
        )
      ],
    );
  }

  List<Widget> _buildDay() {
    List<Widget> widgets = [];
    for (int i = 0; i < controller.selectedPeriod.value; i++) {
      if (i > 0 && i % 14 == 0) {
        widgets.add(const SizedBox(
          width: double.infinity,
        ));
      }

      int day = i + 1;

      widgets.add(
        InkWell(
          onTap: () => controller.updateSelectedDay(day),
          child: Container(
            width: 33,
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
              color: controller.selectedDay.value == day
                  ? appTheme.skyBlue
                  : appTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadiusStyle.roundedBorder6,
            ),
            alignment: Alignment.center,
            child: Text(
              day.toString(),
              style: controller.selectedDay.value == day
                  ? CustomTextStyles.labelMediumWhite
                  : CustomTextStyles.labelMediumBlack,
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  Column _buildFileInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("파일", style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        PickFile(
          labelText: "썸네일 파일",
          initialUrl: controller.thumbnailFile.value?.name,
          hintText: "300 x 300 최대 10메가 (.jpg)",
          fileExtension: FileExtension.jpg.keywordName,
          onFilePicked: (pickedFile) {
            controller.onPickThumbnail(pickedFile);
          },
        ),
      ],
    );
  }

  Row _buildSaveNCancel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomElevatedButton(
          text: '승인 요청',
          buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
          buttonStyle: CustomButtonStyles.fillPrimary,
          width: 90,
          height: 44,
          onPressed: () {
            controller.onSave();
          },
        ),
        CustomElevatedButton(
          text: '취소',
          buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
          buttonStyle: CustomButtonStyles.fillRedTransparent,
          margin: const EdgeInsets.only(left: 16),
          width: 90,
          height: 44,
          onPressed: () => Get.offAllNamed(AppRoutes.masterManage),
        ),
      ],
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
          onTap: () => Get.offAllNamed(AppRoutes.contentChallengeManage),
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
        Text("Challenge 신규 등록", style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Challenge 신규 등록",
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}

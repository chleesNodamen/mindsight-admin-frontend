import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/goal.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_register/challenge_register_controller.dart';
import 'package:mindsight_admin_page/widgets/select_content_widget.dart';

class ChallengeRegisterView extends GetWidget<ChallengeRegisterController> {
  const ChallengeRegisterView({super.key});

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
                        child: ListView(children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                            child: Form(
                              key: _formKey,
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
                                  _buildSaveNCancel(_formKey),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Column _buildBasicInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Basic info".tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        BuildInput(
            label: "Title".tr,
            essential: true,
            textController: controller.nameController),
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
                      text: "Purpose".tr,
                      style: CustomTextStyles.labelLargeBlack),
                  TextSpan(text: " *", style: TextStyle(color: appTheme.red))
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
                          value.displayName.tr,
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
                      text: "Period".tr,
                      style: CustomTextStyles.labelLargeBlack),
                  TextSpan(text: " *", style: TextStyle(color: appTheme.red))
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
          TextSpan(
              text: "Introduction".tr, style: CustomTextStyles.labelLargeBlack),
          TextSpan(text: " *", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: controller.introController,
          maxLines: 5,
          width: 730,
          contentPadding: const EdgeInsets.only(left: 16, top: 17, bottom: 17),
          filled: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field is required.".tr;
            }
            return null;
          },
        )
      ],
    );
  }

  Column _buildDaySessionInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Day session Register".tr,
            style: CustomTextStyles.bodyMediumBlack),
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
            BuildInput(
                label: "Title".tr,
                essential: true,
                textController: controller.dayNameController),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Content".tr,
                      style: CustomTextStyles.labelLargeBlack),
                  TextSpan(text: " *", style: TextStyle(color: appTheme.red))
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

      int day = i;

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
              (day + 1).toString(),
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
        Text("File".tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        PickFile(
          labelText: "Thumbnail file".tr,
          essential: true,
          initialUrl: controller.thumbnailFile.value?.name,
          hintText: ".jpg",
          fileExtension: [FileExtension.jpg.keywordName],
          isCircular: false,
          onFilePicked: (pickedFile) {
            controller.onPickThumbnail(pickedFile);
          },
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
          child: Text("Challenge management".tr,
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
        Text("Challenge New registration".tr,
            style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Challenge New registration".tr,
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}

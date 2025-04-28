import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/goal.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_edit/challenge_edit_controller.dart';

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
                                _buildDaySession(),
                                const SizedBox(height: 32),
                                _buildFile(),
                                const SizedBox(height: 44),
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

  Column _buildFile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("File".tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        PickFile(
          labelText: "Thumbnail file".tr,
          essential: true,
          initialUrl: controller.challengeDetailsModel.thumbnail,
          hintText: ".jpg .jpeg .png",
          fileExtension: [
            FileExtension.jpg.keywordName,
            FileExtension.png.keywordName
          ],
          isCircular: false,
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
          text: 'Save'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
          buttonStyle: CustomButtonStyles.fillPrimary,
          // width: 90,
          height: 44,
          onPressed: controller.onSave,
        ),
        CustomElevatedButton(
          text: 'Cancel'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
          buttonStyle: CustomButtonStyles.fillRedTransparent,
          margin: const EdgeInsets.only(left: 16),
          // width: 90,
          height: 44,
          onPressed: () => Get.offAllNamed(AppRoutes.challengeDetails,
              arguments: {RouteArguments.id: controller.id}),
        ),
      ],
    );
  }

  Column _buildDaySession() {
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
          children: _buildDays(),
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
              children: List.generate(
                  controller.selectedDayDetail.contentNames!.length, (index) {
                return Container(
                  width: 353,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder12,
                      border: Border.all(color: appTheme.grayScale3),
                      color: appTheme.grayScale2),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 280,
                        child: Text(
                          controller.selectedDayDetail.contentNames![index],
                          style: CustomTextStyles.bodyMediumGray,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CustomImageView(
                        imagePath: IconConstant.search,
                      )
                    ],
                  ),
                );
              }),
            ),
          ],
        )
      ],
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
                      borderRadius: BorderRadiusStyle.roundedBorder12,
                      border: Border.all(color: appTheme.grayScale3),
                      color: appTheme.grayScale2),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${controller.challengeDetailsModel.duration!.toString()}${"Day".tr}',
                          style: CustomTextStyles.bodyMediumGray),
                      CustomImageView(
                        imagePath: IconConstant.more,
                      )
                    ],
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
            contentPadding:
                const EdgeInsets.only(left: 16, top: 17, bottom: 17),
            filled: true),
        const SizedBox(height: 24),
        _buildExposured()
      ],
    );
  }

  List<Widget> _buildDays() {
    List<Widget> widgets = [];
    for (int i = 0; i < controller.challengeDetailsModel.days!.length; i++) {
      if (i > 0 && i % 14 == 0) {
        widgets.add(const SizedBox(
          width: double.infinity,
        ));
      }

      int day = controller.challengeDetailsModel.days![i].day!;

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
        InkWell(
          onTap: () => Get.offAllNamed(AppRoutes.challengeDetails,
              arguments: {RouteArguments.id: controller.id}),
          child: Text("Challenge Detail".tr,
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
        Text("Challenge Edit".tr, style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Challenge Edit".tr,
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }

  Widget _buildStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Comfirm".tr,
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
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
          child: DropdownButton<ContentStatus>(
            hint: Text('Select Option'.tr,
                style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value: ContentStatus.fromKeyword(
                controller.challengeDetailsModel.status!),
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentStatus? newValue) {
              controller.isLoading.value = true;
              controller.challengeDetailsModel.status = newValue?.keywordName;
              controller.isLoading.value = false;
            },
            items: [ContentStatus.approve, ContentStatus.disapprove]
                .map<DropdownMenuItem<ContentStatus>>((ContentStatus value) {
              return DropdownMenuItem<ContentStatus>(
                value: value,
                child: Text(
                  value.displayName.tr,
                  style: CustomTextStyles.bodyMediumBlack,
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildExposured() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Exposure".tr,
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
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
          child: DropdownButton<ContentExposure>(
            hint: Text('Select Option'.tr,
                style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value: ContentExposure.fromKeyword(
                controller.challengeDetailsModel.exposure!),
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentExposure? newValue) {
              controller.isLoading.value = true;
              controller.challengeDetailsModel.exposure = newValue?.keywordName;
              controller.isLoading.value = false;
            },
            items: [
              ContentExposure.exposed,
              ContentExposure.nonExposed
            ].map<DropdownMenuItem<ContentExposure>>((ContentExposure value) {
              return DropdownMenuItem<ContentExposure>(
                value: value,
                child: Text(
                  value.displayName.tr,
                  style: CustomTextStyles.bodyMediumBlack,
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

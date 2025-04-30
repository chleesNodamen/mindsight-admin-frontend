import 'package:el_tooltip/el_tooltip.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/emotion.dart';
import 'package:mindsight_admin_page/enum/situation.dart';
import 'package:mindsight_admin_page/function/show_master_search_dialog.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_edit/content_edit_controller.dart';

class ContentEditView extends GetWidget<ContentEditController> {
  const ContentEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Obx(() => Scaffold(
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
                            padding: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                            children: [
                              TobBarSearch(
                                name: "Content New Registration".tr,
                                searchShow: false,
                                viewCount: false,
                              ),
                              const SizedBox(height: 32),
                              _buildSubMenu(),
                              const SizedBox(height: 32),
                              Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Visibility(
                                    //     visible: Account.isAdmin,
                                    //     child: _buildMasterInfo()),
                                    _buildBasicInfo(),
                                    const SizedBox(height: 32),
                                    _buildFile(),
                                    const SizedBox(height: 32),
                                    _buildSaveNCancel(formKey),
                                  ],
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
        ));
  }

  // Widget _buildMasterInfo() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           Text("Master info".tr, style: CustomTextStyles.bodyMediumBlack),
  //           Text(" 관리자에게만 보이는 임시 마스터 선택창".tr,
  //               style: CustomTextStyles.labelMediumGray),
  //         ],
  //       ),
  //       const SizedBox(height: 24),
  //       InkWell(
  //         onTap: () async {
  //           var result = await showMasterSearchDialog();
  //           if (result != null) {
  //             controller.selectedMaster.value = result;
  //           }
  //         },
  //         child: Container(
  //           width: 353,
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadiusStyle.roundedBorder12,
  //               border: Border.all(color: appTheme.grayScale3),
  //               color: appTheme.white),
  //           padding: const EdgeInsets.all(16),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                   controller.selectedMaster.value == null
  //                       ? ""
  //                       : controller.selectedMaster.value!["nickname"]!,
  //                   style: CustomTextStyles.bodyMediumGray),
  //               CustomImageView(
  //                 imagePath: IconConstant.search,
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 32),
  //     ],
  //   );
  // }

  Row _buildSaveNCancel(GlobalKey<FormState> formKey) {
    return Row(
      children: [
        CustomElevatedButton(
          text: 'Save'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
          buttonStyle: CustomButtonStyles.fillPrimary,
          height: 44,
          margin: const EdgeInsets.only(right: 16),
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
          height: 44,
          onPressed: () => Get.offAllNamed(AppRoutes.contentManage),
        ),
      ],
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
            child: Text(
              "Content list".tr,
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () {
              Get.offAllNamed(AppRoutes.contentManage);
            }),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        InkWell(
            child: Text(
              "Content details".tr,
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () {
              Get.offAllNamed(AppRoutes.contentDetails,
                  arguments: {RouteArguments.id: controller.id});
            }),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text('Content Edit'.tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Basic info'.tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Row(
          children: [
            BuildInput(
              width: 353,
              label: "Title".tr,
              essential: true,
              textController: controller.nameController,
              toolTip: "Please enter the title within 100 characters.".tr,
              // descriptions: "Please enter the title within 100 characters.".tr,
            ),
            const SizedBox(width: 24),
            _buildLevel()
          ],
        ),
        const SizedBox(height: 24),
        _buildTags(),
        const SizedBox(height: 24),
        _buildIntro(),
        const SizedBox(height: 24),
        _buildTargetLanguage(),
        const SizedBox(height: 24),
        _buildExposured(),
      ],
    );
  }

  Widget _buildLevel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Level".tr,
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
              TextSpan(text: " *", style: TextStyle(color: appTheme.red))
            ])),
          ],
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
          child: DropdownButton<ContentLevel>(
            hint: Text(
              'Select Option'.tr,
              style: CustomTextStyles.bodyMediumGray,
            ),
            isExpanded: true,
            value: ContentLevel.fromKeyword(
                controller.contentDetailsModel.value.level!),
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            elevation: 16,
            onChanged: (ContentLevel? newValue) {
              controller.contentDetailsModel.value.level =
                  newValue!.keywordName;
              controller.contentDetailsModel.refresh();

              Logger.info(controller.contentDetailsModel.value.level);
            },
            items: [
              ContentLevel.all,
              ContentLevel.advanced,
              ContentLevel.intermediate,
              ContentLevel.beginner,
            ].map<DropdownMenuItem<ContentLevel>>((ContentLevel value) {
              return DropdownMenuItem<ContentLevel>(
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

  Widget _buildTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Tags".tr, style: CustomTextStyles.labelLargeBlack),
            const Text(" *", style: TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "After entering tags, register by clicking '+' or pressing Enter.".tr,
          style: CustomTextStyles.labelLargeGray,
        ),
        const SizedBox(height: 8),
        _buildTagChips(),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: controller.tagController,
          width: 730,
          hintText: "Input Text".tr,
          suffix: CustomImageView(
            imagePath: IconConstant.add,
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(right: 16),
            onTap: () => controller.addTag(controller.tagController.text),
          ),
          onSubmitted: controller.addTag,
          validator: (value) =>
              (controller.contentDetailsModel.value.tags?.isEmpty == true)
                  ? "This field is required.".tr
                  : null,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
          filled: true,
        ),
        const SizedBox(height: 16),
        Container(
          width: 730,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: appTheme.white,
            border: Border.all(color: appTheme.grayScale2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSingleCategoryGroup("Category".tr, ContentCategory.values),
              const SizedBox(height: 24),
              _buildTagGroup("Situation".tr,
                  Situation.values.map((e) => e.displayName.tr).toList()),
              const SizedBox(height: 24),
              _buildTagGroup("Emotion".tr,
                  Emotion.values.map((e) => e.displayName.tr).toList()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSingleCategoryGroup(
      String label, List<ContentCategory> categories) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 80,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(text: label, style: CustomTextStyles.bodyMediumBlack),
              const TextSpan(text: " *", style: TextStyle(color: Colors.red))
            ]))),
        const SizedBox(width: 10),
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((category) {
              final isSelected =
                  controller.contentDetailsModel.value.category ==
                      category.keywordName;
              return InkWell(
                onTap: () {
                  controller.contentDetailsModel.value.category =
                      category.keywordName;

                  // 태그에도 반영 (중복 방지 위해 전체 제거 후 추가)
                  controller.contentDetailsModel.value.tags?.removeWhere(
                      (tag) => ContentCategory.values
                          .map((e) => e.displayName.tr)
                          .contains(tag));
                  controller.addTag(category.displayName.tr);

                  controller.contentDetailsModel.refresh();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? appTheme.skyBlue : appTheme.grayScale1,
                    border: Border.all(color: appTheme.grayScale2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category.displayName.tr,
                    style: isSelected
                        ? CustomTextStyles.labelLargeWhite
                        : CustomTextStyles.bodySmallBlack,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTagGroup(String label, List<String> tags) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 80,
            child: Text(label, style: CustomTextStyles.bodyMediumBlack)),
        const SizedBox(width: 10),
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) {
              final isSelected =
                  controller.contentDetailsModel.value.tags?.contains(tag);
              return InkWell(
                onTap: () {
                  if (isSelected ?? false) {
                    controller.contentDetailsModel.value.tags?.remove(tag);
                  } else {
                    controller.addTag(tag);
                  }
                  controller.contentDetailsModel.refresh();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: (isSelected ?? false)
                        ? appTheme.skyBlue
                        : appTheme.grayScale1,
                    border: Border.all(color: appTheme.grayScale2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tag,
                    style: (isSelected ?? false)
                        ? CustomTextStyles.labelLargeWhite
                        : CustomTextStyles.bodySmallBlack,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTagChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: controller.contentDetailsModel.value.tags == null
          ? []
          : controller.contentDetailsModel.value.tags!.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: AppDecoration.fillSkyBlue
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder32),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(tag, style: CustomTextStyles.labelLargeWhite),
                    const SizedBox(width: 4),
                    CustomImageView(
                        imagePath: IconConstant.close,
                        color: appTheme.white,
                        width: 15,
                        height: 15,
                        onTap: () {
                          controller.contentDetailsModel.value.tags
                              ?.remove(tag);
                          controller.contentDetailsModel.refresh();
                        })
                  ],
                ),
              );
            }).toList(),
    );
  }

  Widget _buildTargetLanguage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Target Language".tr,
                    style: CustomTextStyles.labelLargeBlack.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: " *",
                    style: TextStyle(color: appTheme.red),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            ElTooltip(
              showModal: false,
              showArrow: false,
              distance: 0,
              padding: EdgeInsets.zero,
              content: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black, // ✅ 더 진한 말풍선 배경
                    borderRadius: BorderRadius.circular(6), // ✅ 모서리 둥글게
                  ),
                  child: Text(
                      "It will be displayed in the specified language version."
                          .tr,
                      style: CustomTextStyles.labelLargeWhite)),
              position: ElTooltipPosition.topStart,
              child: const Icon(Icons.info_outline, size: 20),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: 730,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: appTheme.grayScale3,
            ),
            color: appTheme.white,
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: Wrap(
            spacing: 16,
            runSpacing: 8,
            children: controller.contentLanguage.map((language) {
              final isSelected =
                  controller.contentDetailsModel.value.targetLanguage ==
                      language.keywordName;
              return InkWell(
                onTap: () {
                  controller.contentDetailsModel.value.targetLanguage =
                      language.keywordName;

                  controller.contentDetailsModel.refresh();
                },
                borderRadius: BorderRadius.circular(20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color:
                          isSelected ? appTheme.skyBlue : appTheme.grayScale3,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      language.displayName.tr,
                      style: isSelected
                          ? CustomTextStyles.bodyMediumBlack
                          : CustomTextStyles.bodyMediumGray,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildExposured() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Exposure".tr,
                    style: CustomTextStyles.labelLargeBlack.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: " *",
                    style: TextStyle(color: appTheme.red),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            ElTooltip(
              showModal: false,
              showArrow: false,
              distance: 0,
              padding: EdgeInsets.zero,
              content: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black, // ✅ 더 진한 말풍선 배경
                    borderRadius: BorderRadius.circular(6), // ✅ 모서리 둥글게
                  ),
                  child: Text(
                      "It must be set to “exposed” in order to be shown in the service."
                          .tr,
                      style: CustomTextStyles.labelLargeWhite)),
              position: ElTooltipPosition.topStart,
              child: const Icon(Icons.info_outline, size: 20),
            )
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: 730,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: appTheme.grayScale3,
            ),
            color: appTheme.white,
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: Row(
            children: [
              _buildExposureOption(ContentExposure.exposed),
              const SizedBox(width: 16),
              _buildExposureOption(ContentExposure.nonExposed),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExposureOption(ContentExposure exposure) {
    final isSelected =
        controller.contentDetailsModel.value.exposure == exposure.keywordName;
    return InkWell(
      onTap: () {
        controller.contentDetailsModel.value.exposure = exposure.keywordName;
        controller.contentDetailsModel.refresh();
      },
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: isSelected ? appTheme.skyBlue : appTheme.grayScale3,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            exposure.displayName.tr,
            style: isSelected
                ? CustomTextStyles.bodyMediumBlack
                : CustomTextStyles.bodyMediumGray,
          ),
        ],
      ),
    );
  }

  Widget _buildIntro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Introduction".tr, style: CustomTextStyles.labelLargeBlack),
            const Text(" *", style: TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "Please enter an introduction within 150 characters.".tr,
          style: CustomTextStyles.labelLargeGray,
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          textInputAction: TextInputAction.newline,
          width: 730,
          textInputType: TextInputType.multiline,
          maxLines: 6,
          controller: controller.introController,
          hintText: "Input Text".tr,
          contentPadding: const EdgeInsets.all(16),
          validator: (value) => value == null || value.isEmpty
              ? "This field is required.".tr
              : null,
        ),
      ],
    );
  }

  Widget _buildFile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("File".tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 8),
        Text("You can upload video or audio files.".tr,
            style: CustomTextStyles.bodySmallGray),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                PickFile(
                  labelText: "Media File".tr,
                  essential: true,
                  hintText: controller.contentDetailsModel.value.video ??
                      "click to upload .mp4 .mp3 .wav".tr,
                  fileExtension: [
                    FileExtension.mp4.keywordName,
                    FileExtension.mp3.keywordName,
                    FileExtension.wav.keywordName
                  ],
                  isCircular: false,
                  onFilePicked: controller.onPickMedia,
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: !(controller
                          .contentDetailsModel.value.isTranscodingCompleted ??
                      true),
                  child: Text(
                      "The media file is currently being transcoded and cannot be modified."
                          .tr,
                      style: CustomTextStyles.bodySmallGray),
                ),
              ],
            ),
            const SizedBox(width: 24),
            PickFile(
              aspectRatio: 16 / 9,
              labelText: "Thumbnail file".tr,
              essential: true,
              hintText: controller.contentDetailsModel.value.thumbnail ??
                  "click to upload .jpg .jpeg .png".tr,
              fileExtension: [
                FileExtension.jpg.keywordName,
                FileExtension.jpeg.keywordName,
                FileExtension.png.keywordName
              ],
              isCircular: false,
              onFilePicked: controller.onPickThumbnail,
            ),
          ],
        )
      ],
    );
  }
}



/*
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_edit/content_edit_controller.dart';

class ContentEditView extends GetWidget<ContentEditController> {
  const ContentEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Obx(() => Scaffold(
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
                              child: Column(
                                children: [
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        _buildTitle(),
                                        const SizedBox(height: 16),
                                        _buildSubMenu(),
                                        const SizedBox(height: 32),
                                        _buildBasicInfo(),
                                        const SizedBox(height: 32),
                                        _buildFile(),
                                        const SizedBox(height: 32),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomElevatedButton(
                                        text: 'Save'.tr,
                                        buttonTextStyle: CustomTextStyles
                                            .bodyMediumWhiteBold,
                                        buttonStyle:
                                            CustomButtonStyles.fillPrimary,
                                        // width: 90,
                                        height: 44,
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            controller.onSave();
                                          }
                                        },
                                      ),
                                      CustomElevatedButton(
                                        text: 'Cancel'.tr,
                                        buttonTextStyle:
                                            CustomTextStyles.bodyMediumRedBold,
                                        buttonStyle: CustomButtonStyles
                                            .fillRedTransparent,
                                        margin: const EdgeInsets.only(left: 16),
                                        // width: 90,
                                        height: 44,
                                        onPressed: () => Get.offAllNamed(
                                            AppRoutes.contentDetails,
                                            arguments: {
                                              RouteArguments.id: controller.id
                                            }),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        )));
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
            child: Text(
              "Content list".tr,
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () {
              Get.offAllNamed(AppRoutes.contentManage);
            }),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        InkWell(
            child: Text(
              "Content details".tr,
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () {
              Get.offAllNamed(AppRoutes.contentDetails,
                  arguments: {RouteArguments.id: controller.id});
            }),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text('Content Edit'.tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Content Edit".tr,
      searchShow: false,
      viewCount: false,
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Basic info'.tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        BuildInput(
            label: "Title".tr,
            essential: true,
            textController: controller.nameController),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildCategory(),
            const SizedBox(width: 24),
            _buildLevel()
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildTargetLanguage(),
            const SizedBox(width: 24),
            _buildExposured()
          ],
        ),
        const SizedBox(height: 24),
        _buildTags(),
        const SizedBox(height: 24),
        _buildIntro(),
      ],
    );
  }

  Column _buildCategory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Category".tr,
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
          child: DropdownButton<ContentCategory>(
            hint: Text('Select Option'.tr,
                style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value: ContentCategory.fromKeyword(
                controller.contentDetailsModel.value.category!),
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            elevation: 16,
            onChanged: (ContentCategory? newValue) {
              controller.isLoading.value = true;
              controller.contentDetailsModel.value.category = newValue?.keywordName;
              controller.isLoading.value = false;
            },
            // items: [
            //   ContentCategory.body,
            //   ContentCategory.breath,
            //   ContentCategory.mindfulness,
            //   ContentCategory.theory,
            // ].map<DropdownMenuItem<ContentCategory>>((ContentCategory value) {
            //   return DropdownMenuItem<ContentCategory>(
            //     value: value,
            //     child: Text(
            //       value.displayName.tr,
            //       style: CustomTextStyles.bodyMediumBlack,
            //     ),
            //   );
            // }).toList(),

            items: ContentCategory.values
                .where((e) => e != ContentCategory.body)
                .map<DropdownMenuItem<ContentCategory>>(
                    (ContentCategory value) {
              return DropdownMenuItem<ContentCategory>(
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

  Widget _buildLevel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Level".tr,
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
          child: DropdownButton<ContentLevel>(
            hint: Text('Select Option'.tr,
                style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value:
                ContentLevel.fromKeyword(controller.contentDetailsModel.value.level!),
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentLevel? newValue) {
              controller.isLoading.value = true;
              controller.contentDetailsModel.value.level = newValue?.keywordName;
              controller.isLoading.value = false;
            },
            items: [
              ContentLevel.all,
              ContentLevel.advanced,
              ContentLevel.intermediate,
              ContentLevel.beginner,
            ].map<DropdownMenuItem<ContentLevel>>((ContentLevel value) {
              return DropdownMenuItem<ContentLevel>(
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

  Widget _buildTargetLanguage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Target Language".tr,
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
          child: DropdownButton<ContentLanguage>(
            hint: Text('Select Option'.tr,
                style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value: ContentLanguage.fromKeyword(
                controller.contentDetailsModel.value.targetLanguage!),
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentLanguage? newValue) {
              controller.isLoading.value = true;
              controller.contentDetailsModel.value.targetLanguage =
                  newValue?.keywordName;
              controller.isLoading.value = false;
            },
            items: [
              ContentLanguage.english,
              ContentLanguage.korean
            ].map<DropdownMenuItem<ContentLanguage>>((ContentLanguage value) {
              return DropdownMenuItem<ContentLanguage>(
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
                controller.contentDetailsModel.value.exposure!),
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentExposure? newValue) {
              controller.onExposureChange(newValue);
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

  Widget _buildTags() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Tags".tr,
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: " *", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        Text(
            "After entering tags, please register them by clicking the '+' button or pressing Enter."
                .tr,
            style: CustomTextStyles.labelLargeGray),
        const SizedBox(height: 8),
        controller.contentDetailsModel.value.tags!.isEmpty
            ? const SizedBox.shrink()
            : _buildTagChips(),
        CustomTextFormField(
            controller: controller.tagController,
            width: 730,
            hintText: "Input text".tr,
            hintStyle: CustomTextStyles.bodyMediumGray,
            suffix: CustomImageView(
              imagePath: IconConstant.add,
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(right: 16),
              onTap: () {
                controller.addTag(controller.tagController.text);
              },
            ),
            onSubmitted: (value) {
              controller.addTag(value);
            },
            validator: (value) {
              if (controller.contentDetailsModel.value.tags!.isEmpty) {
                return "This field is required.".tr;
              }
              return null;
            },
            contentPadding:
                const EdgeInsets.only(left: 16, top: 17, bottom: 17),
            // focusedBorderDecoration:
            //     TextFormFieldStyleHelper.outlineSkyBlue,
            filled: true),
      ],
    );
  }

  Widget _buildTagChips() {
    return Column(
      children: [
        Row(
            children: List.generate(controller.contentDetailsModel.value.tags!.length,
                (index) {
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: AppDecoration.fillSkyBlue
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder32),
                child: UnconstrainedBox(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 4,
                      ),
                      Text(controller.contentDetailsModel.value.tags![index],
                          style: CustomTextStyles.labelLargeWhite),
                      CustomImageView(
                        imagePath: IconConstant.close,
                        color: appTheme.white,
                        width: 15,
                        height: 15,
                        margin: const EdgeInsets.only(left: 8),
                        onTap: () {
                          Logger.info(
                              controller.contentDetailsModel.value.tags![index]);

                          controller.isLoading.value = true;
                          controller.contentDetailsModel.value.tags!.remove(
                              controller.contentDetailsModel.value.tags![index]);
                          controller.isLoading.value = false;
                        },
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          );
        })),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget _buildIntro() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Introduction".tr,
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: " *", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(
          height: 8,
        ),
        KeyboardListener(
          focusNode: controller.focusNode,
          onKeyEvent: (KeyEvent evt) {
            if (evt.logicalKey.keyLabel == 'Enter') {
              if (evt is KeyDownEvent) {
                controller.nextList();
              }
            }
          },
          child: CustomTextFormField(
            textInputAction: TextInputAction.newline,
            width: 730,
            textInputType: TextInputType.multiline,
            maxLines: 6,
            controller: controller.introController,
            hintText: "Input text".tr,
            contentPadding: const EdgeInsets.all(16),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required.".tr;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("File".tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PickFile(
              labelText: "Media File".tr,
              essential: true,
              initialUrl: controller.contentDetailsModel.value.video,
              hintText: ".mp4, .mp3, .wav",
              fileExtension: [
                FileExtension.mp4.keywordName,
                FileExtension.mp3.keywordName,
                FileExtension.wav.keywordName
              ],
              isCircular: false,
              onFilePicked: (pickedFile) {
                controller.onPickMedia(pickedFile);
              },
              toolTip:
                  "Files are automatically optimized through transcoding during upload. You can save them once transcoding is complete."
                      .tr,
            ),
            const SizedBox(width: 24),
            PickFile(
              labelText: "Thumbnail file".tr,
              essential: true,
              initialUrl: controller.contentDetailsModel.value.thumbnail,
              hintText: ".jpg .jpeg .png",
              fileExtension: [FileExtension.jpg.keywordName, FileExtension.jpeg.keywordName, FileExtension.png.keywordName],
              isCircular: false,
              onFilePicked: (pickedFile) {
                controller.onPickThumbnail(pickedFile);
              },
            )
          ],
        ),
        const SizedBox(height: 24),
        // PickFile(
        //   labelText: "CC file".tr,
        //   essential: false,
        //   hintText: controller.ccFile?.name ?? ".srt",
        //   fileExtension: [FileExtension.srt.keywordName],
        //   onFilePicked: (pickedFile) {
        //     controller.onPickCC(pickedFile);
        //   },
        // ),
        // const SizedBox(height: 24),
        // _buildDubbing(),
        // const SizedBox(height: 24),
        // Text(controller.transcodingUploader.ffmpegStatus.value,
        //     style: CustomTextStyles.bodyMediumBlack),
      ],
    );
  }

  Widget _buildDubbing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(text: "더빙".tr, style: CustomTextStyles.bodyMediumBlack),
        ])),
        const SizedBox(height: 24),
        Container(
          width: 353,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder12,
              border: Border.all(color: appTheme.grayScale3),
              color: appTheme.white),
          padding: const EdgeInsets.all(16),
          child: Wrap(
            runSpacing: 18,
            children: List.generate(controller.contentLanguage.length, (index) {
              return CustomCheckboxWidget(
                  isChecked: false,
                  label: controller.contentLanguage[index].displayName.tr,
                  // label: "영어",
                  onChanged: (value) {});
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildThumnailFile() {
    return PickFile(
      labelText: "Thumbnail file".tr,
      essential: true,
      initialUrl: controller.contentDetailsModel.value.thumbnail,
      hintText: ".jpg .jpeg .png",
      fileExtension: [FileExtension.jpg.keywordName, FileExtension.jpeg.keywordName, FileExtension.png.keywordName],
      isCircular: false,
      onFilePicked: (pickedFile) {
        controller.onPickThumbnail(pickedFile);
      },
    );
  }
}
*/
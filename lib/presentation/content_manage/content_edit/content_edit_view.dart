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
              "Content Details".tr,
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
                controller.contentDetailsModel.category!),
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            elevation: 16,
            onChanged: (ContentCategory? newValue) {
              controller.isLoading.value = true;
              controller.contentDetailsModel.category = newValue?.keywordName;
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
                ContentLevel.fromKeyword(controller.contentDetailsModel.level!),
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentLevel? newValue) {
              controller.isLoading.value = true;
              controller.contentDetailsModel.level = newValue?.keywordName;
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
                controller.contentDetailsModel.targetLanguage!),
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentLanguage? newValue) {
              controller.isLoading.value = true;
              controller.contentDetailsModel.targetLanguage =
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
                controller.contentDetailsModel.exposure!),
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
        controller.contentDetailsModel.tags!.isEmpty
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
              if (controller.contentDetailsModel.tags!.isEmpty) {
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
            children: List.generate(controller.contentDetailsModel.tags!.length,
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
                      Text(controller.contentDetailsModel.tags![index],
                          style: CustomTextStyles.labelLargeWhite),
                      CustomImageView(
                        imagePath: IconConstant.close,
                        color: appTheme.white,
                        width: 15,
                        height: 15,
                        margin: const EdgeInsets.only(left: 8),
                        onTap: () {
                          Logger.info(
                              controller.contentDetailsModel.tags![index]);

                          controller.isLoading.value = true;
                          controller.contentDetailsModel.tags!.remove(
                              controller.contentDetailsModel.tags![index]);
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
              initialUrl: controller.contentDetailsModel.video,
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
              initialUrl: controller.contentDetailsModel.thumbnail,
              hintText: ".jpg",
              fileExtension: [FileExtension.jpg.keywordName],
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
      initialUrl: controller.contentDetailsModel.thumbnail,
      hintText: ".jpg",
      fileExtension: [FileExtension.jpg.keywordName],
      isCircular: false,
      onFilePicked: (pickedFile) {
        controller.onPickThumbnail(pickedFile);
      },
    );
  }
}

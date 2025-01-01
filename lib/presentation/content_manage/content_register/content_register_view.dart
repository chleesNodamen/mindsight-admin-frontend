import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_register/content_register_controller.dart';

class ContentRegisterView extends GetWidget<ContentRegisterController> {
  const ContentRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                                    _buildBasicInfo(),
                                    const SizedBox(height: 32),
                                    _buildFile(),
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
        )));
  }

  Row _buildSaveNCancel(GlobalKey<FormState> formKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomElevatedButton(
          text: '저장'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
          buttonStyle: CustomButtonStyles.fillPrimary,
          width: 90,
          height: 44,
          margin: const EdgeInsets.only(right: 16),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              controller.onSave();
            }
          },
        ),
        // CustomElevatedButton(
        //   text: '승인 요청',
        //   buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
        //   buttonStyle: CustomButtonStyles.fillPrimary,
        //   width: 90,
        //   height: 44,
        //   margin: const EdgeInsets.only(right: 16),
        //   onPressed: () {
        //     showSimpleMessage(
        //         "승인 요청 되었습니다. 최대 2영업일이 소요 됩니다.\n승인이 완료 되면 메일로 알림 드리겠습니다.");
        //   },
        // ),
        CustomElevatedButton(
          text: '취소'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
          buttonStyle: CustomButtonStyles.fillRedTransparent,
          width: 90,
          height: 44,
          onPressed: () => Get.offAllNamed(AppRoutes.contentManage),
        ),
      ],
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('기본 정보'.tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        BuildInput(
          label: "제목".tr,
          essential: true,
          textController: controller.nameController,
        ),
        const SizedBox(height: 24),
        _buildCategoryNType(),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildLevel(),
            const SizedBox(width: 24),
            _buildTargetLanguage(),
          ],
        ),
        const SizedBox(height: 24),
        _buildExposured(),
        const SizedBox(height: 24),
        _buildTags(),
        const SizedBox(height: 24),
        _buildIntro(),
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
              text: "노출".tr,
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
            value: controller.selectedExposure.value,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentExposure? newValue) {
              controller.selectedExposure.value = newValue;
            },
            items: [
              ContentExposure.exposed,
              ContentExposure.nonExposed,
            ].map<DropdownMenuItem<ContentExposure>>((ContentExposure value) {
              return DropdownMenuItem<ContentExposure>(
                value: value,
                child: Text(
                  value.displayName,
                  style: CustomTextStyles.bodyMediumBlack,
                ),
              );
            }).toList(),
          ),
        )
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
              text: "수준".tr,
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
            value: controller.selectedLevel.value,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentLevel? newValue) {
              controller.selectedLevel.value = newValue;
            },
            items: [
              ContentLevel.all,
              ContentLevel.upper,
              ContentLevel.middle,
              ContentLevel.lower,
            ].map<DropdownMenuItem<ContentLevel>>((ContentLevel value) {
              return DropdownMenuItem<ContentLevel>(
                value: value,
                child: Text(
                  value.displayName,
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
              text: "타겟 언어".tr,
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
            value: controller.selectedTargetLanguage.value,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentLanguage? newValue) {
              controller.selectedTargetLanguage.value = newValue;
            },
            items: controller.contentLanguage
                .map<DropdownMenuItem<ContentLanguage>>(
                    (ContentLanguage value) {
              return DropdownMenuItem<ContentLanguage>(
                value: value,
                child: Text(
                  value.displayName,
                  style: CustomTextStyles.bodyMediumBlack,
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
            child: Text(
              "콘텐츠 목록".tr,
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () => Get.offAllNamed(AppRoutes.contentManage)),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text('콘텐츠 신규 등록'.tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "콘텐츠 신규 등록".tr,
      searchShow: false,
      viewCount: false,
    );
  }

  Widget _buildName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "제목".tr,
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: " *", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        CustomTextFormField(
            controller: controller.nameController,
            width: 353,
            hintText: "Input text".tr,
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

  Row _buildCategoryNType() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "카테고리".tr,
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
                hint: Text(
                  'Select Option'.tr,
                  style: CustomTextStyles.bodyMediumGray,
                ),
                isExpanded: true,
                value: controller.selectedCategory.value,
                underline: Container(),
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 2,
                  bottom: 2,
                ),
                borderRadius: BorderRadiusStyle.roundedBorder12,
                elevation: 16,
                onChanged: (ContentCategory? newValue) {
                  controller.selectCategory(newValue);
                },
                items: [
                  ContentCategory.body,
                  ContentCategory.breath,
                  ContentCategory.mindfulness,
                  ContentCategory.theory,
                ].map<DropdownMenuItem<ContentCategory>>(
                    (ContentCategory value) {
                  return DropdownMenuItem<ContentCategory>(
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
                  text: "타입".tr,
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
              child: DropdownButton<ContentType>(
                  // enableFeedback: controller.categorySelected.value,
                  hint: Text('Select Option'.tr,
                      style: CustomTextStyles.bodyMediumGray),
                  isExpanded: true,
                  value: controller.selectedType.value,
                  underline: Container(),
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 2, bottom: 2),
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  // icon: const Icon(Icons.),
                  elevation: 16,
                  onChanged: (ContentType? newValue) {
                    controller.selectedType.value = newValue;
                  },
                  items: controller.categoryContentType
                      .map<DropdownMenuItem<ContentType>>((ContentType value) {
                    return DropdownMenuItem<ContentType>(
                      value: value,
                      child: Text(
                        value.displayName,
                        style: CustomTextStyles.bodyMediumBlack,
                      ),
                    );
                  }).toList()),
            ),
          ],
        ),
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
              text: "태그".tr,
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: " *", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        Text('태그 입력 후 ‘+’ 버튼 또는 Enter로 태그를 등록해주세요.'.tr,
            style: CustomTextStyles.labelLargeGray),
        const SizedBox(height: 8),
        controller.tags == [] ? const SizedBox.shrink() : _buildTagChips(),
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
              if (controller.tags.isEmpty) {
                return "필수 입력 항목입니다.".tr;
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
            children: List.generate(controller.tags.length, (index) {
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
                      Text(controller.tags[index],
                          style: CustomTextStyles.labelLargeWhite),
                      CustomImageView(
                        imagePath: IconConstant.close,
                        color: appTheme.white,
                        width: 15,
                        height: 15,
                        margin: const EdgeInsets.only(left: 8),
                        onTap: () {
                          controller.tags.remove(controller.tags[index]);
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
              text: "소개".tr,
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
            hintText: "Input Text".tr,
            contentPadding: const EdgeInsets.all(16),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "필수 입력 항목입니다.".tr;
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
        Text("파일".tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Row(
          children: [
            PickFileFormField(
              labelText: "미디어 파일".tr,
              essential: true,
              hintText: controller.mediaFile?.name ?? "(.mp4)",
              fileExtension: FileExtension.mp4.keywordName,
              onFilePicked: (pickedFile) {
                controller.onPickMedia(pickedFile);
              },
            ),
            const SizedBox(width: 24),
            PickFileFormField(
              labelText: "썸네일 파일".tr,
              essential: true,
              hintText: controller.thumbnailFile?.name ?? "(.jpg)",
              fileExtension: FileExtension.jpg.keywordName,
              onFilePicked: (pickedFile) {
                controller.onPickThumbnail(pickedFile);
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildDubbing(),
        const SizedBox(height: 24),
        Text(controller.transcodingUploader.ffmpegStatus.value,
            style: CustomTextStyles.bodyMediumBlack),
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
            children: List.generate(3, (index) {
              return CustomCheckboxWidget(
                  isChecked: false,
                  label: controller.contentLanguage[index].displayName,
                  onChanged: (value) {});
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildThumnailFile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(text: "썸네일 파일".tr, style: CustomTextStyles.labelLargeBlack),
          TextSpan(text: " *", style: TextStyle(color: appTheme.red)),
        ])),
        const SizedBox(height: 8),
        Container(
          width: 353,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder12,
              border: Border.all(color: appTheme.grayScale3),
              color: appTheme.white),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 280,
                child: Text(
                  controller.thumbnailName == "".obs
                      ? '(.jpg)'
                      : controller.thumbnailName.value,
                  style: controller.thumbnailName == "".obs
                      ? CustomTextStyles.bodyMediumGray
                      : CustomTextStyles.bodyMediumBlack,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CustomImageView(
                imagePath: IconConstant.upload,
                onTap: () {
                  // controller.pickFile("thumbnail");
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVideoOrSoundFile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
              width: 170,
              child: ListTile(
                  horizontalTitleGap: 0,
                  minLeadingWidth: 0,
                  minTileHeight: 0,
                  minVerticalPadding: 0,
                  contentPadding: EdgeInsets.zero,
                  //     const EdgeInsets.only(left: 0.0, right: 0.0),
                  title: Row(
                    children: <Widget>[
                      Radio<ActivityType>(
                        value: ActivityType.practice,
                        groupValue: ActivityType.practice,
                        onChanged: (ActivityType? value) {
                          // controller.onChangeType(value);
                        },
                      ),
                      Text("미디어 파일".tr,
                          style: CustomTextStyles.labelLargeBlack),
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
              width: 170,
              child: ListTile(
                  horizontalTitleGap: 0,
                  minLeadingWidth: 0,
                  minTileHeight: 0,
                  minVerticalPadding: 0,
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    children: <Widget>[
                      Radio<ActivityType>(
                        value: ActivityType.challenge,
                        groupValue: ActivityType.practice,
                        onChanged: (ActivityType? value) {
                          // controller.onChangeType(value);
                        },
                      ),
                      Text("사운드 파일".tr,
                          style: CustomTextStyles.labelLargeBlack),
                    ],
                  )),
            )
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: 353,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder12,
              border: Border.all(color: appTheme.grayScale3),
              color: appTheme.white),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 280,
                child: Text(
                  controller.thumbnailName == "".obs
                      ? '(.mpeg)'
                      : controller.thumbnailName.value,
                  style: controller.thumbnailName == "".obs
                      ? CustomTextStyles.bodyMediumGray
                      : CustomTextStyles.bodyMediumBlack,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CustomImageView(
                imagePath: IconConstant.upload,
                onTap: () {
                  // controller.pickFile("thumbnail");
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

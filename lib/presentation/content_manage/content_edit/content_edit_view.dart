import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/content_exposure.dart';
import 'package:mindsight_admin_page/constants/content_language.dart';
import 'package:mindsight_admin_page/constants/content_level.dart';
import 'package:mindsight_admin_page/constants/content_type.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_edit/content_edit_controller.dart';

class ContentEditView extends GetWidget<ContentEditController> {
  const ContentEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: ResponsiveWidget(
          largeScreen: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SideMenu(),
              Obx(
                () => Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                        child: Column(
                          children: [
                            Form(
                              key: formKey,
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
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomElevatedButton(
                                  text: '저장',
                                  buttonTextStyle:
                                      CustomTextStyles.bodyMediumWhiteBold,
                                  buttonStyle: CustomButtonStyles.fillPrimary,
                                  width: 90,
                                  height: 44,
                                  onPressed: () {
                                    if (formKey.currentState!.validate() &&
                                        controller.isSaveOk()) {
                                      controller.onSave();
                                    }
                                  },
                                ),
                                CustomElevatedButton(
                                  text: '취소',
                                  buttonTextStyle:
                                      CustomTextStyles.bodyMediumRedBold,
                                  buttonStyle:
                                      CustomButtonStyles.fillRedTransparent,
                                  margin: const EdgeInsets.only(left: 16),
                                  width: 90,
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
              ),
            ],
          ),
        ));
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
            child: Text(
              "콘텐츠 목록",
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
              "콘텐츠 상세",
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
        Text('콘텐츠 수정', style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "콘텐츠 수정",
      searchShow: false,
      viewCount: false,
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('기본 정보', style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "제목 ",
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: "*", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        CustomTextFormField(
            controller: controller.titleController,
            width: 353,
            validator: (value) {
              if (controller.titleController.text == '') {
                return "필수 입력 항목입니다.".tr;
              }
              return null;
            },
            contentPadding:
                const EdgeInsets.only(left: 16, top: 17, bottom: 17),
            filled: true),
        const SizedBox(height: 24),
        _buildCategoryNType(),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildLevel(),
            const SizedBox(width: 24),
            _buildTargetLanguage()
          ],
        ),
        const SizedBox(height: 24),
        _buildExposured(),
        const SizedBox(height: 24),
        _buildTags(),
        const SizedBox(height: 24),
        _enterIntro(),
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
                  text: "카테고리 ",
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
                  color: controller.enableCategoryError.value
                      ? appTheme.alertNegative
                      : appTheme.grayScale3,
                ),
                color: controller.enableCategoryError.value
                    ? appTheme.alertNegative.withOpacity(0.1)
                    : appTheme.white,
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: DropdownButton<Category>(
                hint: Text('Select Option',
                    style: CustomTextStyles.bodyMediumGray),
                isExpanded: true,
                value: controller.selectedCategory.value,
                underline: Container(),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 2, bottom: 2),
                borderRadius: BorderRadiusStyle.roundedBorder12,
                elevation: 16,
                onChanged: (Category? newValue) {
                  if (newValue != null) {
                    controller.selectCategory(newValue);
                  }
                },
                items: controller.categories
                    .map<DropdownMenuItem<Category>>((Category value) {
                  return DropdownMenuItem<Category>(
                    value: value,
                    child: Text(
                      value.displayName,
                      style: CustomTextStyles.bodyMediumBlack,
                    ),
                  );
                }).toList(),
              ),
            ),
            controller.enableCategoryError.value
                ? Column(
                    children: [
                      const SizedBox(height: 8),
                      Text('필수 입력 항목입니다.',
                          style: CustomTextStyles.labelMediumRed),
                    ],
                  )
                : const SizedBox.shrink(),
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
                  text: "타입 ",
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
                  color: controller.enableTypeError.value
                      ? appTheme.alertNegative
                      : appTheme.grayScale3,
                ),
                color: controller.enableTypeError.value
                    ? appTheme.alertNegative.withOpacity(0.1)
                    : appTheme.white,
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: DropdownButton<ContentType>(
                  enableFeedback: controller.categorySelected.value,
                  hint: Text('Select Option',
                      style: CustomTextStyles.bodyMediumGray),
                  isExpanded: true,
                  value: controller.selectedType.value == ""
                      ? null
                      : controller.selectedType.value,
                  underline: Container(),
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 2, bottom: 2),
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  // icon: const Icon(Icons.),
                  elevation: 16,
                  onChanged: (ContentType? newValue) {
                    if (newValue != null) {
                      controller.selectedType.value = newValue;
                      controller.enableTypeError.value = false;
                    }
                  },
                  items: controller.categorySelected.value
                      ? controller.types[controller.selectedCategory.value]!
                          .map<DropdownMenuItem<ContentType>>(
                              (ContentType value) {
                          return DropdownMenuItem<ContentType>(
                            value: value,
                            child: Text(
                              value.displayName,
                              style: CustomTextStyles.bodyMediumBlack,
                            ),
                          );
                        }).toList()
                      : <ContentType>[].map<DropdownMenuItem<ContentType>>(
                          (ContentType value) {
                          return DropdownMenuItem<ContentType>(
                            value: value,
                            child: Text(
                              value.displayName,
                              style: CustomTextStyles.bodyMediumBlack,
                            ),
                          );
                        }).toList()),
            ),
            controller.enableTypeError.value
                ? Column(
                    children: [
                      const SizedBox(height: 8),
                      Text('필수 입력 항목입니다.',
                          style: CustomTextStyles.labelMediumRed),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
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
                  text: "카테고리 ",
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
                  color: controller.enableCategoryError.value
                      ? appTheme.alertNegative
                      : appTheme.grayScale3,
                ),
                color: controller.enableCategoryError.value
                    ? appTheme.alertNegative.withOpacity(0.1)
                    : appTheme.white,
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: DropdownButton<Category>(
                hint: Text('Select Option',
                    style: CustomTextStyles.bodyMediumGray),
                isExpanded: true,
                value: controller.selectedCategory.value,
                underline: Container(),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 2, bottom: 2),
                borderRadius: BorderRadiusStyle.roundedBorder12,
                elevation: 16,
                onChanged: (Category? newValue) {
                  if (newValue != null) {
                    controller.selectCategory(newValue);
                  }
                },
                items: controller.categories
                    .map<DropdownMenuItem<Category>>((Category value) {
                  return DropdownMenuItem<Category>(
                    value: value,
                    child: Text(
                      value.displayName,
                      style: CustomTextStyles.bodyMediumBlack,
                    ),
                  );
                }).toList(),
              ),
            ),
            controller.enableCategoryError.value
                ? Column(
                    children: [
                      const SizedBox(height: 8),
                      Text('필수 입력 항목입니다.',
                          style: CustomTextStyles.labelMediumRed),
                    ],
                  )
                : const SizedBox.shrink(),
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
                  text: "타입 ",
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
                  color: controller.enableTypeError.value
                      ? appTheme.alertNegative
                      : appTheme.grayScale3,
                ),
                color: controller.enableTypeError.value
                    ? appTheme.alertNegative.withOpacity(0.1)
                    : appTheme.white,
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: DropdownButton<ContentType>(
                  enableFeedback: controller.categorySelected.value,
                  hint: Text('Select Option',
                      style: CustomTextStyles.bodyMediumGray),
                  isExpanded: true,
                  value: controller.selectedType.value == ""
                      ? null
                      : controller.selectedType.value,
                  underline: Container(),
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 2, bottom: 2),
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  // icon: const Icon(Icons.),
                  elevation: 16,
                  onChanged: (ContentType? newValue) {
                    if (newValue != null) {
                      controller.selectedType.value = newValue;
                      controller.enableTypeError.value = false;
                    }
                  },
                  items: controller.categorySelected.value
                      ? controller.types[controller.selectedCategory.value]!
                          .map<DropdownMenuItem<ContentType>>(
                              (ContentType value) {
                          return DropdownMenuItem<ContentType>(
                            value: value,
                            child: Text(
                              value.displayName,
                              style: CustomTextStyles.bodyMediumBlack,
                            ),
                          );
                        }).toList()
                      : <ContentType>[].map<DropdownMenuItem<ContentType>>(
                          (ContentType value) {
                          return DropdownMenuItem<ContentType>(
                            value: value,
                            child: Text(
                              value.displayName,
                              style: CustomTextStyles.bodyMediumBlack,
                            ),
                          );
                        }).toList()),
            ),
            controller.enableTypeError.value
                ? Column(
                    children: [
                      const SizedBox(height: 8),
                      Text('필수 입력 항목입니다.',
                          style: CustomTextStyles.labelMediumRed),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
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
              text: "수준 ",
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
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: DropdownButton<ContentLevel>(
            hint: Text('Select Option', style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            // value: controller.selectedMaster.value == ""
            //     ? null
            //     : controller.selectedMaster.value,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentLevel? newValue) {
              // if (newValue != null) {
              //   controller.selectedMaster.value = newValue;
              // }
            },
            items: controller.contentLevel
                .map<DropdownMenuItem<ContentLevel>>((ContentLevel value) {
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
              text: "타겟 언어 ",
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
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: DropdownButton<ContentLanguage>(
            hint: Text('Select Option', style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            // value: controller.selectedMaster.value == ""
            //     ? null
            //     : controller.selectedMaster.value,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentLanguage? newValue) {
              // if (newValue != null) {
              //   controller.selectedMaster.value = newValue;
              // }
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

  Widget _enterMaster() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "마스터 ",
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
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: DropdownButton<String>(
            hint: Text('Select Option', style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value: controller.selectedMaster.value == ""
                ? null
                : controller.selectedMaster.value,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.selectedMaster.value = newValue;
              }
            },
            items: controller.masters
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

  Widget _buildExposured() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "노출 ",
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
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: DropdownButton<ContentExposured>(
            hint: Text('Select Option', style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value: null,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentExposured? newValue) {},
            items: controller.contentExposured
                .map<DropdownMenuItem<ContentExposured>>(
                    (ContentExposured value) {
              return DropdownMenuItem<ContentExposured>(
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

  Widget _buildTags() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "태그 ",
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: "*", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        Text('태그 입력 후 ‘+’ 버튼 또는 Enter로 태그를 등록해주세요.',
            style: CustomTextStyles.labelLargeGray),
        const SizedBox(height: 8),
        controller.tags.isEmpty ? const SizedBox.shrink() : buildChips(),
        CustomTextFormField(
            controller: controller.tagController,
            width: 730,
            hintText: "Input text",
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

  Widget buildChips() {
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

  Widget _enterIntro() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "소개 ",
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: "*", style: TextStyle(color: appTheme.red))
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
        Text("파일", style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildVideoOrSoundFile(),
            const SizedBox(width: 24),
            _buildThumnailFile(),
          ],
        ),
        const SizedBox(height: 24),
        _buildDubbing(),
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
          TextSpan(text: "더빙 ", style: CustomTextStyles.bodyMediumBlack),
        ])),
        const SizedBox(height: 24),
        Container(
          width: 353,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder12,
              border: Border.all(
                  color: controller.enableThumbnailError.value
                      ? appTheme.alertNegative
                      : appTheme.grayScale3),
              color: controller.enableThumbnailError.value
                  ? appTheme.alertNegative.withOpacity(0.1)
                  : appTheme.white),
          padding: const EdgeInsets.all(16),
          child: Wrap(
            runSpacing: 18,
            children: List.generate(controller.contentLanguage.length, (index) {
              return CustomCheckboxWidget(
                  isChecked: false,
                  label: controller.contentLanguage[index].displayName,
                  // label: "영어",
                  onChanged: (value) {});
            }),
          ),
        ),
        controller.enableThumbnailError.value
            ? Column(
                children: [
                  const SizedBox(height: 8),
                  Text('필수 입력 항목입니다.', style: CustomTextStyles.labelMediumRed),
                ],
              )
            : const SizedBox.shrink(),
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
          TextSpan(text: "썸네일 파일 ", style: CustomTextStyles.labelLargeBlack),
          TextSpan(text: "*", style: TextStyle(color: appTheme.red)),
        ])),
        const SizedBox(height: 8),
        Container(
          width: 353,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder12,
              border: Border.all(
                  color: controller.enableThumbnailError.value
                      ? appTheme.alertNegative
                      : appTheme.grayScale3),
              color: controller.enableThumbnailError.value
                  ? appTheme.alertNegative.withOpacity(0.1)
                  : appTheme.white),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 280,
                child: Text(
                  controller.thumbnailName == "".obs
                      ? '300 x 300 최대 10메가 (.jpg)'
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
                  controller.pickFile("thumbnail");
                },
              )
            ],
          ),
        ),
        controller.enableThumbnailError.value
            ? Column(
                children: [
                  const SizedBox(height: 8),
                  Text('필수 입력 항목입니다.', style: CustomTextStyles.labelMediumRed),
                ],
              )
            : const SizedBox.shrink(),
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
                      Text("미디어 파일", style: CustomTextStyles.labelLargeBlack),
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
                      Text("사운드 파일", style: CustomTextStyles.labelLargeBlack),
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
              border: Border.all(
                  color: controller.enableThumbnailError.value
                      ? appTheme.alertNegative
                      : appTheme.grayScale3),
              color: controller.enableThumbnailError.value
                  ? appTheme.alertNegative.withOpacity(0.1)
                  : appTheme.white),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 280,
                child: Text(
                  controller.thumbnailName == "".obs
                      ? '최대 2기가 (.mpeg)'
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
                  controller.pickFile("thumbnail");
                },
              )
            ],
          ),
        ),
        controller.enableThumbnailError.value
            ? Column(
                children: [
                  const SizedBox(height: 8),
                  Text('필수 입력 항목입니다.', style: CustomTextStyles.labelMediumRed),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget buildLastRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("파일", style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "미디어 파일 ",
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
              TextSpan(text: "*", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            Text('사전 등록 후 저장된 링크를 입력해주세요.',
                style: CustomTextStyles.labelLargeGray),
            const SizedBox(height: 8),
            CustomTextFormField(
                controller: controller.videoController,
                width: 730,
                validator: (value) {
                  if (controller.videoController.text == '') {
                    return "필수 입력 항목입니다.".tr;
                  }
                  return null;
                },
                contentPadding:
                    const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                filled: true),
          ],
        ),
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
                      text: "썸네일 파일 ", style: CustomTextStyles.labelLargeBlack),
                  TextSpan(text: "*", style: TextStyle(color: appTheme.red))
                ])),
                const SizedBox(height: 8),
                Container(
                  width: 353,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder12,
                      border: Border.all(
                          color: controller.enableThumbnailError.value
                              ? appTheme.alertNegative
                              : appTheme.grayScale3),
                      color: controller.enableThumbnailError.value
                          ? appTheme.alertNegative.withOpacity(0.1)
                          : appTheme.white),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 280,
                        child: Text(
                          controller.thumbnailName.value,
                          style: CustomTextStyles.bodyMediumBlack,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CustomImageView(
                        imagePath: IconConstant.upload,
                        onTap: () {
                          controller.pickFile("thumbnail");
                        },
                      )
                    ],
                  ),
                ),
                controller.enableThumbnailError.value
                    ? Column(
                        children: [
                          const SizedBox(height: 8),
                          Text('필수 입력 항목입니다.',
                              style: CustomTextStyles.labelMediumRed),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(
              width: 24,
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text("자막 파일 ", style: CustomTextStyles.labelLargeBlack),
            //     const SizedBox(height: 8),
            //     Container(
            //       width: 353,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadiusStyle.roundedBorder12,
            //           border: Border.all(color: appTheme.grayScale3),
            //           color: appTheme.white),
            //       padding: const EdgeInsets.all(16),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           SizedBox(
            //             width: 280,
            //             child: Text(
            //               controller.ccName.value,
            //               style: CustomTextStyles.bodyMediumBlack,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //           ),
            //           CustomImageView(
            //             imagePath: IconConstant.upload,
            //             onTap: () {
            //               controller.pickFile("cc");
            //             },
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ],
    );
  }
}

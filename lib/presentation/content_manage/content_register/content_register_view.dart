import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/category.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_register/content_register_controller.dart';

class ContentRegisterView extends GetWidget<ContentRegisterController> {
  const ContentRegisterView({super.key});

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
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TobBarSearch(
                                name: "콘텐츠 신규 등록",
                                searchShow: false,
                                viewCount: false,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  InkWell(
                                      child: Text(
                                        "콘텐츠 목록",
                                        style: CustomTextStyles
                                            .bodyMediumSkyBlue
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
                                          decorationColor: appTheme.skyBlue,
                                        ),
                                      ),
                                      onTap: () => Get.back()),
                                  CustomImageView(
                                    imagePath: IconConstant.arrowRight,
                                  ),
                                  Text('콘텐츠 신규 등록',
                                      style: CustomTextStyles.bodyMediumGray),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Text('기본 정보',
                                  style: CustomTextStyles.bodyMediumBlack),
                              const SizedBox(height: 24),
                              _enterTitle(),
                              const SizedBox(height: 24),
                              buildThirdRow(),
                              const SizedBox(height: 24),
                              _enterMaster(),
                              const SizedBox(height: 24),
                              _enterTags(),
                              const SizedBox(height: 24),
                              _enterIntro(),
                              const SizedBox(height: 32),
                              buildLastRow(),
                              const SizedBox(height: 32),
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
                                    onPressed: () => Get.back(),
                                  ),
                                ],
                              )
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
        ));
  }

  Widget _enterMaster() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('마스터', style: CustomTextStyles.labelLargeBlack),
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

  Widget _enterTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            hintText: "Input text",
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
                hint: Text(
                  'Select Option',
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
                      value.toString(),
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
              child: DropdownButton<String>(
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
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedType.value = newValue;
                      controller.enableTypeError.value = false;
                    }
                  },
                  items: controller.categorySelected.value
                      ? controller.types[controller.selectedCategory.value]!
                          .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: CustomTextStyles.bodyMediumBlack,
                            ),
                          );
                        }).toList()
                      : <String>[]
                          .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
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

  Widget _enterTags() {
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
        controller.tags == [] ? const SizedBox.shrink() : buildChips(),
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
        Text(
          '소개',
          style: CustomTextStyles.labelLargeBlack,
        ),
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
                  text: "동영상 파일 ",
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
                          controller.thumbnailName == "".obs
                              ? '파일 추가 혹은 여기로 드래그 (.jpg)'
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("자막 파일 ", style: CustomTextStyles.labelLargeBlack),
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
                          controller.ccName == "".obs
                              ? '파일 추가 혹은 여기로 드래그 (.srt)'
                              : controller.ccName.value,
                          style: controller.ccName == "".obs
                              ? CustomTextStyles.bodyMediumGray
                              : CustomTextStyles.bodyMediumBlack,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CustomImageView(
                        imagePath: IconConstant.upload,
                        onTap: () {
                          controller.pickFile("cc");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

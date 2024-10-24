import 'package:flutter/material.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_history_controller.dart';

class ActivityHistoryView extends GetWidget<ActivityHistoryController> {
  const ActivityHistoryView({super.key});

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
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TobBarSearch(
                                    name: "활동 기록 상세",
                                    searchShow: false,
                                    viewCount: false,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      InkWell(
                                        child: Text(
                                          "활동 기록 관리",
                                          style: CustomTextStyles
                                              .bodyMediumSkyBlue
                                              .copyWith(
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: appTheme.skyBlue,
                                          ),
                                        ),
                                        onTap: () => Get.back(),
                                      ),
                                      CustomImageView(
                                        imagePath: IconConstant.arrowRight,
                                      ),
                                      Text('활동 기록 상세',
                                          style:
                                              CustomTextStyles.bodyMediumGray),
                                    ],
                                  ),
                                  const SizedBox(height: 32),
                                  _buildFirstContainer(),
                                  const SizedBox(height: 16),
                                  controller.type == "practice"
                                      ? _buildPracticeContainer()
                                      : _buildChallengeContainer(),
                                  const SizedBox(height: 16),
                                  _buildThirdContainer(),
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
      ),
    );
  }

  Widget _buildFirstContainer() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder12,
          color: appTheme.white),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('회원 정보', style: CustomTextStyles.labelLargeBlack),
              InkWell(
                  onTap: controller.onMemberTap,
                  child: Text(
                    '상세',
                    style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: appTheme.skyBlue),
                  ))
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('이메일 주소', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.activityDetailsModel.email ?? "",
                      style: CustomTextStyles.labelLargeBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('사용자 이름', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.activityDetailsModel.username ?? "",
                      style: CustomTextStyles.labelLargeBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('가입일', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.registrationDate,
                      style: CustomTextStyles.labelLargeBlack),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPracticeContainer() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder12,
            color: appTheme.white),
        padding: const EdgeInsets.all(32),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('세션 정보', style: CustomTextStyles.labelLargeBlack),
                  InkWell(
                    onTap: controller.onPracticeTap,
                    child: Text(
                      '상세',
                      style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: appTheme.skyBlue),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text('회차', style: CustomTextStyles.labelLargeGray),
              const SizedBox(
                height: 16,
              ),
              Text(controller.activityDetailsModel.level ?? "",
                  style: CustomTextStyles.labelLargeBlack),
              const SizedBox(
                height: 24,
              ),
              Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
              const SizedBox(
                height: 24,
              ),
              Text('콘텐츠 등록', style: CustomTextStyles.labelLargeGray),
              const SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Category.body.toDisplayName(),
                          style: CustomTextStyles.labelLargeSkyBlue),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(Category.breath.toDisplayName(),
                          style: CustomTextStyles.labelLargeSkyBlue),
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.activityDetailsModel.body ?? "",
                          style: CustomTextStyles.labelLargeBlack),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(controller.activityDetailsModel.breath ?? "",
                          style: CustomTextStyles.labelLargeBlack),
                    ],
                  )
                ],
              )
            ]));
  }

  Widget _buildChallengeContainer() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder12,
            color: appTheme.white),
        padding: const EdgeInsets.all(32),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('세션 정보', style: CustomTextStyles.labelLargeBlack),
                  InkWell(
                    onTap: controller.onChallengeTap,
                    child: Text(
                      '상세',
                      style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: appTheme.skyBlue),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text('제목', style: CustomTextStyles.labelLargeGray),
              const SizedBox(
                height: 16,
              ),
              Text(controller.activityDetailsModel.title ?? "",
                  style: CustomTextStyles.labelLargeBlack),
              const SizedBox(
                height: 24,
              ),
              Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
              const SizedBox(
                height: 24,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('목적', style: CustomTextStyles.labelLargeGray),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(controller.activityDetailsModel.goal ?? "",
                          style: CustomTextStyles.labelLargeBlack),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('기간', style: CustomTextStyles.labelLargeGray),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(controller.activityDetailsModel.days ?? "",
                          style: CustomTextStyles.labelLargeBlack),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
              const SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('소개', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                      width: 698,
                      child: Text(controller.activityDetailsModel.intro ?? "",
                          maxLines: null,
                          overflow: TextOverflow.visible,
                          style: CustomTextStyles.labelLargeBlack)),
                ],
              ),
            ]));
  }

  Widget _buildThirdContainer() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder12,
          color: appTheme.white),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('기록 정보', style: CustomTextStyles.labelLargeBlack),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('유형', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.activityDetailsModel.type ?? "",
                      style: CustomTextStyles.labelLargeBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      controller.type == "practice"
                          ? '변화된 감정 (기록 1)'
                          : '난이도 (기록 1)',
                      style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.activityDetailsModel.recordOne ?? "",
                      style: CustomTextStyles.labelLargeBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      controller.type == "practice"
                          ? '변화 요인 (기록 2)'
                          : '만족도 (기록 2)',
                      style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.activityDetailsModel.recordTwo ?? "",
                      style: CustomTextStyles.labelLargeBlack),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  color: appTheme.background),
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('세션 시작', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                      height: 14,
                      width: 1,
                      decoration: BoxDecoration(color: appTheme.grayScale3)),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(controller.sessionStartDate,
                      style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    width: 32,
                  ),
                  Text('세션 완료', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                      height: 14,
                      width: 1,
                      decoration: BoxDecoration(color: appTheme.grayScale3)),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(controller.sessionEndDate,
                      style: CustomTextStyles.labelLargeGray),
                ],
              )),
          const SizedBox(
            height: 24,
          ),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(
            height: 24,
          ),
          Text('챗봇 기록', style: CustomTextStyles.labelLargeGray),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            child: Text(
              controller.chatBot! ? '있음' : '없음',
              style: controller.chatBot!
                  ? CustomTextStyles.labelLargeSkyBlue.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: appTheme.skyBlue)
                  : CustomTextStyles.labelLargeBlack,
            ),
            onTap: () async {
              if (controller.chatBot!) {
                await controller.onChat();
                _buildChatModal();
              }
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('전문가 피드백', style: CustomTextStyles.labelLargeGray),
              controller.feedback.value
                  ? const SizedBox.shrink()
                  : InkWell(
                      child: Text(
                        '작성',
                        style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: appTheme.skyBlue),
                      ),
                      onTap: () {
                        _buildFeedbackModal();
                      },
                    ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          controller.feedback.value
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 698,
                      child: Text(
                          controller.activityDetailsModel.expertMessage ?? "",
                          maxLines: null,
                          overflow: TextOverflow.visible,
                          style: CustomTextStyles.labelLargeBlack),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder12,
                            color: appTheme.background),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('등록', style: CustomTextStyles.labelLargeGray),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                                height: 14,
                                width: 1,
                                decoration:
                                    BoxDecoration(color: appTheme.grayScale3)),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(controller.expertMessageDate,
                                style: CustomTextStyles.labelLargeGray),
                          ],
                        )),
                  ],
                )
              : Text('없음', style: CustomTextStyles.labelLargeBlack)
        ],
      ),
    );
  }

  Future<dynamic> _buildFeedbackModal() {
    return Get.defaultDialog(
        title: '',
        backgroundColor: appTheme.background,
        radius: 12,
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder12,
              color: appTheme.background),
          width: 794,
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '전문가 피드백 작성',
                    style: CustomTextStyles.bodyLargeBlack,
                  ),
                  CustomImageView(
                    imagePath: IconConstant.close,
                    onTap: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              CustomTextFormField(
                width: 730,
                controller: controller.feedbackController,
                hintText: "Input Text".tr,
                contentPadding: const EdgeInsets.all(16),
                maxLines: 6,
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    text: '저장',
                    buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    width: 90,
                    height: 44,
                    onPressed: () => controller.onFeedback(),
                  ),
                  CustomElevatedButton(
                    text: '취소',
                    buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
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
        ));
  }

  Future<dynamic> _buildChatModal() {
    return Get.defaultDialog(
      title: '',
      backgroundColor: appTheme.background,
      radius: 12,
      content: Expanded(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadiusStyle.roundedBorder12,
                color: appTheme.background),
            width: 762,
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '챗봇 기록',
                      style: CustomTextStyles.bodyLargeBlack,
                    ),
                    CustomImageView(
                      imagePath: IconConstant.close,
                      onTap: () => Get.back(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  '2024-03-13-10:09:34',
                  style: CustomTextStyles.bodyLargeGray,
                ),
                const SizedBox(
                  height: 32,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(controller.activityChatModel.length,
                      (index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 80,
                                child: Text(
                                  controller.activityChatModel.chatlog![index]
                                          .role ??
                                      "",
                                  style: CustomTextStyles.labelLargeGray,
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              width: 560,
                              child: Text(
                                controller.activityChatModel.chatlog![index]
                                        .content ??
                                    "",
                                maxLines: null,
                                overflow: TextOverflow.visible,
                                style: CustomTextStyles.bodyMediumBlack
                                    .copyWith(height: 2.0),
                                textHeightBehavior: const TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder12,
                      color: appTheme.white),
                  width: 698,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '대화 평가',
                        style: CustomTextStyles.labelLargeGray,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        controller.activityChatModel.reaction == "DISLIKED"
                            ? "불만족"
                            : controller.activityChatModel.reaction == "LIKED"
                                ? "만족"
                                : "없음",
                        style: CustomTextStyles.labelLargeBlack,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

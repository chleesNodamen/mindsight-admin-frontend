import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_history_controller.dart';

class ActivityHistoryView extends GetWidget<ActivityHistoryController> {
  const ActivityHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageLoadingIndicator(
        isLoading: controller.isLoading.value,
        child: controller.isInited.value ? ResponsiveWidget(
          largeScreen: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SideMenu(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(48.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const TobBarSearch(
                              name: "활동 기록 상세",
                              searchShow: false,
                              viewCount: false,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                GestureDetector(
                                  child: Text(
                                    "활동 기록 관리",
                                    style: CustomTextStyles.bodyMediumSkyBlue
                                        .copyWith(
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                      decorationColor: appTheme.skyBlue,
                                    ),
                                  ),
                                  onTap: () => Get.back(),
                                ),
                                CustomImageView(
                                  imagePath: IconConstant.arrowRight,
                                ),
                                Text('활동 기록 상세',
                                    style: CustomTextStyles.bodyMediumGray),
                              ],
                            ),
                            const SizedBox(height: 32),
                            _buildFirstContainer(),
                            const SizedBox(height: 16),
                            controller.type == Type.practice
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
              ),
            ],
          ),
        ) : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildFirstContainer() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: appTheme.white),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('회원 정보', style: CustomTextStyles.labelLargeBlack),
              GestureDetector(
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
                  Text('akdlsemtkdlxm@nodamen.com',
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
                  Text('dbwjspdla', style: CustomTextStyles.labelLargeBlack),
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
                  Text('2024-04-25', style: CustomTextStyles.labelLargeBlack),
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
            borderRadius: BorderRadius.circular(12), color: appTheme.white),
        padding: const EdgeInsets.all(32),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('세션 정보', style: CustomTextStyles.labelLargeBlack),
                  GestureDetector(
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
              Text('36회차', style: CustomTextStyles.labelLargeBlack),
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
                      Text('Body', style: CustomTextStyles.labelLargeSkyBlue),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('Breath', style: CustomTextStyles.labelLargeSkyBlue),
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sunrise 10-Minute Morning Yoga A',
                          style: CustomTextStyles.labelLargeBlack),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('Sunrise 10-Minute Morning Yoga B',
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
            borderRadius: BorderRadius.circular(12), color: appTheme.white),
        padding: const EdgeInsets.all(32),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('세션 정보', style: CustomTextStyles.labelLargeBlack),
                  GestureDetector(
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
              Text('30-Day Challenge to Strengthen Your Legs',
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
                      Text('Improve health',
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
                      Text('30일', style: CustomTextStyles.labelLargeBlack),
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
                      child: Text(
                          'This is a 30-Day challenge to Strengthen your legs.Strengthen your legs will increase muscle mass throughout the body, which helps boost metabolism such as breathing and blood circulation.',
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
          borderRadius: BorderRadius.circular(12), color: appTheme.white),
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
                  Text('Practice plan',
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
                      controller.type == Type.practice
                          ? '변화된 감정 (기록 1)'
                          : '난이도 (기록 1)',
                      style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Stressed', style: CustomTextStyles.labelLargeBlack),
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
                      controller.type == Type.practice
                          ? '변화 요인 (기록 2)'
                          : '만족도 (기록 2)',
                      style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Feeling fatigued, Distracted mind',
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
                  borderRadius: BorderRadius.circular(12),
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
                  Text('2024-03-13-10:09:34',
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
                  Text('2024-03-13-10:26:12',
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
          GestureDetector(
            child: Text(
              controller.chatBot ? '있음' : '없음',
              style: controller.chatBot
                  ? CustomTextStyles.labelLargeSkyBlue.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: appTheme.skyBlue)
                  : CustomTextStyles.labelLargeBlack,
            ),
            onTap: () {
              if (controller.chatBot) {
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
          Text('전문가 피드백', style: CustomTextStyles.labelLargeGray),
          const SizedBox(
            height: 16,
          ),
          controller.chatBot
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 698,
                      child: Text(
                          'You are shining a bit brighter now! We\'re so happy to see the positive changes in your mood! Let\'s keep this beautiful journey and uncover even more wonderful insights.',
                          maxLines: null,
                          overflow: TextOverflow.visible,
                          style: CustomTextStyles.labelLargeBlack),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
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
                            Text('2024-03-17-10:09:34',
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

  Widget _buildChatModal() {
    return Container();
  }
}

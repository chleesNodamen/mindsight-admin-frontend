import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_details_controller.dart';

class MemberDetailsView extends GetWidget<MemberDetailsController> {
  const MemberDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            margin: const EdgeInsets.all(48.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const TobBarSearch(
                                  name: "회원 상세",
                                  searchShow: false,
                                  viewCount: false,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    GestureDetector(
                                      child: Text(
                                        "회원 목록",
                                        style: CustomTextStyles
                                            .bodyMediumSkyBlue
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
                                    Text('회원 상세',
                                        style: CustomTextStyles.bodyMediumGray),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                _buildFirstContainer(),
                                const SizedBox(height: 16),
                                _buildSecondContainer()
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
                  onTap: controller.onMemberEdit,
                  child: Text(
                    '사전 정보 수정',
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
                  Text('소속', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Nodamen', style: CustomTextStyles.labelLargeBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('부서', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Product Biz Dept.',
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
                  Text('직책 또는 직급', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Team leader', style: CustomTextStyles.labelLargeBlack),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('이름 (First name)',
                      style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Aiden', style: CustomTextStyles.labelLargeBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('성 (Last name)', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Kim', style: CustomTextStyles.labelLargeBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('성별', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Male', style: CustomTextStyles.labelLargeBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('태어난 연도', style: CustomTextStyles.labelLargeGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('1992', style: CustomTextStyles.labelLargeBlack),
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
              ),
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
                Text('최근 활동', style: CustomTextStyles.labelLargeGray),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondContainer() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: appTheme.white),
        padding: const EdgeInsets.all(32),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('활동 정보', style: CustomTextStyles.labelLargeBlack),
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
                      Text('34', style: CustomTextStyles.headlineLargeBlack),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('완료한 세션 수', style: CustomTextStyles.labelLargeGray),
                    ],
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('421', style: CustomTextStyles.headlineLargeBlack),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('누적 명상 시간', style: CustomTextStyles.labelLargeGray),
                    ],
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('16', style: CustomTextStyles.headlineLargeBlack),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('연속 명상 일 수', style: CustomTextStyles.labelLargeGray),
                    ],
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('421', style: CustomTextStyles.headlineLargeBlack),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('누적 명상 일 수', style: CustomTextStyles.labelLargeGray),
                    ],
                  ),
                ],
              ),
            ]));
  }
}

import 'package:mindsight_admin_page/app_export.dart';

import 'package:mindsight_admin_page/presentation/content_manage/challenge_manage_details/challenge_details_controller.dart';

class ChallengeDetailsView extends GetWidget<ChallengeDetailsController> {
  const ChallengeDetailsView({super.key});

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
                          margin: const EdgeInsets.all(48.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                buildTopBar(),
                                const SizedBox(height: 32),
                                buildSubHeader(),
                                const SizedBox(height: 32),
                                buildFirstContainer(),
                                const SizedBox(height: 16),
                                buildSecondContainer(),
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

  Container buildSecondContainer() {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      // height: 340,
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("사용자 데이터", style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("2,418", style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("누적 참여 회원 수", style: CustomTextStyles.labelLargeGray)
                ],
              ),
              Column(
                children: [
                  Text("594", style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("참여 회원 수", style: CustomTextStyles.labelLargeGray)
                ],
              ),
              Column(
                children: [
                  Text("1,824", style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("완료 회원 수", style: CustomTextStyles.labelLargeGray)
                ],
              ),
              Column(
                children: [
                  Text("821", style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("좋아요 수", style: CustomTextStyles.labelLargeGray)
                ],
              ),
              Column(
                children: [
                  Text("4.25", style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("별점", style: CustomTextStyles.labelLargeGray)
                ],
              ),
              const SizedBox(width: 32),
            ],
          )
        ],
      ),
    );
  }

  Widget buildFirstContainer() {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      // height: 340,
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("기본 정보",
                  style: CustomTextStyles.labelLargeBlack
                      .copyWith(fontWeight: FontWeight.w600)),
              GestureDetector(
                onTap: controller.goToEdit,
                child: Text("수정",
                    style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: appTheme.skyBlue)),
              )
            ],
          ),
          const SizedBox(height: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('제목',
                  style: CustomTextStyles.labelMediumGray
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Text("30-Day Challenge to Strengthen Your Legs",
                  style: CustomTextStyles.bodyMediumBlack),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('목적', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text("Improve health",
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('기간', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text("30일", style: CustomTextStyles.bodyMediumBlack),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('소개', style: CustomTextStyles.labelMediumGray),
              const SizedBox(height: 16),
              Text(
                  "This is a 30-Day challenge to Strengthen your legs.Strengthen your legs will increase muscle mass throughout the body, which helps boost metabolism such as breathing and blood circulation.",
                  style: CustomTextStyles.bodyMediumBlack),
            ],
          ),
          const SizedBox(height: 24),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(
            height: 24,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Day 세션', style: CustomTextStyles.labelMediumBlack),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8.0, // Horizontal spacing
                runSpacing: 8.0, // Vertical spacing
                children: _buildNumberWidgets(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(height: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('제목',
                  style: CustomTextStyles.labelMediumGray
                      .copyWith(fontWeight: FontWeight.w500)),
              const SizedBox(height: 16),
              Text("Warming Up",
                  style: CustomTextStyles.bodyMediumBlack
                      .copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('콘텐츠',
                  style: CustomTextStyles.labelMediumGray
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text('1', style: CustomTextStyles.bodyMediumSkyBlue),
                  const SizedBox(width: 16),
                  Text(
                    "Sunrise 10-Minute Morning Yoga A",
                    style: CustomTextStyles.bodyMediumBlack
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('2', style: CustomTextStyles.bodyMediumSkyBlue),
                  const SizedBox(width: 16),
                  Text(
                    "Sunrise 10-Minute Morning Yoga B",
                    style: CustomTextStyles.bodyMediumBlack
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('3', style: CustomTextStyles.bodyMediumSkyBlue),
                  const SizedBox(width: 16),
                  Text(
                    "Sunrise 10-Minute Morning Yoga C",
                    style: CustomTextStyles.bodyMediumBlack
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(height: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("파일", style: CustomTextStyles.labelLargeBlack),
              const SizedBox(height: 24),
              Text('썸네일 파일', style: CustomTextStyles.labelLargeGray),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text("이미지 보기",
                      style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: appTheme.skyBlue)),
                  const SizedBox(width: 4),
                  CustomImageView(
                    imagePath: IconConstant.download,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNumberWidgets() {
    List<Widget> widgets = [];
    for (int i = 0; i < controller.numbers.length; i++) {
      if (i > 0 && i % 14 == 0) {
        widgets.add(SizedBox(width: double.infinity)); // Line break
      }
      widgets.add(
        Container(
          width: 33,
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: controller.numbers[i] == 1
                ? appTheme.skyBlue
                : appTheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            controller.numbers[i].toString(),
            style: controller.numbers[i] == 1
                ? CustomTextStyles.labelMediumWhite
                : CustomTextStyles.labelMediumBlack,
          ),
        ),
      );
    }
    return widgets;
  }

  Row buildSubHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Text("Challenge 관리",
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
        Text("Challenge 상세", style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch buildTopBar() {
    return TobBarSearch(
      name: "Challenge 상세",
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}

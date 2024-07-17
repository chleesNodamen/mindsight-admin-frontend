import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_details/practice_details_controller.dart';

class PracticeDetailsView extends GetWidget<PracticeDetailsController> {
  const PracticeDetailsView({super.key});

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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildTopBar(),
                              const SizedBox(height: 32),
                              buildSubHeader(),
                              const SizedBox(height: 32),
                              buildContainers()
                            ],
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

  Column buildContainers() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFirstContainer(),
        const SizedBox(height: 24),
        buildSecondContainer(),
      ],
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

  Container buildFirstContainer() {
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
              Text('회차', style: CustomTextStyles.labelLargeGray),
              GestureDetector(
                onTap: controller.onPracticeTap,
                child: Text(
                  '수정',
                  style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: appTheme.skyBlue),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          // Text(controller.activityDetailsModel.level ?? "",
          //     style: CustomTextStyles.labelLargeBlack),
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
                  // Text(controller.activityDetailsModel.body ?? "",
                  //     style: CustomTextStyles.labelLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  // Text(controller.activityDetailsModel.breath ?? "",
                  //     style: CustomTextStyles.labelLargeBlack),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Row buildSubHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Text("Practice plan 관리",
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
        Text("Practice plan 상세", style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch buildTopBar() {
    return TobBarSearch(
      name: "Practice plan 상세",
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}

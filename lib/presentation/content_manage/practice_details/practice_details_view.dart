import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_details/practice_details_controller.dart';

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
                          margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildTitle(),
                              const SizedBox(height: 32),
                              _buildSubMenu(),
                              const SizedBox(height: 32),
                              _buildInfo(),
                              const SizedBox(height: 24),
                              _buildData()
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

  Container _buildData() {
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
          Text("사용자 데이터".tr, style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 24),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.practiceDetailsModel.finished.toString(),
                      style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("완료 회원 수".tr, style: CustomTextStyles.labelLargeGray)
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.practiceDetailsModel.participated.toString(),
                      style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("참여 회원 수".tr, style: CustomTextStyles.labelLargeGray)
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.practiceDetailsModel.ratio!,
                      style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("완료율".tr, style: CustomTextStyles.labelLargeGray)
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.practiceDetailsModel.liked.toString(),
                      style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("좋아요 수".tr, style: CustomTextStyles.labelLargeGray)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _buildInfo() {
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
              Text('콘텐츠 등록'.tr, style: CustomTextStyles.labelLargeGray),
              InkWell(
                onTap: controller.onPracticeTap,
                child: Text(
                  '수정'.tr,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ContentCategory.body.displayName,
                      style: CustomTextStyles.bodyMediumSkyBlue),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(ContentCategory.breath.displayName,
                      style: CustomTextStyles.bodyMediumSkyBlue),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.practiceDetailsModel.body!,
                      style: CustomTextStyles.bodyMediumBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.practiceDetailsModel.breath!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              )
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('마스터'.tr, style: CustomTextStyles.labelLargeGray),
                  const SizedBox(height: 16),
                  Text(controller.practiceDetailsModel.masterNickname!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('승인 상태'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentStatus.fromKeyword(
                              controller.practiceDetailsModel.status!)
                          .displayName,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('노출 상태'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentExposure.fromKeyword(
                              controller.practiceDetailsModel.exposure!)
                          .displayName,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
          onTap: controller.goToPractice,
          child: Text("Practice plan 관리".tr,
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
        Text("Practice plan 상세".tr, style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Practice plan 상세".tr,
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}

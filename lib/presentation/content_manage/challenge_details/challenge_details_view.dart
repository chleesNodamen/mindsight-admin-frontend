import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/goal.dart';
import 'package:mindsight_admin_page/presentation/content_manage/challenge_details/challenge_details_controller.dart';
import 'package:mindsight_admin_page/widgets/image_actions_widget.dart';

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
                          margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _buildTitle(),
                                const SizedBox(height: 32),
                                _buildSubMenu(),
                                const SizedBox(height: 32),
                                _buildInfo(),
                                const SizedBox(height: 16),
                                _buildUserData(),
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

  Container _buildUserData() {
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
          Text("User data".tr, style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                      controller.challengeDetailsModel.participants!.toString(),
                      style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("Total members".tr,
                      style: CustomTextStyles.labelLargeGray)
                ],
              ),
              Column(
                children: [
                  Text(controller.challengeDetailsModel.challengers!.toString(),
                      style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("Participating members".tr,
                      style: CustomTextStyles.labelLargeGray)
                ],
              ),
              Column(
                children: [
                  Text(controller.challengeDetailsModel.completed!.toString(),
                      style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("Completed members".tr,
                      style: CustomTextStyles.labelLargeGray)
                ],
              ),
              // Column(
              //   children: [
              //     Text("821", style: CustomTextStyles.headlineLargeBlack),
              //     const SizedBox(
              //       height: 16,
              //     ),
              //     Text("Likes", style: CustomTextStyles.labelLargeGray)
              //   ],
              // ),
              Column(
                children: [
                  Text(controller.challengeDetailsModel.rating!.toString(),
                      style: CustomTextStyles.headlineLargeBlack),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("Rating".tr, style: CustomTextStyles.labelLargeGray)
                ],
              ),
              const SizedBox(width: 32),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfo() {
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
              Text("Basic info".tr, style: CustomTextStyles.labelLargeBlack),
              InkWell(
                onTap: controller.onEdit,
                child: Text("Edit".tr,
                    style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: appTheme.skyBlue)),
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.challengeDetailsModel.name!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Master'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text("${controller.challengeDetailsModel.masterNickname}",
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Approval'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentStatus.fromKeyword(
                              controller.challengeDetailsModel.status!)
                          .displayName
                          .tr,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Exposure Status'.tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      ContentExposure.fromKeyword(
                              controller.challengeDetailsModel.exposure!)
                          .displayName
                          .tr,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Purpose'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      Goal.fromKeyword(controller.challengeDetailsModel.goal!)
                          .displayName
                          .tr,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Period'.tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(
                      "${controller.challengeDetailsModel.duration!.toString()}일",
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Introduction'.tr, style: CustomTextStyles.labelMediumGray),
              const SizedBox(height: 16),
              Text(controller.challengeDetailsModel.intro!,
                  style: CustomTextStyles.bodyMediumBlack),
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Day session'.tr, style: CustomTextStyles.labelLargeBlack),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8.0, // Horizontal spacing
                runSpacing: 8.0, // Vertical spacing
                children: _buildNumberWidgets(),
              ),
            ],
          ),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          _buildDayContent(),
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("File".tr, style: CustomTextStyles.labelLargeBlack),
              const SizedBox(height: 24),
              Text('Thumbnail file'.tr, style: CustomTextStyles.labelLargeGray),
              const SizedBox(height: 16),
              ImageActionsWidget(
                  imageUrl: controller.challengeDetailsModel.thumbnail!)
              // Row(
              //   children: [
              //     InkWell(
              //       child: Text(
              //         "View image",
              //         style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
              //             decoration: TextDecoration.underline,
              //             decorationColor: appTheme.skyBlue),
              //       ),
              //       onTap: () => launchUrl(
              //           Uri.parse(controller.challengeDetailsModel.thumbnail!)),
              //     ),
              //     const SizedBox(width: 4),
              //     CustomImageView(
              //       onTap: () => SwitchNativeWeb.downloadFile(
              //           url: controller.challengeDetailsModel.thumbnail ?? "",
              //           fileName: "download.jpg",
              //           dataType: "data:image/jpg"),
              //       imagePath: IconConstant.download,
              //     )
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNumberWidgets() {
    List<Widget> widgets = [];
    for (int i = 0; i < controller.challengeDetailsModel.days!.length; i++) {
      if (i > 0 && i % 14 == 0) {
        widgets.add(const SizedBox(width: double.infinity)); // Line break
      }
      int day = controller.challengeDetailsModel.days![i].day!;

      widgets.add(
        InkWell(
          onTap: () => controller.updateSelectedDay(day),
          child: Container(
            width: 33,
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
              color: controller.selectedDay.value == day
                  ? appTheme.skyBlue
                  : appTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadiusStyle.roundedBorder6,
            ),
            alignment: Alignment.center,
            child: Text(
              day.toString(),
              style: controller.selectedDay.value == day
                  ? CustomTextStyles.labelMediumWhite
                  : CustomTextStyles.labelMediumBlack,
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  Widget _buildDayContent() {
    int selectedIndex = controller.selectedDay.value - 1;

    // Safely get the selected day details using indexing
    if (selectedIndex < 0 ||
        selectedIndex >= controller.challengeDetailsModel.days!.length) {
      return const SizedBox();
    }

    var selectedDayDetails =
        controller.challengeDetailsModel.days![selectedIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Title'.tr,
            style: CustomTextStyles.labelMediumGray
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        Text(selectedDayDetails.name ?? '',
            style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Text('Content'.tr, style: CustomTextStyles.labelMediumGray),
        const SizedBox(height: 16),
        Column(
          children: selectedDayDetails.contentNames!.map((content) {
            int index = selectedDayDetails.contentNames!.indexOf(content) + 1;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text('$index', style: CustomTextStyles.bodyMediumSkyBlue),
                  const SizedBox(width: 16),
                  Text(
                    content,
                    style: CustomTextStyles.bodyMediumBlack
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
          onTap: () => Get.offAllNamed(AppRoutes.contentChallengeManage),
          child: Text("Challenge management".tr,
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
        Text("Challenge Detail".tr, style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Challenge Detail".tr,
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}

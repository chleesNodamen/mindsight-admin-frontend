import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/gender.dart';

class MemberDetailsView extends GetWidget<MemberDetailsController> {
  const MemberDetailsView({super.key});

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
                                  _buildTitle(),
                                  const SizedBox(height: 16),
                                  _buildSubMenu(),
                                  const SizedBox(height: 32),
                                  _buildMemberInfo(),
                                  const SizedBox(height: 16),
                                  _buildActivityInfo()
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

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
          child: Text(
            "Member list".tr,
            style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: appTheme.skyBlue,
            ),
          ),
          onTap: () {
            controller.onMemberList();
          },
        ),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text("Member details".tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Member details".tr,
      searchShow: false,
      viewCount: false,
    );
  }

  Widget _buildMemberInfo() {
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
              Text("Member info".tr, style: CustomTextStyles.labelLargeBlack),
              InkWell(
                  onTap: controller.onMemberEdit,
                  child: Text(
                    "Edit".tr,
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
                  Text("소속".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      (controller.membersDataModel.affiliation == null ||
                              controller.membersDataModel.affiliation == "")
                          ? controller.dash
                          : controller.membersDataModel.affiliation!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("부서".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      (controller.membersDataModel.department == null ||
                              controller.membersDataModel.department == "")
                          ? controller.dash
                          : controller.membersDataModel.department!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("직책 또는 직급".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      (controller.membersDataModel.position == null ||
                              controller.membersDataModel.position == "")
                          ? controller.dash
                          : controller.membersDataModel.position!,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Name (First name)".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      (controller.membersDataModel.firstName == null ||
                              controller.membersDataModel.firstName == "")
                          ? controller.dash
                          : controller.membersDataModel.firstName!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("성 (Last name)".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(controller.lastName.value,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("성별".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      "${Gender.fromKeyword(controller.membersDataModel.gender)?.displayName.tr}",
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("태어난 Year".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      "${controller.membersDataModel.yearOfBirth ?? controller.dash}",
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Email address".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      (controller.membersDataModel.email == null ||
                              controller.membersDataModel.email == "")
                          ? controller.dash
                          : controller.membersDataModel.email!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Nickname".tr, style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      (controller.membersDataModel.username == null ||
                              controller.membersDataModel.username == "")
                          ? controller.dash
                          : controller.membersDataModel.username!,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Signup date".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      controller.membersDataModel.createdAt != null
                          ? DateFormat("yyyy-MM-dd")
                              .format(controller.membersDataModel.createdAt!)
                          : controller.dash,
                      style: CustomTextStyles.bodyMediumBlack),
                ],
              ),
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
                Text("Recent activity".tr,
                    style: CustomTextStyles.labelLargeGray),
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
                Text(
                    controller.membersDataModel.lastLogin != null
                        ? DateFormat("yyyy-MM-dd-HH:mm:ss")
                            .format(controller.membersDataModel.lastLogin!)
                        : controller.dash,
                    style: CustomTextStyles.labelLargeGray),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityInfo() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder12,
            color: appTheme.white),
        padding: const EdgeInsets.all(32),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Activity info".tr, style: CustomTextStyles.labelLargeBlack),
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
                      Text(
                          controller.membersDataModel.sessionsCompleted == null
                              ? controller.dash
                              : controller.membersDataModel.sessionsCompleted
                                  .toString(),
                          style: CustomTextStyles.headlineLargeBlack),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("Completed sessions".tr,
                          style: CustomTextStyles.labelLargeGray),
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
                          controller.membersDataModel.minutesMeditated == null
                              ? controller.dash
                              : controller.membersDataModel.minutesMeditated
                                  .toString(),
                          style: CustomTextStyles.headlineLargeBlack),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("Total meditation time".tr,
                          style: CustomTextStyles.labelLargeGray),
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
                          controller.membersDataModel.mindfulStreak == null
                              ? controller.dash
                              : controller.membersDataModel.mindfulStreak
                                  .toString(),
                          style: CustomTextStyles.headlineLargeBlack),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("Consecutive meditation days".tr,
                          style: CustomTextStyles.labelLargeGray),
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
                          controller.membersDataModel.mindfulDays == null
                              ? controller.dash
                              : controller.membersDataModel.mindfulDays
                                  .toString(),
                          style: CustomTextStyles.headlineLargeBlack),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("Total meditation days".tr,
                          style: CustomTextStyles.labelLargeGray),
                    ],
                  ),
                ],
              ),
            ]));
  }
}

import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/gender.dart';

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
                                  TobBarSearch(
                                    name: "회원 상세",
                                    searchShow: false,
                                    viewCount: false,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      InkWell(
                                        child: Text(
                                          "회원 목록",
                                          style: CustomTextStyles
                                              .bodyMediumSkyBlue
                                              .copyWith(
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline,
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
                                      Text('회원 상세',
                                          style:
                                              CustomTextStyles.bodyMediumGray),
                                    ],
                                  ),
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
              Text('회원 정보', style: CustomTextStyles.labelLargeBlack),
              InkWell(
                  onTap: controller.onMemberEdit,
                  child: Text(
                    '수정',
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
                  Text('소속', style: CustomTextStyles.labelMediumGray),
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
                  Text('부서', style: CustomTextStyles.labelMediumGray),
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
                  Text('직책 또는 직급', style: CustomTextStyles.labelMediumGray),
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
                  Text('이름 (First name)',
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
                  Text('성 (Last name)',
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
                  Text('성별', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      "${Gender.fromKeyword(controller.membersDataModel.gender)?.displayName}",
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
                  Text('태어난 연도', style: CustomTextStyles.labelMediumGray),
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
                  Text('이메일 주소', style: CustomTextStyles.labelMediumGray),
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
                  Text('사용자 이름', style: CustomTextStyles.labelMediumGray),
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
                  Text('가입일', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      controller.membersDataModel.createdAt != null
                          ? DateFormat('yyyy-MM-dd')
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
                Text(
                    controller.membersDataModel.lastLogin != null
                        ? DateFormat('yyyy-MM-dd-HH:mm:ss')
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
                      Text(
                          controller.membersDataModel.sessionsCompleted == null
                              ? controller.dash
                              : controller.membersDataModel.sessionsCompleted
                                  .toString(),
                          style: CustomTextStyles.headlineLargeBlack),
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
                      Text(
                          controller.membersDataModel.minutesMeditated == null
                              ? controller.dash
                              : controller.membersDataModel.minutesMeditated
                                  .toString(),
                          style: CustomTextStyles.headlineLargeBlack),
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
                      Text(
                          controller.membersDataModel.mindfulStreak == null
                              ? controller.dash
                              : controller.membersDataModel.mindfulStreak
                                  .toString(),
                          style: CustomTextStyles.headlineLargeBlack),
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
                      Text(
                          controller.membersDataModel.mindfulDays == null
                              ? controller.dash
                              : controller.membersDataModel.mindfulDays
                                  .toString(),
                          style: CustomTextStyles.headlineLargeBlack),
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

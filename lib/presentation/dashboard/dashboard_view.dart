import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/account_constant.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard_controller.dart';
import 'package:intl/intl.dart';

class MembersData {
  MembersData(this.registrationState, this.number, this.color);
  final String registrationState;
  final double number;
  final Color color;
}

class DashboardView extends GetWidget<DashboardController> {
  const DashboardView({super.key});

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
                            Account.isAdmin
                                ? _buildAdminDashboard()
                                : _buildMasterDashboard(),
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

  Container _buildMasterDashboard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("마스터 대시보드", style: CustomTextStyles.headlineLargeBlack),
        ],
      ),
    );
  }

  Container _buildAdminDashboard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("대시보드", style: CustomTextStyles.headlineLargeBlack),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: [
              Expanded(flex: 1, child: _buildYesterdayLoggedInMembersNumber()),
              const SizedBox(
                width: 16,
              ),
              Expanded(flex: 1, child: _buildLast7DaysEventNumber()),
              const SizedBox(
                width: 16,
              ),
              Expanded(flex: 1, child: _buildLast7DaysReturningMembersNumber()),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(flex: 1, child: _buildMembersGraph()),
              const SizedBox(
                width: 16,
              ),
              Expanded(flex: 2, child: _buildPracticePlanCompletionRate()),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(flex: 1, child: _buildPopularChallenge()),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget _buildYesterdayLoggedInMembersNumber() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder12,
            color: appTheme.white),
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '어제 접속 회원 수',
                  style: CustomTextStyles.labelLargeGray,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '2.3천',
                  style: CustomTextStyles.headlineLargeBlack,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                      color: appTheme.alertNegative.withOpacity(0.1)),
                  child: Text('-6.5%', style: CustomTextStyles.labelLargeRed),
                ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                  child: Row(
                children: [
                  Text(
                    'Google Analytics',
                    style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: appTheme.skyBlue,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CustomImageView(
                    imagePath: IconConstant.newTab,
                  )
                ],
              )),
            ),
          ],
        ));
  }

  Widget _buildLast7DaysEventNumber() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder12,
            color: appTheme.white),
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '지난 7일 이벤트 수',
                  style: CustomTextStyles.labelLargeGray,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '8.6천',
                  style: CustomTextStyles.headlineLargeBlack,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                      color: appTheme.alertPositive.withOpacity(0.1)),
                  child:
                      Text('+35.4%', style: CustomTextStyles.labelLargeGreen),
                ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                  child: Row(
                children: [
                  Text(
                    'Google Analytics',
                    style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: appTheme.skyBlue,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CustomImageView(
                    imagePath: IconConstant.newTab,
                  )
                ],
              )),
            ),
          ],
        ));
  }

  Widget _buildLast7DaysReturningMembersNumber() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder12,
            color: appTheme.white),
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '지난 7일 재사용 회원 수',
                  style: CustomTextStyles.labelLargeGray,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '74',
                  style: CustomTextStyles.headlineLargeBlack,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                      color: appTheme.alertPositive.withOpacity(0.1)),
                  child:
                      Text('+37.0%', style: CustomTextStyles.labelLargeGreen),
                ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                  child: Row(
                children: [
                  Text(
                    'Google Analytics',
                    style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: appTheme.skyBlue,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CustomImageView(
                    imagePath: IconConstant.newTab,
                  )
                ],
              )),
            ),
          ],
        ));
  }

  Widget _buildMembersGraph() {
    return Container(
        height: 397,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder12,
            color: appTheme.white),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '등록 사용자 수',
              style: CustomTextStyles.labelLargeGray,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              NumberFormat('#,###')
                  .format(controller.registeredModel.totalMembers),
              style: CustomTextStyles.headlineLargeBlack,
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: ShapeDecoration(
                    color: appTheme.background,
                    shape: const OvalBorder(),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text('미가입자', style: CustomTextStyles.labelMediumGray)
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: ShapeDecoration(
                    color: appTheme.skyBlue,
                    shape: const OvalBorder(),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text('활성 회원', style: CustomTextStyles.labelMediumGray)
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: ShapeDecoration(
                    color: appTheme.alertNegative,
                    shape: const OvalBorder(),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text('비활성 회원', style: CustomTextStyles.labelMediumGray)
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: SfCircularChart(series: <CircularSeries>[
                      DoughnutSeries<MembersData, String>(
                        dataSource: _getChartData(),
                        xValueMapper: (MembersData data, _) =>
                            data.registrationState,
                        yValueMapper: (MembersData data, _) => data.number,
                        pointColorMapper: (datum, index) => datum.color,
                        // strokeWidth: 1,
                        // strokeColor: appTheme.grayScale1,
                        radius: '100%',
                        innerRadius: '70%',
                      )
                    ]),
                  ),
                  Text(
                      '${controller.registeredModel.verifiedPercentage!.toStringAsFixed(2)}%',
                      style: CustomTextStyles.titleSmallSkyBlue)
                ],
              ),
            ),
          ],
        ));
  }

  List<MembersData> _getChartData() {
    final List<MembersData> chartData = [
      MembersData(
          'not registered',
          controller.registeredModel.unverifiedPercentage!,
          appTheme.background),
      MembersData(
          'inactive',
          controller.registeredModel.disabledMembersPercentage!,
          appTheme.alertNegative),
      MembersData('registered', controller.registeredModel.verifiedPercentage!,
          appTheme.skyBlue),
    ];
    return chartData;
  }

  Widget _buildPracticePlanCompletionRate() {
    return Container(
        height: 397,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder12,
            color: appTheme.white),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Practice plan 완료율',
                  style: CustomTextStyles.labelLargeGray,
                ),
                InkWell(
                  onTap: controller.onPracticeMore,
                  child: Text(
                    '모두보기',
                    style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: appTheme.skyBlue),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                border: TableBorder(
                    horizontalInside: BorderSide(color: appTheme.grayScale2)),
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      '',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '회차',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '완료 회원 수',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '참여 회원 수',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '완료율',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                ],
                rows: List.generate(controller.practiceModel.length, (index) {
                  return DataRow(cells: [
                    DataCell(Text('${index + 1}',
                        style: CustomTextStyles.labelLargeSkyBlue)),
                    DataCell(
                      InkWell(
                        onTap: () {
                          controller.onPracticeTap(index);
                        },
                        child: Text(
                          "${controller.practiceModel.level![index]}회차",
                          style: CustomTextStyles.bodyMediumBlack
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    DataCell(Text(
                        NumberFormat('#,###').format(
                            controller.practiceModel.finished != null
                                ? controller.practiceModel.finished![index]
                                : 0),
                        style: CustomTextStyles.bodyMediumBlack)),
                    DataCell(Text(
                        NumberFormat('#,###').format(
                            controller.practiceModel.participated != null
                                ? controller.practiceModel.participated![index]
                                : 0),
                        style: CustomTextStyles.bodyMediumBlack)),
                    DataCell(Text(
                        controller.practiceModel.ratio != null
                            ? controller.practiceModel.ratio![index]
                            : '-',
                        style: CustomTextStyles.bodyMediumGreen)),
                  ]);
                }).toList(),
              ),
            )
          ],
        ));
  }

  Widget _buildPopularChallenge() {
    return Container(
        width: 1016,
        height: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder12,
            color: appTheme.white),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '인기 Challenge',
                  style: CustomTextStyles.labelLargeGray,
                ),
                InkWell(
                  onTap: controller.onChallengeMore,
                  child: Text(
                    '모두보기',
                    style: CustomTextStyles.labelLargeSkyBlue.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: appTheme.skyBlue),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
                '집계기간  |  ${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 8)))} ~ ${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1)))}',
                style: CustomTextStyles.labelMediumGray),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: List.generate(3, (index) {
                      return Column(
                        children: [
                          index < controller.challengeModel.length
                              ? _challengeItemBuilder(index)
                              : SizedBox(
                                  height: 56,
                                  child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text((index + 1).toString(),
                                            style: CustomTextStyles
                                                .labelLargeSkyBlue),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Text('집계된 데이터가 없습니다.',
                                            style:
                                                CustomTextStyles.labelLargeGray)
                                      ])),
                          index < 2
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: appTheme.grayScale2),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: List.generate(3, (index) {
                      return Column(
                        children: [
                          index + 3 < controller.challengeModel.length
                              ? _challengeItemBuilder(index + 3)
                              : SizedBox(
                                  height: 56,
                                  child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text((index + 4).toString(),
                                            style: CustomTextStyles
                                                .labelLargeSkyBlue),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Text('집계된 데이터가 없습니다.',
                                            style:
                                                CustomTextStyles.labelLargeGray)
                                      ])),
                          index < 2
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: appTheme.grayScale2),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _challengeItemBuilder(int index) {
    return InkWell(
      onTap: () {
        controller.onChallengeTap(index);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text((index + 1).toString(),
              style: CustomTextStyles.labelLargeSkyBlue),
          const SizedBox(
            width: 16,
          ),
          CustomImageView(
            imagePath: controller.challengeModel.image![index],
            height: 56,
            width: 56,
            radius: BorderRadiusStyle.roundedBorder8,
            // margin: EdgeInsets.only(
            //   top: 2,
            // ),
          ),
          const SizedBox(
            width: 16,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.challengeModel.name![index],
                  style: CustomTextStyles.titleSmallBlack,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Text(
                        '${controller.challengeModel.duration![index]} min',
                        style: CustomTextStyles.labelLargeGray,
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 2,
                      decoration: BoxDecoration(
                        color: appTheme.grayScale6,
                        borderRadius: BorderRadius.circular(
                          1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        '${controller.challengeModel.daysTotal![index]} days',
                        // "${model.daysTotal![index]} days",
                        style: CustomTextStyles.labelLargeGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                CustomImageView(
                  imagePath: IconConstant.user,
                ),
                SizedBox(
                  width: 48,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      NumberFormat('#,###').format(
                          controller.challengeModel.participants![index]),
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

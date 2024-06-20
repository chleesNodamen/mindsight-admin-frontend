import 'package:flutter/material.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard_controller.dart';
import 'package:mindsight_admin_page/theme/theme_helper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class DashboardView extends GetWidget<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 48,
      ),
      child: ListView(
        children: [
          const SizedBox(
            height: 80,
          ),
          Text('대시보드', style: CustomTextStyles.headlineLargeBlack),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: [
              _buildFirstContainer(),
              const SizedBox(
                width: 16,
              ),
              _buildSecondContainer(),
              const SizedBox(
                width: 16,
              ),
              _buildThirdContainer(),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              _buildMembersGraph(),
              const SizedBox(
                width: 16,
              ),
              _buildPracticePlanContainer(),
            ],
          ), const SizedBox(
            height: 16,
          ),Row(
            children: [
              _buildChallengeContainer(),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget _buildFirstContainer() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: appTheme.white),
        padding: const EdgeInsets.all(24),
        child: Column(
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
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: appTheme.alertNegative.withOpacity(0.1)),
              child: Text('-6.5%', style: CustomTextStyles.labelLargeRed),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
                child: Row(
              children: [
                const SizedBox(
                  width: 125,
                ),
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
          ],
        ));
  }

  Widget _buildSecondContainer() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: appTheme.white),
        padding: const EdgeInsets.all(24),
        child: Column(
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
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: appTheme.alertPositive.withOpacity(0.1)),
              child: Text('+35.4%', style: CustomTextStyles.labelLargeGreen),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
                child: Row(
              children: [
                const SizedBox(
                  width: 125,
                ),
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
          ],
        ));
  }

  Widget _buildThirdContainer() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: appTheme.white),
        padding: const EdgeInsets.all(24),
        child: Column(
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
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: appTheme.alertPositive.withOpacity(0.1)),
              child: Text('+37.0%', style: CustomTextStyles.labelLargeGreen),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
                child: Row(
              children: [
                const SizedBox(
                  width: 125,
                ),
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
          ],
        ));
  }

  Widget _buildMembersGraph() {
    return Container(
        height: 397,
        width: 328,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: appTheme.white),
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
              '10,016',
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
                    shape: OvalBorder(),
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
                    shape: OvalBorder(),
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
                    shape: OvalBorder(),
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
                  Container(
                    width: 180,
                    height: 180,
                    child: SfCircularChart(series: <CircularSeries>[
                      DoughnutSeries<MembersData, String>(
                        dataSource: getChartData(),
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
                  Text('78.05%', style: CustomTextStyles.titleSmallSkyBlue)
                ],
              ),
            ),
          ],
        ));
  }

  List<MembersData> getChartData() {
    final List<MembersData> chartData = [
      MembersData('not registered', 18.00, appTheme.background),
      MembersData('inactive', 3.95, appTheme.alertNegative),
      MembersData('registered', 78.05, appTheme.skyBlue),
    ];
    return chartData;
  }

  Widget _buildPracticePlanContainer() {
    return Container(
      width: 672,
      height: 397,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: appTheme.white),
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
                GestureDetector(
                  child: Text('모두보기', style: CustomTextStyles.labelLargeSkyBlue.copyWith(decoration: TextDecoration.underline, decorationColor: appTheme.skyBlue),),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            DataTable(
              border: TableBorder(horizontalInside: BorderSide(color: appTheme.grayScale2)),
              columns: <DataColumn>[
                DataColumn(
                  label: SizedBox(
                    width:20, child: Text(
                    '',
                    style: CustomTextStyles.labelLargeGray,
                  ),),
                ),
                DataColumn(
                  label: SizedBox(
                    width:80,
                    child: Text(
                      '회차',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width:80,
                    child: Text(
                      '완료 회원 수',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width:80,
                    child: Text(
                      '참여 회원 수',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width:80,
                    child: Text(
                      '완료율',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('1', style: CustomTextStyles.bodyLargeSkyBlue,)),
                    DataCell(Text('1회차', style: CustomTextStyles.bodyLargeBlack.copyWith(decoration: TextDecoration.underline),)),
                    DataCell(Text('3,456', style: CustomTextStyles.bodyLargeBlack,)),
                    DataCell(Text('3,920', style: CustomTextStyles.bodyLargeBlack,)),
                    DataCell(Text('88.1%', style: CustomTextStyles.bodyLargeGreen,)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('2', style: CustomTextStyles.bodyLargeSkyBlue,)),
                    DataCell(Text('2회차', style: CustomTextStyles.bodyLargeBlack.copyWith(decoration: TextDecoration.underline),)),
                    DataCell(Text('3,456', style: CustomTextStyles.bodyLargeBlack,)),
                    DataCell(Text('3,920', style: CustomTextStyles.bodyLargeBlack,)),
                    DataCell(Text('88.1%', style: CustomTextStyles.bodyLargeGreen,)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('3', style: CustomTextStyles.bodyLargeSkyBlue,)),
                    DataCell(Text('3회차', style: CustomTextStyles.bodyLargeBlack.copyWith(decoration: TextDecoration.underline),)),
                    DataCell(Text('3,456', style: CustomTextStyles.bodyLargeBlack,)),
                    DataCell(Text('3,920', style: CustomTextStyles.bodyLargeBlack,)),
                    DataCell(Text('88.1%', style: CustomTextStyles.bodyLargeGreen,)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('4', style: CustomTextStyles.bodyLargeSkyBlue,)),
                    DataCell(Text('4회차', style: CustomTextStyles.bodyLargeBlack.copyWith(decoration: TextDecoration.underline),)),
                    DataCell(Text('3,456', style: CustomTextStyles.bodyLargeBlack,)),
                    DataCell(Text('3,920', style: CustomTextStyles.bodyLargeBlack,)),
                    DataCell(Text('88.1%', style: CustomTextStyles.bodyLargeGreen,)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('5', style: CustomTextStyles.bodyLargeSkyBlue,)),
                    DataCell(Text('5회차', style: CustomTextStyles.bodyLargeBlack.copyWith(decoration: TextDecoration.underline),)),
                    DataCell(Text('3,456', style: CustomTextStyles.bodyLargeBlack,)),
                    DataCell(Text('3,920', style: CustomTextStyles.bodyLargeBlack,)),
                    DataCell(Text('88.1%', style: CustomTextStyles.bodyLargeGreen,)),
                  ],
                ),
              ],
            )
          ],
        ));
  }

    Widget _buildChallengeContainer() {
    return Container(
      width: 1016,
      height: 346,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: appTheme.white),
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
                GestureDetector(
                  child: Text('모두보기', style: CustomTextStyles.labelLargeSkyBlue.copyWith(decoration: TextDecoration.underline, decorationColor: appTheme.skyBlue),),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text('집계기간  |  ${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 8)))} ~ ${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1)))}', style: CustomTextStyles.labelMediumGray),
            const SizedBox(
              height: 24,
            ),
_challengeItemBuilder(1),
          ],
        ));
  }
  Widget _challengeItemBuilder(int index){
    return Container(
      child: Row(
        children: [
          Text(index.toString(), style: CustomTextStyles.labelLargeSkyBlue),
          const SizedBox(width: 16,),
          CustomImageView(
            imagePath: "assets/challenge_example.png",
          ),
          Column(
            children: [
              Text('Help Digestion', style: CustomTextStyles.titleSmallBlack),
              Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.v),
                          child: Text(
                            // "${model.duration![index]} ${"min".tr}",
                            '8 - 11 min',
                            style: CustomTextStyles.labelLargeGray,
                          ),
                        ),
                        Container(
                          height: 2.adaptSize,
                          width: 2.adaptSize,
                          margin: EdgeInsets.only(
                            left: 6.h,
                            top: 7.v,
                            bottom: 8.v,
                          ),
                          decoration: BoxDecoration(
                            color: appTheme.grayScale6,
                            borderRadius: BorderRadius.circular(
                              1.h,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6.h),
                          child: Text(
                            '14 days',
                            // "${model.daysTotal![index]} days",
                            style: CustomTextStyles.labelLargeGray,
                          ),
                        ),
                      ],),
            ],
          )
        ],
      )
    );
  }
}

class MembersData {
  MembersData(this.registrationState, this.number, this.color);
  final String registrationState;
  final double number;
  final Color color;
}

import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/master_manage/inactive_master_manage_controller.dart';

class InactiveMasterManageView
    extends GetWidget<InactiveMasterManageController> {
  const InactiveMasterManageView({super.key});

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
                                  const SizedBox(height: 32),
                                  // _buildCheckBox(),
                                  // const SizedBox(height: 16),
                                  _buildPage(),
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

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "비승인 마스터 관리",
      searchShow: true,
      viewCount: false,
      searchText: "이메일 주소, 이름 검색",
      memberShow: true,
      memberCount: controller.masterListModel.total,
      onSearch: controller.onSearch,
    );
  }

  SingleChildScrollView _buildPage() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: appTheme.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        // height: 1016,
        width: double.infinity,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 0,
                checkboxHorizontalMargin: 0,
                dataRowMaxHeight: 80,
                border: TableBorder(
                    horizontalInside: BorderSide(color: appTheme.grayScale2)),
                columns: [
                  DataColumn(
                      label:
                          Text('소속', style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('이메일 주소',
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text('사용자 이름',
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label:
                          Text('전환일', style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label:
                          Text('상태', style: CustomTextStyles.labelLargeGray)),
                ],
                rows: List.generate(controller.masterListModel.length, (index) {
                  return DataRow(
                      selected: controller.selectedMaster[index],
                      onSelectChanged: (bool? value) {
                        controller.onMasterSelectChanged(index);
                      },
                      cells: [
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.masterListModel.companyName![index],
                              style: controller.masterListModel.verified![index]
                                  ? CustomTextStyles.bodyLargeBlack
                                  : CustomTextStyles.bodyLargeGray),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: InkWell(
                            child: Text(
                                controller.masterListModel.email![index],
                                style: controller
                                        .masterListModel.verified![index]
                                    ? CustomTextStyles.bodyLargeBlack.copyWith(
                                        decoration: TextDecoration.underline)
                                    : CustomTextStyles.bodyLargeGray.copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationColor: appTheme.grayScale5)),
                            onTap: () {
                              controller.onMasterTap(
                                  controller.masterListModel.id![index]);
                            },
                          ),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.masterListModel.nickname![index],
                              style: controller.masterListModel.verified![index]
                                  ? CustomTextStyles.bodyLargeBlack
                                  : CustomTextStyles.bodyLargeGray),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                              controller.masterListModel.createdAt != null
                                  ? DateFormat('yyyy-MM-dd').format(controller
                                      .masterListModel.createdAt![index])
                                  : "",
                              style: CustomTextStyles.bodyLargeBlack),
                        )),
                        DataCell(DecoratedBox(
                          decoration: BoxDecoration(
                            color: appTheme.white,
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                            border: Border.all(
                              width: 1,
                              color: appTheme.grayScale2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 0, top: 0, bottom: 0),
                            child: DropdownButton<ContentStatus>(
                              value: ContentStatus.fromKeyword(
                                  controller.masterListModel.verified![index]),
                              underline: Container(),
                              padding: const EdgeInsets.only(left: 6),
                              borderRadius: BorderRadiusStyle.roundedBorder12,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (ContentStatus? newValue) {
                                controller.onVerifiedChanged(index);
                              },
                              items: <ContentStatus>[
                                ContentStatus.approve,
                                ContentStatus.disapprove
                              ].map<DropdownMenuItem<ContentStatus>>(
                                  (ContentStatus value) {
                                return DropdownMenuItem<ContentStatus>(
                                  value: value,
                                  child: Text(
                                    value.displayName,
                                    style: value == ContentStatus.approve
                                        ? CustomTextStyles.labelLargeGreen
                                        : CustomTextStyles.labelLargeRed,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )),
                      ]);
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Obx(
              () => Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Row(
                    children: [
                      CustomElevatedButton(
                        text: '승인',
                        buttonTextStyle: CustomTextStyles.bodyMediumSkyBlueBold,
                        buttonStyle: CustomButtonStyles.fillPrimaryTransparent,
                        // margin: const EdgeInsets.symmetric(
                        //     vertical: 11, horizontal: 24),
                        width: 90,
                        height: 44,
                        onPressed: controller.onVerfiedButtonPressed,
                      ),
                      // CustomElevatedButton(
                      //   text: '비활성',
                      // buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
                      //   buttonStyle: CustomButtonStyles.fillRedTransparent,
                      //   margin: const EdgeInsets.symmetric(horizontal: 16),
                      //   width: 90,
                      //   height: 44,
                      // ),
                    ],
                  ),
                  Pages(
                      pages: (controller.masterListModel.total! / 20).ceil(),
                      activePage: controller.activePage.value,
                      onTap: (int pageNum) {
                        controller.loadPage(pageNum);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

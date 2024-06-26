import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage_controller.dart';

class ActivityManageView extends GetWidget<ActivityManageController> {
  const ActivityManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBodyBehindAppBar: true,
        body: PageLoadingIndicator(
          isLoading: controller.isLoading.value,
          child: controller.isInited.value ? ResponsiveWidget(
            largeScreen: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SideMenu(),
                Expanded(
                  // flex: 5,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(48.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const TobBarSearch(
                                name: "활동 기록 관리",
                                searchShow: true,
                                viewCount: false,
                                searchText: "회원, 기록 내용 검색",
                              ),
                              const SizedBox(height: 32),
                              CustomElevatedButton(
                                text: "신규 등록",
                                height: 44,
                                width: 107,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              const SizedBox(height: 32),
                              buildFirstContainer(),
                              const SizedBox(height: 32),
                              _pageView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ) : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Container buildFirstContainer() {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      height: controller.showMore.value ? 308 : 268,
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('유형', style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 170,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListTile(
                                  contentPadding:
                                      EdgeInsets.only(left: 0.0, right: 0.0),
                                  title: Row(
                                    children: <Widget>[
                                      Radio<Type>(
                                        value: Type.practice,
                                        groupValue: controller.type.value,
                                        onChanged: (Type? value) {
                                          controller.type.value = value!;
                                        },
                                      ),
                                      Text(controller.typeLabels[0],
                                          style: CustomTextStyles
                                              .bodyMediumBlack
                                              .copyWith(
                                                  fontWeight: FontWeight.w500)),
                                    ],
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 170,
                            child: ListTile(
                                contentPadding:
                                    EdgeInsets.only(left: 0.0, right: 0.0),
                                title: Row(
                                  children: <Widget>[
                                    Radio<Type>(
                                      value: Type.challenge,
                                      groupValue: controller.type.value,
                                      onChanged: (Type? value) {
                                        controller.type.value = value!;
                                      },
                                    ),
                                    Text(controller.typeLabels[1],
                                        style: CustomTextStyles.bodyMediumBlack
                                            .copyWith(
                                                fontWeight: FontWeight.w500)),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ])
              ],
            ),
          ),
          const SizedBox(height: 20),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('회원 소속', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 15),
                  Wrap(
                    runSpacing: 18,
                    children: List.generate(3, (index) {
                      return CustomCheckboxWidget(
                        isChecked: controller.membershipValues[index],
                        label: controller.membershipLabels[index],
                        onChanged: (value) =>
                            controller.toggleMembership(index, value),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(
                width: 48,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('챗봇 기록', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 15),
                  Wrap(
                    runSpacing: 18,
                    children: List.generate(2, (index) {
                      return CustomCheckboxWidget(
                        isChecked: controller.chatbotValues[index],
                        label: controller.chatbotLabels[index],
                        onChanged: (value) =>
                            controller.toggleChatbot(index, value),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(
                width: 48,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('피드백 상태', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 15),
                  Wrap(
                    runSpacing: 18,
                    children: List.generate(2, (index) {
                      return CustomCheckboxWidget(
                        isChecked: controller.feedbackValues[index],
                        label: controller.feedbackLabels[index],
                        onChanged: (value) =>
                            controller.toggleFeedback(index, value),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _pageView() {
    return Container(
        decoration: BoxDecoration(
          color: appTheme.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        height: 500,
        width: double.infinity,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            DataTable(
              border: TableBorder(
                  horizontalInside: BorderSide(color: appTheme.grayScale2)),
              columns: <DataColumn>[
                DataColumn(
                  label: SizedBox(
                    width: 20,
                    child: Text(
                      '',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 80,
                    child: Text(
                      '회차',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 80,
                    child: Text(
                      '완료 회원 수',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 80,
                    child: Text(
                      '참여 회원 수',
                      style: CustomTextStyles.labelLargeGray,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 80,
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
                    DataCell(Text(
                      '1',
                      style: CustomTextStyles.bodyLargeSkyBlue,
                    )),
                    DataCell(GestureDetector(
                      child: Text(
                        '1회차',
                        style: CustomTextStyles.bodyLargeBlack
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                      onTap: controller.onHistoryTap,
                    )),
                    DataCell(Text(
                      '3,456',
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                    DataCell(Text(
                      '3,920',
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                    DataCell(Text(
                      '88.1%',
                      style: CustomTextStyles.bodyLargeGreen,
                    )),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      '2',
                      style: CustomTextStyles.bodyLargeSkyBlue,
                    )),
                    DataCell(Text(
                      '2회차',
                      style: CustomTextStyles.bodyLargeBlack
                          .copyWith(decoration: TextDecoration.underline),
                    )),
                    DataCell(Text(
                      '3,456',
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                    DataCell(Text(
                      '3,920',
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                    DataCell(Text(
                      '88.1%',
                      style: CustomTextStyles.bodyLargeGreen,
                    )),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      '3',
                      style: CustomTextStyles.bodyLargeSkyBlue,
                    )),
                    DataCell(Text(
                      '3회차',
                      style: CustomTextStyles.bodyLargeBlack
                          .copyWith(decoration: TextDecoration.underline),
                    )),
                    DataCell(Text(
                      '3,456',
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                    DataCell(Text(
                      '3,920',
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                    DataCell(Text(
                      '88.1%',
                      style: CustomTextStyles.bodyLargeGreen,
                    )),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      '4',
                      style: CustomTextStyles.bodyLargeSkyBlue,
                    )),
                    DataCell(Text(
                      '4회차',
                      style: CustomTextStyles.bodyLargeBlack
                          .copyWith(decoration: TextDecoration.underline),
                    )),
                    DataCell(Text(
                      '3,456',
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                    DataCell(Text(
                      '3,920',
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                    DataCell(Text(
                      '88.1%',
                      style: CustomTextStyles.bodyLargeGreen,
                    )),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      '5',
                      style: CustomTextStyles.bodyLargeSkyBlue,
                    )),
                    DataCell(Text(
                      '5회차',
                      style: CustomTextStyles.bodyLargeBlack
                          .copyWith(decoration: TextDecoration.underline),
                    )),
                    DataCell(Text(
                      '3,456',
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                    DataCell(Text(
                      '3,920',
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                    DataCell(Text(
                      '88.1%',
                      style: CustomTextStyles.bodyLargeGreen,
                    )),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Obx(() => Pages(
                pages: 100,
                activePage: controller.activePage.value,
                onTap: (int pageNum) {
                  controller.loadNewPage(pageNum);
                }))
          ],
        ));
  }
}

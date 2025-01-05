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
          child: controller.isInited.value
              ? ResponsiveWidget(
                  largeScreen: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SideMenu(),
                      Expanded(
                        // flex: 5,
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TobBarSearch(
                                    name: "Activity record management".tr,
                                    searchShow: true,
                                    viewCount: false,
                                    searchText: "Search member records".tr,
                                    onSearch: controller.onSearch,
                                  ),
                                  const SizedBox(height: 32),
                                  CustomElevatedButton(
                                    onPressed: () => showSimpleMessage(
                                        "Service preparing".tr),
                                    text: "New registration".tr,
                                    height: 44,
                                    // width: 107,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder12),
                                  ),
                                  const SizedBox(height: 32),
                                  _buildSelect(),
                                  const SizedBox(height: 32),
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

  Container _buildSelect() {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      height: 268,
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Category".tr, style: CustomTextStyles.labelMediumGray),
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
                                  contentPadding: const EdgeInsets.only(
                                      left: 0.0, right: 0.0),
                                  title: Row(
                                    children: <Widget>[
                                      Radio<ActivityType>(
                                        value: ActivityType.practice,
                                        groupValue: controller.type.value,
                                        onChanged: (ActivityType? value) {
                                          controller.onChangeType(value);
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
                                contentPadding: const EdgeInsets.only(
                                    left: 0.0, right: 0.0),
                                title: Row(
                                  children: <Widget>[
                                    Radio<ActivityType>(
                                      value: ActivityType.challenge,
                                      groupValue: controller.type.value,
                                      onChanged: (ActivityType? value) {
                                        controller.onChangeType(value);
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
          Divider(
            height: 49,
            thickness: 1,
            color: appTheme.grayScale2,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Member affiliation".tr,
                      style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 15),
                  Wrap(
                    runSpacing: 18,
                    children: List.generate(controller.membershipLabels.length,
                        (index) {
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
                  Text("Chatbot record".tr,
                      style: CustomTextStyles.labelMediumGray),
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
                  Text("Feedback status".tr,
                      style: CustomTextStyles.labelMediumGray),
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
                      label: Text("Category".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Member info".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Session info".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("기록".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Feedback status".tr,
                          style: CustomTextStyles.labelLargeGray)),
                ],
                rows: List.generate(controller.activityModel.length, (index) {
                  return DataRow(cells: [
                    DataCell(Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                          controller.activityModel.type![index] ==
                                  ActivityType.practice.name
                              ? controller.typeLabels[0]
                              : controller.typeLabels[1],
                          style: CustomTextStyles.bodyLargeBlack),
                    )),
                    DataCell(Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: InkWell(
                        onTap: () {
                          controller.onMemberTap(index);
                        },
                        child: Text(controller.activityModel.email![index],
                            style: CustomTextStyles.bodyLargeBlack.copyWith(
                                decoration: TextDecoration.underline)),
                      ),
                    )),
                    DataCell(Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: InkWell(
                        onTap: () {
                          controller.onSessionTap(index);
                        },
                        child: Text(
                            controller.activityModel.sessionName![index],
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.bodyLargeBlack.copyWith(
                                decoration: TextDecoration.underline)),
                      ),
                    )),
                    DataCell(Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: InkWell(
                        onTap: () {
                          controller.onHistoryTap(index);
                        },
                        child: SizedBox(
                          width: 100,
                          child: Text(controller.activityModel.record![index],
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyles.bodyLargeBlack.copyWith(
                                  decoration: TextDecoration.underline)),
                        ),
                      ),
                    )),
                    DataCell(Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                          controller.activityModel.feedback![index]
                              ? "Complete".tr
                              : "None".tr,
                          style: controller.activityModel.feedback![index]
                              ? CustomTextStyles.bodyLargeGreen
                              : CustomTextStyles.bodyLargeRed),
                    )),
                  ]);
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Pages(
                pages: (controller.activityModel.total! / 20).ceil(),
                activePage: controller.activePage.value,
                onTap: (int pageNum) {
                  controller.loadPage(pageNum);
                }),
          ],
        ),
      ),
    );
  }
}

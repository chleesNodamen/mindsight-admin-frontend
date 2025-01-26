import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/sort_condition.dart';
import 'package:mindsight_admin_page/presentation/faq_board_manage/faq_board_manage_controller.dart';

class FAQBoardManageView extends GetWidget<FAQBoardManageController> {
  const FAQBoardManageView({super.key});

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
                          child: ListView(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildTitle(),
                                  const SizedBox(height: 32),
                                  Visibility(
                                    visible: Account.isAdmin,
                                    child: Column(
                                      children: [
                                        _buildRegisterButton(),
                                        const SizedBox(height: 32),
                                      ],
                                    ),
                                  ),
                                  _buildSortDropdown(),
                                  const SizedBox(height: 16),
                                  _buildPage()
                                ],
                              ),
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

  CustomElevatedButton _buildRegisterButton() {
    return CustomElevatedButton(
      text: "New registration".tr,
      height: 44,
      // width: 107,
      decoration:
          BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder12),
      onPressed: controller.onRegister,
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "FAQ".tr,
      searchShow: true,
      viewCount: false,
      searchText: "Search question".tr,
      onSearch: controller.onSearch,
    );
  }

  DecoratedBox _buildSortDropdown() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: appTheme.grayScale2,
        ),
        color: appTheme.white,
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 0, top: 0, bottom: 0),
        child: DropdownButton<SortCondition>(
          value: controller.selectedOrder.value,
          underline: Container(),
          padding: const EdgeInsets.only(left: 6),
          borderRadius: BorderRadiusStyle.roundedBorder12,
          // icon: const Icon(Icons.),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (SortCondition? newValue) {
            if (newValue != null) {
              controller.onChangedSelectedOrder(newValue);
            }
          },
          items: <SortCondition>[
            SortCondition.registration,
            SortCondition.views
          ].map<DropdownMenuItem<SortCondition>>((SortCondition value) {
            return DropdownMenuItem<SortCondition>(
              value: value,
              child: Text(
                value.displayName.tr,
                style: CustomTextStyles.labelLargeBlack,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  SingleChildScrollView _buildPage() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: appTheme.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
            width: 1,
            color: appTheme.grayScale2,
          ),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(32.0),
        // height: 972,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              child: DataTable(
                showCheckboxColumn: false,
                columnSpacing: 0,
                checkboxHorizontalMargin: 0,
                dataRowMaxHeight: 80,
                border: TableBorder(
                    horizontalInside: BorderSide(color: appTheme.grayScale2)),
                columns: [
                  DataColumn(
                      label: Text("Date".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Question".tr,
                          style: CustomTextStyles.labelLargeGray)),
                  DataColumn(
                      label: Text("Views".tr,
                          style: CustomTextStyles.labelLargeGray)),
                ],
                rows: List.generate(controller.faqBoardModel.length, (index) {
                  return DataRow(cells: [
                    DataCell(Text(
                      DateFormat('yyyy-MM-dd HH:mm')
                          .format(controller.faqBoardModel.createdAt![index]),
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                    DataCell(InkWell(
                      onTap: () =>
                          Get.offAllNamed(AppRoutes.faqBoardDetail, arguments: {
                        RouteArguments.id: controller.faqBoardModel.id![index]
                      }),
                      child: Text(controller.faqBoardModel.question![index],
                          style: CustomTextStyles.bodyLargeBlack
                              .copyWith(decoration: TextDecoration.underline)),
                    )),
                    DataCell(Text(
                      controller.faqBoardModel.views![index].toString(),
                      style: CustomTextStyles.bodyLargeBlack,
                    )),
                  ]);
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Pages(
                pages: (controller.faqBoardModel.total! / 20).ceil(),
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

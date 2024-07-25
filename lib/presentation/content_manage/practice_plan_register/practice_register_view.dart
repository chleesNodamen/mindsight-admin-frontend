import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/content_manage/practice_plan_register/practice_register_controller.dart';

class PracticeRegisterView extends GetWidget<PracticeRegisterController> {
  const PracticeRegisterView({super.key});

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
                          margin: const EdgeInsets.all(48.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildTopBar(),
                              const SizedBox(height: 32),
                              buildSubHeader(),
                              const SizedBox(height: 32),
                              buildTextFields()
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

  Column buildTextFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFirstRow(),
        const SizedBox(height: 24),
        buildLastRow(),
      ],
    );
  }

  Column buildLastRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(text: "콘텐츠 등록 ", style: CustomTextStyles.labelLargeBlack),
          TextSpan(text: "*", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => showCustomDialog(true),
          child: Container(
            width: 353,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: appTheme.grayScale3),
                color: appTheme.white),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(controller.selectedBodyName.value,
                    style: CustomTextStyles.bodyMediumBlack),
                CustomImageView(
                  imagePath: IconConstant.search,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => showCustomDialog(false),
          child: Container(
            width: 353,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: appTheme.grayScale3),
                color: appTheme.white),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(controller.selectedBreathName.value,
                    style: CustomTextStyles.bodyMediumBlack),
                CustomImageView(
                  imagePath: IconConstant.search,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 44),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomElevatedButton(
              text: '저장',
              buttonTextStyle: CustomTextStyles.bodyMediumWhite.copyWith(
                fontWeight: FontWeight.w700,
              ),
              buttonStyle: CustomButtonStyles.fillPrimary,
              width: 90,
              height: 44,
              onPressed: () async => {
                await controller.saveChanges(),
              },
            ),
            CustomElevatedButton(
              text: '취소',
              buttonTextStyle: CustomTextStyles.bodyMediumRed.copyWith(
                fontWeight: FontWeight.w700,
              ),
              buttonStyle: CustomButtonStyles.fillRedTransparent,
              margin: const EdgeInsets.only(left: 16),
              width: 90,
              height: 44,
              onPressed: () => Get.back(),
            ),
          ],
        )
      ],
    );
  }

  // 1 body 0 breath
  void showCustomDialog(bool contentType) {
    controller.resetData();
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: appTheme.background,
          ),
          width: 784,
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Practice plan 세션 선택',
                    style: CustomTextStyles.bodyMediumBlack,
                  ),
                  CustomImageView(
                    imagePath: IconConstant.close,
                    onTap: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: controller.textController,
                        decoration: InputDecoration(
                          fillColor: appTheme.white,
                          filled: true,
                          labelText: "콘텐츠 제목, 마스터 이름",
                          labelStyle: CustomTextStyles.bodyMediumGray,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: appTheme.grayScale3,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: appTheme.grayScale3,
                              width: 1,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: appTheme.grayScale3,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: appTheme.grayScale3,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: appTheme.red,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: appTheme.red,
                              width: 2,
                            ),
                          ),
                          errorStyle: TextStyle(
                            color: appTheme.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 76,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: appTheme.black,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        contentType == true
                            ? controller
                                .fetchBodyData(controller.textController.text)
                            : controller.fetchBreathData(
                                controller.textController.text);
                      },
                      child: Text(
                        "검색",
                        style: CustomTextStyles.bodyMediumWhite,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (controller.fetchedData.value == false) {
                  return Center(
                    child: Text('', style: CustomTextStyles.bodyMediumGray),
                  );
                }
                return Column(
                  children: [
                    const SizedBox(height: 35),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: appTheme.white,
                      ),
                      padding: const EdgeInsets.all(32.0),
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: DataTable(
                              columnSpacing: 0,
                              checkboxHorizontalMargin: 0,
                              dataRowMaxHeight: 80,
                              border: TableBorder(
                                horizontalInside:
                                    BorderSide(color: appTheme.grayScale2),
                              ),
                              columns: [
                                DataColumn(
                                  label: Text('',
                                      style: CustomTextStyles.labelLargeGray),
                                ),
                                DataColumn(
                                  label: Text('타입',
                                      style: CustomTextStyles.labelLargeGray),
                                ),
                                DataColumn(
                                  label: Text('제목',
                                      style: CustomTextStyles.labelLargeGray),
                                ),
                                DataColumn(
                                  label: Text('상태',
                                      style: CustomTextStyles.labelLargeGray),
                                ),
                              ],
                              rows: List.generate(
                                controller.contentListModel.length,
                                (index) {
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Radio<int>(
                                            value: index,
                                            groupValue:
                                                controller.selectedIndex.value,
                                            onChanged: (int? value) {
                                              if (value != null) {
                                                controller
                                                    .updateSelectedIndex(value);
                                              }
                                            },
                                          ),
                                        ),
                                      ), // Radio button cell
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 24.0),
                                          child: Text(
                                              controller.contentListModel
                                                  .type![index],
                                              style: CustomTextStyles
                                                  .bodyLargeBlack),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 24.0),
                                          child: Text(
                                              controller.contentListModel
                                                  .name![index],
                                              style: CustomTextStyles
                                                  .bodyLargeBlack),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 24.0),
                                          child: Text(
                                              controller.contentListModel
                                                      .status![index]
                                                  ? "정상"
                                                  : "안함",
                                              style: CustomTextStyles
                                                  .bodyLargeBlack),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              CustomElevatedButton(
                                  text: '상태 변경',
                                  buttonTextStyle:
                                      CustomTextStyles.bodyMediumWhite.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  buttonStyle: CustomButtonStyles.fillPrimary,
                                  margin: const EdgeInsets.only(right: 16),
                                  width: 107,
                                  height: 44,
                                  onPressed: () async {
                                    if (contentType) {
                                      controller.onBodyButtonPressed();
                                    } else {
                                      controller.onBreathButtonPressed();
                                    }
                                    Get.back();
                                  }),
                              Pages(
                                pages: (controller.contentListModel.total! / 5)
                                    .ceil(),
                                activePage: controller.activePage.value,
                                onTap: (int pageNum) {
                                  controller.loadNewPage(pageNum);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Column buildFirstRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(text: "회차 ", style: CustomTextStyles.labelLargeBlack),
          TextSpan(text: "*", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        Container(
          width: 353,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: appTheme.grayScale3),
              color: appTheme.grayScale2),
          padding: const EdgeInsets.all(16),
          child: Text('101회차', style: CustomTextStyles.bodyMediumGray),
        ),
      ],
    );
  }

  Row buildSubHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: controller.goToPractice,
          child: Text("Practice plan 관리",
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
        Text("Practice plan 신규 등록", style: CustomTextStyles.bodyMediumGray)
      ],
    );
  }

  TobBarSearch buildTopBar() {
    return TobBarSearch(
      name: "Practice plan 신규 등록",
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindsight_admin_page/constants/icon_constant.dart';
import 'package:mindsight_admin_page/theme/app_decoration.dart';
import 'package:mindsight_admin_page/theme/custom_button_style.dart';
import 'package:mindsight_admin_page/theme/custom_text_style.dart';
import 'package:mindsight_admin_page/theme/theme_helper.dart';
import 'package:mindsight_admin_page/widgets/custom_elevated_button.dart';
import 'package:mindsight_admin_page/widgets/custom_image_view.dart';
import 'package:mindsight_admin_page/widgets/pages.dart';

Future<void> showCompanySearchDialog() async {
  // await controller.initSearchDialogData(isBody);
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder12,
          color: appTheme.background,
        ),
        padding: const EdgeInsets.all(32.0),
        width: 700,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "회사 선택",
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
                      // controller: controller.textController,
                      decoration: InputDecoration(
                        fillColor: appTheme.white,
                        filled: true,
                        labelText: "회사 이름",
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
                    onTap: () {},
                    child: Text(
                      "검색",
                      style: CustomTextStyles.bodyMediumWhite,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 35),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.roundedBorder12,
                    color: appTheme.white,
                  ),
                  padding: const EdgeInsets.all(32.0),
                  // width: double.infinity,
                  // width: 500,
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
                              label: Text('이름',
                                  style: CustomTextStyles.labelLargeGray),
                            ),
                            DataColumn(
                              label: Text('상태',
                                  style: CustomTextStyles.labelLargeGray),
                            ),
                          ],
                          rows: List.generate(
                            4,
                            (index) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Radio<int>(
                                      value: index,
                                      groupValue: 0,
                                      onChanged: (int? value) {},
                                    ),
                                  ), // Radio button cell
                                  DataCell(
                                    Text("법인",
                                        style: CustomTextStyles.bodyLargeBlack),
                                  ),
                                  DataCell(
                                    Text("노다멘 주식회사",
                                        style: CustomTextStyles.bodyLargeBlack),
                                  ),
                                  DataCell(
                                    Text("정상",
                                        style: CustomTextStyles.bodyLargeBlack),
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          CustomElevatedButton(
                              text: '선택 완료',
                              buttonTextStyle:
                                  CustomTextStyles.bodyMediumWhiteBold,
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              margin: const EdgeInsets.only(right: 16),
                              width: 107,
                              height: 44,
                              onPressed: () async {
                                Get.back();
                              }),
                          Center(
                            child: Pages(
                              pages: 1,
                              activePage: 1,
                              onTap: (int pageNum) {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

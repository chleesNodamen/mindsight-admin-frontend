import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/company_list/company_list_model.dart';
import 'package:mindsight_admin_page/data/company_list/company_list_repository.dart';
import 'package:mindsight_admin_page/data/company_list/company_list_req_get.dart';

Future<Map<String, String>?> showCompanySearchDialog() async {
  // await controller.initSearchDialogData(isBody);
  TextEditingController searchController = TextEditingController();
  String searchKeyword = "";
  Map<String, String>? result;
  int selectedCompany = 0;

  CompanyListModel model = await CompanyListRepository().get(CompanyListReqGet(
    page: 1,
    search: searchKeyword.isNotEmpty ? searchKeyword : null,
    // verified: true,
  ));

  // if (model.total! > 0) {
  // selectedCompany = 0;
  // result = {
  //   "id": model.id![selectedCompany],
  //   "name": model.companyName![selectedCompany]
  // };
  // }

  await Get.dialog(
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return Dialog(
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
                  "회사 선택".tr,
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
                      controller: searchController,
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
                    onTap: () async {
                      searchKeyword = searchController.text;
                      model =
                          await CompanyListRepository().get(CompanyListReqGet(
                        page: 1,
                        search: searchKeyword.isNotEmpty ? searchKeyword : null,
                        // verified: true,
                      ));

                      if (model.total! > 0) {
                        selectedCompany = 0;
                        // result = {
                        //   "id": model.id![selectedCompany],
                        //   "name": model.companyName![selectedCompany]
                        // };
                      } else {
                        result = null;
                      }
                    },
                    child: Text(
                      "검색".tr,
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
                              label: Text("",
                                  style: CustomTextStyles.labelLargeGray),
                            ),
                            DataColumn(
                              label: Text("타입".tr,
                                  style: CustomTextStyles.labelLargeGray),
                            ),
                            DataColumn(
                              label: Text("이름".tr,
                                  style: CustomTextStyles.labelLargeGray),
                            ),
                            DataColumn(
                              label: Text("상태".tr,
                                  style: CustomTextStyles.labelLargeGray),
                            ),
                          ],
                          rows: List.generate(
                            model.total!,
                            (index) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Radio<int>(
                                      value: index,
                                      groupValue: selectedCompany,
                                      onChanged: (int? value) {
                                        if (value != null) {
                                          setState(() {
                                            selectedCompany = value;
                                            // result = {
                                            //   "id": model.id![selectedCompany],
                                            //   "name": model
                                            //       .companyName![selectedCompany]
                                            // };
                                          });

                                          // Logger.info(selectedCompany);
                                        }
                                      },
                                    ),
                                  ), // Radio button cell
                                  DataCell(
                                    Text("법인".tr,
                                        style: CustomTextStyles.bodyLargeBlack),
                                  ),
                                  DataCell(
                                    Text(model.companyName![index],
                                        style: CustomTextStyles.bodyLargeBlack),
                                  ),
                                  DataCell(
                                    Text("정상".tr,
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
                              text: "선택 완료".tr,
                              buttonTextStyle:
                                  CustomTextStyles.bodyMediumWhiteBold,
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              margin: const EdgeInsets.only(right: 16),
                              width: 107,
                              height: 44,
                              onPressed: () async {
                                if (model.total! > 0) {
                                  result = {
                                    "id": model.id![selectedCompany],
                                    "name": model.companyName![selectedCompany]
                                  };
                                }

                                Get.back();
                              }),
                          Center(
                            child: Pages(
                              pages: 1,
                              activePage: 1,
                              onTap: (int pageNum) async {
                                model = await CompanyListRepository()
                                    .get(CompanyListReqGet(
                                  page: pageNum,
                                  search: searchKeyword.isNotEmpty
                                      ? searchKeyword
                                      : null,
                                  // verified: true,
                                ));

                                if (model.total! > 0) {
                                  selectedCompany = 0;
                                  // result = {
                                  //   "id": model.id![selectedCompany],
                                  //   "name": model.companyName![selectedCompany]
                                  // };
                                } else {
                                  result = null;
                                }
                              },
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
    );
  }));

  // Logger.info("다이얼로그 종료 $result");

  return result;
}

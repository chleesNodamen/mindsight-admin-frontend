import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/master_list/master_list_model.dart';
import 'package:mindsight_admin_page/data/master_list/master_list_repository.dart';
import 'package:mindsight_admin_page/data/master_list/master_list_req_get.dart';

Future<Map<String, String>?> showMasterSearchDialog() async {
  TextEditingController searchController = TextEditingController();
  String searchKeyword = "";
  Map<String, String>? result;
  int selectedMaster = 0;
  RxInt activePage = 1.obs;

  MasterListModel model = await MasterListRepository().get(MasterListReqGet(
    page: activePage.value,
    pageSize: 5,
    search: searchKeyword.isNotEmpty ? searchKeyword : null,
    verified: true,
  ));

  await Get.dialog(
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder12,
              color: appTheme.background,
            ),
            padding: const EdgeInsets.all(32.0),
            width: 900,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select master".tr,
                      style: CustomTextStyles.bodyMediumBlack,
                    ),
                    CustomImageView(
                      imagePath: IconConstant.close,
                      onTap: () => Get.back(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "승인받은 마스터만 보입니다. 관리자만 보이는 임시 마스터선택창".tr,
                  style: CustomTextStyles.labelMediumGray,
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
                            labelText: "Master name".tr,
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
                              await MasterListRepository().get(MasterListReqGet(
                            page: 1,
                            pageSize: 5,
                            search:
                                searchKeyword.isNotEmpty ? searchKeyword : null,
                            verified: true,
                          ));

                          if (model.length > 0) {
                            selectedMaster = 0;
                          } else {
                            result = null;
                          }

                          activePage.value = 1;
                        },
                        child: Text(
                          "Search".tr,
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
                                  label: Text("ID".tr,
                                      style: CustomTextStyles.labelLargeGray),
                                ),
                                DataColumn(
                                  label: Text("Nickname".tr,
                                      style: CustomTextStyles.labelLargeGray),
                                ),
                                DataColumn(
                                  label: Text("Approval".tr,
                                      style: CustomTextStyles.labelLargeGray),
                                ),
                              ],
                              rows: List.generate(
                                model.length,
                                (index) {
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Radio<int>(
                                          value: index,
                                          groupValue: selectedMaster,
                                          onChanged: (int? value) {
                                            if (value != null) {
                                              setState(() {
                                                selectedMaster = value;
                                              });

                                              // Logger.info(selectedMaster);
                                            }
                                          },
                                        ),
                                      ), // Radio button cell
                                      DataCell(
                                        Text(model.email![index],
                                            style: CustomTextStyles
                                                .bodyLargeBlack),
                                      ),
                                      DataCell(
                                        Text(model.nickname![index],
                                            style: CustomTextStyles
                                                .bodyLargeBlack),
                                      ),
                                      DataCell(
                                        Text(
                                            model.verified![index]
                                                ? "Active".tr
                                                : "Inactive".tr,
                                            style: model.verified![index]
                                                ? const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 16)
                                                : const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 16)),
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
                                  text: "Select".tr,
                                  buttonTextStyle:
                                      CustomTextStyles.bodyMediumWhiteBold,
                                  buttonStyle: CustomButtonStyles.fillPrimary,
                                  margin: const EdgeInsets.only(right: 16),
                                  // width: 107,
                                  height: 44,
                                  onPressed: () async {
                                    if (model.length > 0) {
                                      result = {
                                        "id": model.id![selectedMaster],
                                        "nickname":
                                            model.nickname![selectedMaster]
                                      };
                                    }

                                    Get.back();
                                  }),
                              Center(
                                child: Pages(
                                  pages: (model.total! / 5).ceil(),
                                  activePage: activePage.value,
                                  onTap: (int pageNum) async {
                                    model = await MasterListRepository()
                                        .get(MasterListReqGet(
                                      page: pageNum,
                                      pageSize: 5,
                                      search: searchKeyword.isNotEmpty
                                          ? searchKeyword
                                          : null,
                                      verified: true,
                                    ));

                                    if (model.length > 0) {
                                      selectedMaster = 0;
                                    } else {
                                      result = null;
                                    }

                                    activePage.value = pageNum;
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
        ));
  }));

  // Logger.info("다이얼로그 종료 $result");

  return result;
}

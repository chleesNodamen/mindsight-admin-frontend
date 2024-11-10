import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/content_language.dart';
import 'package:mindsight_admin_page/constants/nation.dart';
import 'package:mindsight_admin_page/function/show_company_search_dialog.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_edit_controller.dart';

class MasterEditView extends GetWidget<MasterEditController> {
  const MasterEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildTitle(),
                                    const SizedBox(height: 16),
                                    _buildSubMenu(),
                                    const SizedBox(height: 32),
                                    _buildAccountInfo(),
                                    const SizedBox(height: 32),
                                    _buildBasicInfo(),
                                    const SizedBox(height: 32),
                                    _buildCompanyInfo(),
                                    const SizedBox(height: 32),
                                    _buildSaveNCancel(formKey)
                                  ],
                                ),
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

  Widget _buildAccountInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("계정 정보", style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildEmail("이메일 주소 (아이디)", true),
            const SizedBox(width: 24),
            _buildInput("닉네임", true),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildInput("비밀번호", true),
            const SizedBox(width: 24),
            _buildInput("비밀번호 확인", true),
          ],
        ),
      ],
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("기본 정보", style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildInput("이름", true),
            const SizedBox(width: 24),
            _buildPhoto(),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildHandphone(),
            const SizedBox(width: 24),
            _buildIDCard(),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildNation(),
            const SizedBox(width: 24),
            _buildInput("주소", true),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildLanguage("제1언어", true),
            const SizedBox(width: 24),
            _buildLanguage("제2언어", false),
          ],
        ),
        const SizedBox(height: 24),
        _buildMultiInput("자기소개"),
      ],
    );
  }

  Widget _buildCompanyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('회사 정보', style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        InkWell(
          onTap: () => showCompanySearchDialog(),
          child: Container(
            width: 353,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusStyle.roundedBorder12,
                border: Border.all(color: appTheme.grayScale3),
                color: appTheme.white),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("", style: CustomTextStyles.bodyMediumGray),
                CustomImageView(
                  imagePath: IconConstant.search,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _buildCompanyAddDownload(),
      ],
    );
  }

  Row _buildCompanyAddDownload() {
    return Row(
      children: [
        Text(
          "회사 정보 새로 등록하기 ",
          style: CustomTextStyles.labelLargeGray,
          overflow: TextOverflow.ellipsis,
        ),
        CustomImageView(
          imagePath: IconConstant.add,
          onTap: () {
            showCompanyAddDialog();
          },
        )
      ],
    );
  }

  Future<void> showCompanyAddDialog() async {
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
          width: 800,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "회사 정보 새로 등록하기",
                    style: CustomTextStyles.bodyMediumBlack,
                  ),
                  CustomImageView(
                    imagePath: IconConstant.close,
                    onTap: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      _buildInput("회사 이름", true),
                      const SizedBox(width: 24),
                      _buildInput("대표자", true),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildInput("사업자 번호", true),
                      const SizedBox(width: 24),
                      _buildInput("전화", true),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildInput("담당자 명", true),
                      const SizedBox(width: 24),
                      _buildInput("담당자 이메일", true),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildInput("담당자 전화번호", true),
                      const SizedBox(width: 24),
                      _buildInput("주소", true),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                          text: '저장',
                          buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
                          buttonStyle: CustomButtonStyles.fillPrimary,
                          margin: const EdgeInsets.only(right: 16),
                          width: 90,
                          height: 44,
                          onPressed: () async {
                            Get.back();
                          }),
                      CustomElevatedButton(
                          text: '취소',
                          buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
                          buttonStyle: CustomButtonStyles.fillRedTransparent,
                          width: 90,
                          height: 44,
                          onPressed: () async {
                            Get.back();
                          }),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildIDCard() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(text: "신분증 ", style: CustomTextStyles.labelLargeBlack),
              TextSpan(text: "*", style: TextStyle(color: appTheme.red)),
            ])),
            const SizedBox(height: 8),
            Container(
              width: 353,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  border: Border.all(color: appTheme.grayScale3),
                  color: appTheme.white),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 280,
                    child: Text(
                      '최대 10메가 (.jpg)',
                      style: CustomTextStyles.bodyMediumGray,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomImageView(
                    imagePath: IconConstant.upload,
                    onTap: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildPhoto() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(text: "사진 ", style: CustomTextStyles.labelLargeBlack),
              TextSpan(text: "*", style: TextStyle(color: appTheme.red)),
            ])),
            const SizedBox(height: 8),
            Container(
              width: 353,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  border: Border.all(color: appTheme.grayScale3),
                  color: appTheme.white),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 280,
                    child: Text(
                      '300 x 300 최대 10메가 (.jpg)',
                      style: CustomTextStyles.bodyMediumGray,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomImageView(
                    imagePath: IconConstant.upload,
                    onTap: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildHandphone() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "핸드폰 번호 ", style: CustomTextStyles.labelLargeBlack),
              TextSpan(text: "*", style: TextStyle(color: appTheme.red))
            ])),
            const SizedBox(height: 8),
            Container(
              width: 353,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  border: Border.all(color: appTheme.grayScale3),
                  color: appTheme.white),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 280,
                    child: Text(
                      '인증 하기',
                      style: CustomTextStyles.bodyMediumGray,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomImageView(
                    imagePath: IconConstant.aabbcc,
                    onTap: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "국가 ",
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: "*", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        Container(
          width: 353,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: appTheme.grayScale3,
            ),
            color: appTheme.white,
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: DropdownButton<Nation>(
            hint: Text('Select Option', style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value: null,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (Nation? newValue) {
              if (newValue != null) {
                // controller.selectedMaster.value = newValue;
              }
            },
            items: controller.nationLabels
                .map<DropdownMenuItem<Nation>>((Nation value) {
              return DropdownMenuItem<Nation>(
                value: value,
                child: Text(
                  value.displayName,
                  style: CustomTextStyles.bodyMediumBlack,
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildLanguage(String text, bool essential) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "$text ",
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(
              text: essential ? "*" : "", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        Container(
          width: 353,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: appTheme.grayScale3,
            ),
            color: appTheme.white,
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: DropdownButton<ContentLanguage>(
            hint: Text('Select Option', style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value: null,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentLanguage? newValue) {},
            items: controller.languageLabels
                .map<DropdownMenuItem<ContentLanguage>>(
                    (ContentLanguage value) {
              return DropdownMenuItem<ContentLanguage>(
                value: value,
                child: Text(
                  value.displayName,
                  style: CustomTextStyles.bodyMediumBlack,
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Column _buildMultiInput(String text, {String? hint}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "$text ",
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: "*", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        CustomTextFormField(
          textInputAction: TextInputAction.newline,
          width: 730,
          textInputType: TextInputType.multiline,
          maxLines: 6,
          // controller: controller.introController,
          hintText: hint ?? "Input Text".tr,
          contentPadding: const EdgeInsets.all(16),
        ),
      ],
    );
  }

  Column _buildEmail(String text, bool essential, {String? hint}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "$text ",
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(
              text: essential ? "*" : "", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        Container(
          width: 353,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder12,
              border: Border.all(color: appTheme.grayScale3),
              color: appTheme.grayScale2),
          padding: const EdgeInsets.all(16),
          child:
              Text("mrlee@nodamen.com", style: CustomTextStyles.bodyMediumGray),
        ),
      ],
    );
  }

  Column _buildInput(String text, bool essential, {String? hint}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "$text ",
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(
              text: essential ? "*" : "", style: TextStyle(color: appTheme.red))
        ])),
        const SizedBox(height: 8),
        CustomTextFormField(
            // controller: controller.titleController,
            width: 353,
            hintText: hint ?? "Input text",
            hintStyle: CustomTextStyles.bodyMediumGray,
            validator: (value) {
              if (value == null) {
                return "필수 입력 항목입니다.".tr;
              }
              return null;
            },
            contentPadding:
                const EdgeInsets.only(left: 16, top: 17, bottom: 17),
            filled: true),
      ],
    );
  }

  Row _buildSaveNCancel(GlobalKey<FormState> formKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomElevatedButton(
          text: '저장',
          buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
          buttonStyle: CustomButtonStyles.fillPrimary,
          width: 90,
          height: 44,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              controller.onSave();
            }
          },
        ),
        CustomElevatedButton(
          text: '취소',
          buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
          buttonStyle: CustomButtonStyles.fillRedTransparent,
          margin: const EdgeInsets.only(left: 16),
          width: 90,
          height: 44,
          onPressed: () => controller.onCancel(),
        ),
      ],
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
            child: Text(
              "마스터 목록",
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () {
              if (SideMenuController.to.isActiveSubItem("마스터 목록")) {
                Get.offAllNamed(AppRoutes.masterManage);
              } else {
                Get.offAllNamed(AppRoutes.inactiveMasterManage);
              }
            }),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        InkWell(
          child: Text(
            "마스터 상세",
            style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: appTheme.skyBlue,
            ),
          ),
          onTap: () => controller.onMemberDatail(),
        ),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text("마스터 정보 수정", style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "마스터 정보 수정",
      searchShow: false,
      viewCount: false,
    );
  }
}

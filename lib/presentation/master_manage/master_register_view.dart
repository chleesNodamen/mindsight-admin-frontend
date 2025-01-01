import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/account_role.dart';
import 'package:mindsight_admin_page/constants/enum/contry.dart';
import 'package:mindsight_admin_page/function/show_company_search_dialog.dart';
import 'package:mindsight_admin_page/presentation/master_manage/master_register_controller.dart';

class MasterRegisterView extends GetWidget<MasterRegisterController> {
  const MasterRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                      Account.isLogined ? const SideMenu() : _buildLogo(),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 48, 40, 48),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildTitle(),
                                    Visibility(
                                      visible: Account.isLogined,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 16),
                                          _buildSubMenu(),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    _buildAccountInfo(),
                                    const SizedBox(height: 32),
                                    _buildBasicInfo(),
                                    const SizedBox(height: 32),
                                    Visibility(
                                      visible: Account.isLogined,
                                      child: Column(
                                        children: [
                                          _buildCompanyInfo(),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    _buildSaveNCancel(_formKey)
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

  Widget _buildLogo() {
    return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder16,
              color: appTheme.skyBlue,
            ),
            width: 297,
            // height: 912,
            child: ListView(children: [
              Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(
                  height: 58,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8, left: 24),
                        child: CustomImageView(
                          imagePath: "assets/logo.png",
                          width: 154,
                          height: 24,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          AccountRole.master.displayName,
                          style: CustomTextStyles.labelLargeWhite,
                        ),
                      ),
                      const SizedBox(width: 69),
                    ])
              ])
            ])));
  }

  Widget _buildAccountInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("계정 정보".tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Row(
          children: [
            BuildInput(
              label: "이메일 주소 (아이디)".tr,
              essential: true,
              textController: controller.emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(width: 24),
            BuildInput(
                label: "닉네임".tr,
                essential: true,
                textController: controller.nicknameController),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            BuildInput(
                label: "비밀번호".tr,
                essential: true,
                textController: controller.passwordController),
            const SizedBox(width: 24),
            BuildInput(
                label: "비밀번호 확인".tr,
                essential: true,
                textController: controller.passwordCofirmController),
          ],
        ),
      ],
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("기본 정보".tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        Row(
          children: [
            BuildInput(
                label: "이름".tr,
                essential: false,
                textController: controller.nameController),
            const SizedBox(width: 24),
            BuildInput(
              label: "핸드폰 번호".tr,
              essential: false,
              textController: controller.phoneNumberController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            PickFileFormField(
              labelText: "사진".tr,
              toolTip: "프로필로 사용되는 이미지로 되도록이면 얼굴 사진일수록 회원들에게 신뢰를 줄 수 있습니다".tr,
              essential: true,
              hintText: "(.jpg)",
              fileExtension: FileExtension.jpg.keywordName,
              initialUrl: controller.photoUrl.value,
              onFilePicked: (pickedFile) {
                controller.onPickPhoto(pickedFile);
              },
            ),
            const SizedBox(width: 24),
            PickFileFormField(
              labelText: "신분증".tr,
              essential: false,
              hintText: "(.jpg)",
              fileExtension: FileExtension.jpg.keywordName,
              initialUrl: controller.idPhotoUrl.value,
              onFilePicked: (pickedFile) {
                controller.onPickIdPhoto(pickedFile);
              },
              // showError: controller.photoFileError.value,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildNation(),
            const SizedBox(width: 24),
            BuildInput(
                label: "주소".tr,
                essential: false,
                textController: controller.addressController),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildLanguage("제1언어".tr, true, controller.selectedPrimaryLanguage),
            const SizedBox(width: 24),
            _buildLanguage(
                "제2언어".tr, false, controller.selectedSecondaryLanguage),
          ],
        ),
        const SizedBox(height: 24),
        _buildMultiInput("자기소개".tr),
      ],
    );
  }

  Widget _buildCompanyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("회사 정보".tr, style: CustomTextStyles.bodyMediumBlack),
        const SizedBox(height: 24),
        InkWell(
          onTap: () async {
            var result = await showCompanySearchDialog();
            if (result != null) {
              controller.selectedCompany.value = result;
            }
          },
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
                Text(
                    controller.selectedCompany.value == null
                        ? ""
                        : controller.selectedCompany.value!["name"]!,
                    style: CustomTextStyles.bodyMediumGray),
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
        _buildCompanyAddButton(),
      ],
    );
  }

  Row _buildCompanyAddButton() {
    return Row(
      children: [
        Text(
          "회사 정보 새로 등록하기".tr,
          style: CustomTextStyles.labelLargeGray,
          overflow: TextOverflow.ellipsis,
        ),
        CustomImageView(
          imagePath: IconConstant.add,
          onTap: () {
            Get.offAllNamed(AppRoutes.companyManage);
            // showCompanyAddDialog();
          },
        )
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
              text: "국가".tr,
              style: CustomTextStyles.labelLargeBlack
                  .copyWith(fontWeight: FontWeight.w600)),
          TextSpan(text: " *", style: TextStyle(color: appTheme.red))
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
          child: DropdownButton<Contry>(
            hint: Text("Select Option".tr,
                style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value: controller.selectedContry.value,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (Contry? newValue) {
              if (newValue != null) {
                controller.selectedContry.value = newValue;
                Logger.info(controller.selectedContry.value);
              }
            },
            items: controller.contryLabels
                .map<DropdownMenuItem<Contry>>((Contry value) {
              return DropdownMenuItem<Contry>(
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

  Widget _buildLanguage(
      String text, bool essential, Rx<ContentLanguage?> selectedLanguage) {
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
            hint: Text("Select Option".tr,
                style: CustomTextStyles.bodyMediumGray),
            isExpanded: true,
            value: selectedLanguage.value,
            underline: Container(),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
            borderRadius: BorderRadiusStyle.roundedBorder12,
            // icon: const Icon(Icons.),
            elevation: 16,
            onChanged: (ContentLanguage? newValue) {
              selectedLanguage.value = newValue;
            },
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
          controller: controller.introController,
          textInputAction: TextInputAction.newline,
          width: 730,
          textInputType: TextInputType.multiline,
          maxLines: 6,
          hintText: hint ?? "입력하세요".tr,
          contentPadding: const EdgeInsets.all(16),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "필수 입력 항목입니다.".tr;
            }
            return null;
          },
        ),
      ],
    );
  }

  Row _buildSaveNCancel(GlobalKey<FormState> formKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomElevatedButton(
          text: '승인 요청'.tr,
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
          text: '취소'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
          buttonStyle: CustomButtonStyles.fillRedTransparent,
          margin: const EdgeInsets.only(left: 16),
          width: 90,
          height: 44,
          onPressed: () => Account.isLogined
              ? Get.offAllNamed(AppRoutes.masterManage)
              : Get.offAllNamed(AppRoutes.auth),
        ),
      ],
    );
  }

  Row _buildSubMenu() {
    return Row(
      children: [
        InkWell(
            child: Text(
              "마스터 목록".tr,
              style: CustomTextStyles.bodyMediumSkyBlue.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: appTheme.skyBlue,
              ),
            ),
            onTap: () {
              if (SideMenuController.to.isActiveSubItem("마스터 목록".tr)) {
                Get.offAllNamed(AppRoutes.masterManage);
              } else {
                Get.offAllNamed(AppRoutes.inactiveMasterManage);
              }
            }),
        CustomImageView(
          imagePath: IconConstant.arrowRight,
        ),
        Text("마스터 신규 등록".tr, style: CustomTextStyles.bodyMediumGray),
      ],
    );
  }

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "마스터 신규 등록".tr,
      searchShow: false,
      viewCount: false,
    );
  }
}

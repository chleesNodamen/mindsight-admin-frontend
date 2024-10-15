import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings_controller.dart';

class AdminSettingsView extends GetWidget<AdminSettingsController> {
  const AdminSettingsView({super.key});

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
                                  buildTopBar(),
                                  const SizedBox(height: 32),
                                  _buildFirstContainer(),
                                  const SizedBox(height: 16),
                                  _buildSecondContainer(),
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

  TobBarSearch buildTopBar() {
    return TobBarSearch(
      name: "내 계정 관리",
      searchShow: false,
      memberShow: false,
      memberCount: 0,
      searchText: '',
      viewNumber: 0,
      viewCount: false,
    );
  }

  Widget _buildFirstContainer() {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      // height: 340,
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("관리자 기본 정보", style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('아이디', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.adminMyDataModel.email ?? "-",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('담당 부서', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.adminMyDataModel.department ?? "-",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('권한', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.adminMyDataModel.role ?? "-",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          Divider(height: 1, thickness: 1, color: appTheme.grayScale2),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('담당자', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.adminMyDataModel.manager ?? "-",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('연락처', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.adminMyDataModel.phone ?? "-",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이메일주소', style: CustomTextStyles.labelMediumGray),
                  const SizedBox(height: 16),
                  Text(controller.adminMyDataModel.adminEmail ?? "-",
                      style: CustomTextStyles.bodyLargeBlack),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadiusStyle.roundedBorder12,
                color: appTheme.background),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('최근 활동', style: CustomTextStyles.labelLargeGray),
                const SizedBox(
                  width: 8,
                ),
                Container(
                    height: 14,
                    width: 1,
                    decoration: BoxDecoration(color: appTheme.grayScale3)),
                const SizedBox(
                  width: 8,
                ),
                Text(
                    controller.adminMyDataModel.lastActivity != null
                        ? DateFormat('yyyy-MM-dd-HH:mm:ss')
                            .format(controller.adminMyDataModel.lastActivity!)
                        : "-",
                    style: CustomTextStyles.labelLargeGray),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildSecondContainer() {
    return Container(
        decoration: BoxDecoration(
          color: appTheme.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        // height: 1016,
        width: double.infinity,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('비밀번호 변경', style: CustomTextStyles.labelLargeBlack),
            const SizedBox(height: 24),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('현재 비밀번호', style: CustomTextStyles.labelLargeBlack),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                        controller: controller.oldPasswordController,
                        width: 353,
                        hintText: "Input text",
                        hintStyle: CustomTextStyles.bodyMediumGray,
                        suffix: InkWell(
                            onTap: () {
                              controller.isShowPasswordOne.value =
                                  !controller.isShowPasswordOne.value;
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(30, 16, 16, 16),
                                child: CustomImageView(
                                    imagePath:
                                        controller.isShowPasswordOne.value
                                            ? IconConstant.visibilityFalse
                                            : IconConstant.visibilityTrue,
                                    color: controller.isShowPasswordOne.value
                                        ? appTheme.grayScale5
                                        : appTheme.black,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize))),
                        suffixConstraints: const BoxConstraints(maxHeight: 56),
                        onChange: (value) {
                          // controller.checkPasswordValid(value, false);
                        },
                        // validator: (value) {
                        //   if (value == null ||
                        //       !controller.checkPasswordValid(value, true) ||
                        //       !controller.adminPasswordModel.isSuccess) {
                        //     return "Code is invalid or has expired".tr;
                        //   }
                        //   return null;
                        // },
                        obscureText: controller.isShowPasswordOne.value,
                        contentPadding: const EdgeInsets.only(
                            left: 16, top: 17, bottom: 17),
                        // focusedBorderDecoration:
                        //     TextFormFieldStyleHelper.outlineSkyBlue,
                        filled: true),
                  ],
                ),
                const SizedBox(width: 24),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('변경할 비밀번호', style: CustomTextStyles.labelLargeBlack),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                        controller: controller.newPasswordController,
                        width: 353,
                        hintText: "Input text",
                        hintStyle: CustomTextStyles.bodyMediumGray,
                        suffix: InkWell(
                            onTap: () {
                              controller.isShowPasswordTwo.value =
                                  !controller.isShowPasswordTwo.value;
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(30, 16, 16, 16),
                                child: CustomImageView(
                                    imagePath:
                                        controller.isShowPasswordTwo.value
                                            ? IconConstant.visibilityFalse
                                            : IconConstant.visibilityTrue,
                                    color: appTheme.grayScale5,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize))),
                        suffixConstraints: const BoxConstraints(maxHeight: 56),
                        onChange: (value) {
                          // controller.checkPasswordValid(value, false);
                        },
                        // validator: (value) {
                        //   if (value == null ||
                        //       !controller.checkPasswordValid(value, true) ||
                        //       !controller.adminPasswordModel.isSuccess) {
                        //     return "Code is invalid or has expired".tr;
                        //   }
                        //   return null;
                        // },
                        obscureText: controller.isShowPasswordTwo.value,
                        contentPadding: const EdgeInsets.only(
                            left: 16, top: 17, bottom: 17),
                        // focusedBorderDecoration:
                        //     TextFormFieldStyleHelper.outlineSkyBlue,
                        filled: true),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(
              text: '저장',
              buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
              buttonStyle: CustomButtonStyles.fillPrimary,
              width: 90,
              height: 44,
              onPressed: controller.onContinue,
            )
          ],
        ));
  }
}

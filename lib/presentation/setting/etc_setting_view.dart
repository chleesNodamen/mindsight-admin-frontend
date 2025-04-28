import 'package:flutter/cupertino.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/presentation/setting/etc_setting_controller.dart';

class EtcSettingView extends GetWidget<EtcSettingController> {
  const EtcSettingView({super.key});

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
                                  _buildAlarm(),
                                  const SizedBox(height: 32),
                                  _buildLanguage(),
                                  const SizedBox(height: 32),
                                  _buildSaveNCancel(),
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

  TobBarSearch _buildTitle() {
    return TobBarSearch(
      name: "Notifications and Other Settings".tr,
      searchShow: false,
      viewCount: false,
      searchText: "",
    );
  }

  Widget _buildAlarm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder12,
        color: appTheme.white,
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Notification".tr, style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 32),
          Text("All Notifications".tr, style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 39,
                height: 24,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: CupertinoSwitch(
                    value: controller.receiveAllAlarm.value,
                    onChanged: controller.onAllAlarmToggle,
                    activeTrackColor: appTheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text("I receive all notifications.".tr,
                  style: CustomTextStyles.bodyMediumBlack),
            ],
          ),
          Divider(height: 49, thickness: 1, color: appTheme.grayScale2),
          Text("Select Notification Type".tr,
              style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 12),
          Wrap(
            spacing: 32,
            children: [
              _buildCheckbox("Email".tr, controller.emailAlarm.value,
                  controller.onEmailToggle),
              _buildCheckbox(
                  "SMS".tr, controller.smsAlarm.value, controller.onSmsToggle),
            ],
          ),
          Divider(height: 49, thickness: 1, color: appTheme.grayScale2),
          Text("Select Notification Items".tr,
              style: CustomTextStyles.labelLargeBlack),
          const SizedBox(height: 12),
          Wrap(
            spacing: 32,
            runSpacing: 16,
            children: [
              _buildCheckbox("Notice".tr, controller.noticeAlarm.value,
                  controller.onNoticeToggle),
              _buildCheckbox("Inquiries and Answers".tr,
                  controller.qnaAlarm.value, controller.onQnaToggle),
              _buildCheckbox("Content Approval and Modification".tr,
                  controller.contentAlarm.value, controller.onContentToggle),
              _buildCheckbox("Settlement".tr, controller.settlementAlarm.value,
                  controller.onSettlementToggle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // 원하는 둥글기
          ),
          side: BorderSide(color: appTheme.grayScale3),
          checkColor: Colors.white,
          activeColor: appTheme.primary,
        ),
        const SizedBox(width: 10),
        Text(title.tr, style: CustomTextStyles.bodyMediumBlack),
      ],
    );
  }

  Widget _buildLanguage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder12,
        color: appTheme.white,
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("언어".tr, style: CustomTextStyles.labelLargeBlack),
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
              hint: Text('Select Option'.tr,
                  style: CustomTextStyles.bodyMediumGray),
              isExpanded: true,
              value: controller.selectedLanguage,
              underline: Container(),
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
              borderRadius: BorderRadiusStyle.roundedBorder12,
              elevation: 16,
              onChanged: (ContentLanguage? newValue) {
                controller.onLanguage(newValue);
              },
              items: <ContentLanguage>[
                ContentLanguage.english,
                ContentLanguage.korean
              ].map<DropdownMenuItem<ContentLanguage>>((ContentLanguage value) {
                return DropdownMenuItem<ContentLanguage>(
                  value: value,
                  child: Text(
                    value.displayName.tr,
                    style: CustomTextStyles.bodyMediumBlack,
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSaveNCancel() {
    return Row(
      children: [
        CustomElevatedButton(
          text: 'Save'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
          buttonStyle: CustomButtonStyles.fillPrimary,
          height: 44,
          margin: const EdgeInsets.only(right: 16),
          onPressed: () {
            controller.onSave();
          },
        ),
        CustomElevatedButton(
          text: 'Cancel'.tr,
          buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
          buttonStyle: CustomButtonStyles.fillRedTransparent,
          height: 44,
          onPressed: () => Get.offAllNamed(AppRoutes.contentManage),
        ),
      ],
    );
  }
}

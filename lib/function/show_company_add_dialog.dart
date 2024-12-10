import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindsight_admin_page/constants/icon_constant.dart';
import 'package:mindsight_admin_page/function/show_simple_message.dart';
import 'package:mindsight_admin_page/theme/app_decoration.dart';
import 'package:mindsight_admin_page/theme/custom_button_style.dart';
import 'package:mindsight_admin_page/theme/custom_text_style.dart';
import 'package:mindsight_admin_page/theme/theme_helper.dart';
import 'package:mindsight_admin_page/widgets/custom_elevated_button.dart';
import 'package:mindsight_admin_page/widgets/custom_image_view.dart';
import 'package:mindsight_admin_page/widgets/custom_text_form_field.dart';

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
                        text: "승인 요청",
                        buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
                        buttonStyle: CustomButtonStyles.fillPrimary,
                        margin: const EdgeInsets.only(right: 16),
                        width: 90,
                        height: 44,
                        onPressed: () async {
                          Get.back();

                          showSimpleMessage(
                              "승인 요청 되었습니다. 최대 2영업일이 소요 됩니다.\n승인이 완료 되면 메일과 푸쉬메세지로 알림 드리겠습니다.");
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
          contentPadding: const EdgeInsets.only(left: 16, top: 17, bottom: 17),
          filled: true),
    ],
  );
}

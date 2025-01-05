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
                  "Register new company info".tr,
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
                    _buildInput("Company name".tr, true),
                    const SizedBox(width: 24),
                    _buildInput("Representative".tr, true),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildInput("Business number".tr, true),
                    const SizedBox(width: 24),
                    _buildInput("Phone".tr, true),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildInput("Contact name".tr, true),
                    const SizedBox(width: 24),
                    _buildInput("Contact email".tr, true),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildInput("Contact phone".tr, true),
                    const SizedBox(width: 24),
                    _buildInput("Address".tr, true),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                        text: "Approval request".tr,
                        buttonTextStyle: CustomTextStyles.bodyMediumWhiteBold,
                        buttonStyle: CustomButtonStyles.fillPrimary,
                        margin: const EdgeInsets.only(right: 16),
                        // width: 90,
                        height: 44,
                        onPressed: () async {
                          Get.back();

                          showSimpleMessage(
                              "Approval requested. It may take up to 2 business days.\nYou will be notified by email upon approval."
                                  .tr);
                        }),
                    CustomElevatedButton(
                        text: "Cancel".tr,
                        buttonTextStyle: CustomTextStyles.bodyMediumRedBold,
                        buttonStyle: CustomButtonStyles.fillRedTransparent,
                        // width: 90,
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
          hintText: hint ?? "Input text".tr,
          hintStyle: CustomTextStyles.bodyMediumGray,
          validator: (value) {
            if (value == null) {
              return "This field is required.".tr;
            }
            return null;
          },
          contentPadding: const EdgeInsets.only(left: 16, top: 17, bottom: 17),
          filled: true),
    ],
  );
}

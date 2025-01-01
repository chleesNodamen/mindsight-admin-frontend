import 'package:flutter/material.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/theme/custom_text_style.dart';
import 'package:mindsight_admin_page/theme/theme_helper.dart';
import 'package:mindsight_admin_page/widgets/custom_text_form_field.dart';

class BuildInput extends StatelessWidget {
  final String label;
  final bool essential;
  final TextEditingController textController;
  final String? hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const BuildInput({
    super.key,
    required this.label,
    required this.essential,
    required this.textController,
    this.hint,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "$label ",
                style: CustomTextStyles.labelLargeBlack.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: essential ? "*" : "",
                style: TextStyle(color: appTheme.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: textController,
          width: 353,
          hintText: hint ?? "입력하세요".tr,
          hintStyle: CustomTextStyles.bodyMediumGray,
          validator: validator ??
              (value) {
                if (essential) {
                  if (value == null || value.isEmpty) {
                    return "필수 입력 항목입니다.".tr;
                  }
                }
                return null;
              },
          textInputType: keyboardType,
          contentPadding: const EdgeInsets.only(left: 16, top: 17, bottom: 17),
          filled: true,
        ),
      ],
    );
  }
}

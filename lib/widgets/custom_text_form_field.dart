import 'package:mindsight_admin_page/app_export.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.alignment,
      required this.width,
      this.scrollPadding,
      this.controller,
      this.focusNode,
      this.autofocus = true,
      this.textStyle,
      this.textAlign,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.maxLength,
      this.hintText,
      this.hintStyle,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.borderDecoration,
      this.disabledBorderDecoration,
      this.fillColor,
      this.filled = true,
      this.enabled,
      this.validator,
      this.onChange});

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;
  final TextAlign? textAlign;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;
  final int? maxLength;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;
  final InputBorder? disabledBorderDecoration;

  final Color? fillColor;

  final bool? filled;
  final bool? enabled;

  final FormFieldValidator<String>? validator;
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            controller: controller,
            focusNode: focusNode ?? FocusNode(),
            autofocus: autofocus!,
            style: textStyle ?? CustomTextStyles.bodyMediumBlack,
            textAlign: textAlign ?? TextAlign.start,
            obscureText: obscureText!,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            maxLength: maxLength,
            maxLines: maxLines ?? 1,
            enabled: enabled,
            decoration: decoration,
            validator: validator,
            onChanged: (value) {
              onChange?.call(value);
            }),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.bodyMediumGray,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix ??
            const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.error, size: 24)),
        suffixIconConstraints: suffixConstraints,
        suffixIconColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return const Color.fromARGB(0, 76, 175, 80);
          }
          if (states.contains(MaterialState.error)) {
            return appTheme.alertNegative;
          }
          return const Color.fromARGB(0, 76, 175, 80);
        }),
        isDense: true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
        fillColor: fillColor ??
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.focused)) {
                return appTheme.white;
              }
              if (states.contains(MaterialState.error)) {
                return const Color.fromARGB(255, 255, 231, 231);
              }
              return appTheme.white;
            }),
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: appTheme.grayScale3,
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: appTheme.grayScale3,
                width: 1,
              ),
            ),
        disabledBorder: disabledBorderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: appTheme.grayScale3,
                width: 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: appTheme.grayScale3,
                width: 2,
              ),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: appTheme.red,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: appTheme.red,
            width: 2,
          ),
        ),
        errorStyle: TextStyle(
            color: appTheme.red, fontSize: 12, fontWeight: FontWeight.w500),
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlineGrayScale3 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: appTheme.grayScale3,
          width: 1,
        ),
      );
}

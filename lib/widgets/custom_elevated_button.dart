// import 'package:mindsight_admin_page/app_export.dart';

// class CustomElevatedButton extends BaseButton {
//   CustomElevatedButton({
//     Key? key,
//     this.decoration,
//     this.leftIcon,
//     this.rightIcon,
//     EdgeInsets? margin,
//     VoidCallback? onPressed,
//     ButtonStyle? buttonStyle,
//     Alignment? alignment,
//     TextStyle? buttonTextStyle,
//     bool? isDisabled,
//     double? height,
//     double? width,
//     required String text,
//   }) : super(
//           text: text,
//           onPressed: onPressed,
//           buttonStyle: buttonStyle,
//           isDisabled: isDisabled,
//           buttonTextStyle: buttonTextStyle,
//           height: height,
//           width: width,
//           alignment: alignment,
//           margin: margin,
//         );

//   final BoxDecoration? decoration;

//   final Widget? leftIcon;

//   final Widget? rightIcon;

//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//             alignment: alignment ?? Alignment.center,
//             child: buildElevatedButtonWidget,
//           )
//         : buildElevatedButtonWidget;
//   }

//   Widget get buildElevatedButtonWidget => Container(
//         height: height, // ?? 56,
//         width: width, // ?? double.infinity,
//         margin: margin,
//         decoration: decoration,
//         child: ElevatedButton(
//           style: buttonStyle,
//           onPressed: isDisabled ?? false ? null : onPressed ?? () {},
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               leftIcon ?? const SizedBox.shrink(),
//               Text(
//                 text,
//                 style: buttonTextStyle ?? CustomTextStyles.bodyMediumWhiteBold,
//               ),
//               rightIcon ?? const SizedBox.shrink(),
//             ],
//           ),
//         ),
//       );
// }

// import 'package:mindsight_admin_page/app_export.dart';

// class CustomElevatedButton extends BaseButton {
//   CustomElevatedButton({
//     Key? key,
//     this.decoration,
//     this.leftIcon,
//     this.rightIcon,
//     EdgeInsets? margin,
//     VoidCallback? onPressed,
//     ButtonStyle? buttonStyle,
//     Alignment? alignment,
//     TextStyle? buttonTextStyle,
//     bool? isDisabled,
//     double? height,
//     double? width,
//     required String text,
//   }) : super(
//           text: text,
//           onPressed: onPressed,
//           buttonStyle: buttonStyle,
//           isDisabled: isDisabled,
//           buttonTextStyle: buttonTextStyle,
//           height: height,
//           width: width,
//           alignment: alignment,
//           margin: margin,
//         );

//   final BoxDecoration? decoration;
//   final Widget? leftIcon;
//   final Widget? rightIcon;

//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//             alignment: alignment ?? Alignment.center,
//             child: buildElevatedButtonWidget,
//           )
//         : buildElevatedButtonWidget;
//   }

//   Widget get buildElevatedButtonWidget => Container(
//         height: height,
//         width: width,
//         margin: margin,
//         decoration: decoration,
//         child: ElevatedButton(
//           style: buttonStyle ??
//               ElevatedButton.styleFrom(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 minimumSize:
//                     width == null ? Size.zero : Size(width!, height ?? 56),
//               ),
//           onPressed: isDisabled ?? false ? null : onPressed ?? () {},
//           child: Row(
//             mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               if (leftIcon != null) ...[
//                 leftIcon!,
//                 const SizedBox(width: 8),
//               ],
//               Text(
//                 text,
//                 style: buttonTextStyle ?? CustomTextStyles.bodyMediumWhiteBold,
//               ),
//               if (rightIcon != null) ...[
//                 const SizedBox(width: 8),
//                 rightIcon!,
//               ],
//             ],
//           ),
//         ),
//       );
// }

import 'package:mindsight_admin_page/app_export.dart';

class CustomElevatedButton extends BaseButton {
  CustomElevatedButton({
    Key? key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    EdgeInsets? margin,
    VoidCallback? onPressed,
    ButtonStyle? buttonStyle,
    Alignment? alignment,
    TextStyle? buttonTextStyle,
    bool? isDisabled,
    double? height,
    double? width,
    required String text,
  }) : super(
          text: text,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          isDisabled: isDisabled,
          buttonTextStyle: buttonTextStyle,
          height: height,
          width: width,
          alignment: alignment,
          margin: margin,
        );

  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
        height: height,
        width: width,
        margin: margin,
        decoration: decoration,
        child: ElevatedButton(
          style: buttonStyle ??
              ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                minimumSize:
                    width == null ? Size.zero : Size(width!, height ?? 56),
              ),
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leftIcon != null) ...[
                const SizedBox(width: 10),
                leftIcon!,
                const SizedBox(width: 8),
              ],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  text,
                  style:
                      buttonTextStyle ?? CustomTextStyles.bodyMediumWhiteBold,
                ),
              ),
              if (rightIcon != null) ...[
                const SizedBox(width: 8),
                rightIcon!,
                const SizedBox(width: 10),
              ],
            ],
          ),
        ),
      );
}

import 'package:mindsight_admin_page/app_export.dart';

class BuildInput extends StatelessWidget {
  final String label;
  final bool essential;
  final TextEditingController textController;
  final String? hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? toolTip; // 툴팁 텍스트를 받기 위한 변수

  const BuildInput({
    super.key,
    required this.label,
    required this.essential,
    required this.textController,
    this.hint,
    this.keyboardType,
    this.validator,
    this.toolTip, // 생성자에 toolTip 추가
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            const SizedBox(width: 4),
            toolTip == null
                ? const SizedBox.shrink()
                : Tooltip(
                    message: toolTip!,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    triggerMode: TooltipTriggerMode.tap,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Icon(
                      Icons.help_outline,
                      size: 20,
                    ),
                  ),
          ],
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: textController,
          width: 353,
          hintText: hint ?? "Input text".tr,
          hintStyle: CustomTextStyles.bodyMediumGray,
          validator: validator ??
              (value) {
                if (essential) {
                  if (value == null || value.isEmpty) {
                    return "This field is required.".tr;
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

// import 'package:mindsight_admin_page/app_export.dart';

// class BuildInput extends StatelessWidget {
//   final String label;
//   final bool essential;
//   final TextEditingController textController;
//   final String? hint;
//   final TextInputType? keyboardType;
//   final String? Function(String?)? validator;

//   const BuildInput({
//     super.key,
//     required this.label,
//     required this.essential,
//     required this.textController,
//     this.hint,
//     this.keyboardType,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: "$label ",
//                 style: CustomTextStyles.labelLargeBlack.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               TextSpan(
//                 text: essential ? "*" : "",
//                 style: TextStyle(color: appTheme.red),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         CustomTextFormField(
//           controller: textController,
//           width: 353,
//           hintText: hint ?? "Input text".tr,
//           hintStyle: CustomTextStyles.bodyMediumGray,
//           validator: validator ??
//               (value) {
//                 if (essential) {
//                   if (value == null || value.isEmpty) {
//                     return "This field is required.".tr;
//                   }
//                 }
//                 return null;
//               },
//           textInputType: keyboardType,
//           contentPadding: const EdgeInsets.only(left: 16, top: 17, bottom: 17),
//           filled: true,
//         ),
//       ],
//     );
//   }
// }

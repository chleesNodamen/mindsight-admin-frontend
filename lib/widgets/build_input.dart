import 'package:el_tooltip/el_tooltip.dart';
import 'package:mindsight_admin_page/app_export.dart';

class BuildInput extends StatelessWidget {
  final String label;
  final bool essential;
  final TextEditingController textController;
  final String? hint;
  final String? descriptions;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? toolTip; // 툴팁 텍스트를 받기 위한 변수
  final double? width;
  final bool? enabled;
  final TextStyle? textStyle;

  const BuildInput({
    super.key,
    required this.label,
    required this.essential,
    required this.textController,
    this.hint,
    this.width,
    this.descriptions,
    this.keyboardType,
    this.validator,
    this.toolTip, // 생성자에 toolTip 추가
    this.enabled,
    this.textStyle,
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
                : ElTooltip(
                    showModal: false,
                    showArrow: false,
                    distance: 0,
                    padding: EdgeInsets.zero,
                    content: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black, // ✅ 더 진한 말풍선 배경
                          borderRadius: BorderRadius.circular(6), // ✅ 모서리 둥글게
                        ),
                        child: Text("$toolTip",
                            style: CustomTextStyles.labelLargeWhite)),
                    position: ElTooltipPosition.topStart,
                    child: const Icon(Icons.info_outline, size: 20),
                  ),
            // Tooltip(
            //     message: toolTip!,
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            //     triggerMode: TooltipTriggerMode.tap, // 웹에선 hover 도 가능
            //     verticalOffset: 15,
            //     preferBelow: false,
            //     decoration: BoxDecoration(
            //       color: Colors.black, // ✅ 더 진한 말풍선 배경
            //       borderRadius: BorderRadius.circular(6), // ✅ 모서리 둥글게
            //     ),
            //     textStyle: CustomTextStyles.bodySmallWhite, // ✅ 밝은 글씨
            //     child: const Icon(
            //       Icons.info_outline,
            //       size: 20,
            //       color: Colors.grey,
            //     ),
            //   ),
          ],
        ),
        Visibility(
          visible: descriptions != null,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Text(
                "$descriptions",
                style: CustomTextStyles.labelLargeGray,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          enabled: enabled,
          controller: textController,
          width: width ?? 353,
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
          textStyle: textStyle,
        ),
      ],
    );
  }
}

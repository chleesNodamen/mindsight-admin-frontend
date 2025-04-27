import 'package:mindsight_admin_page/app_export.dart';

class VerifiedLabelValue extends StatelessWidget {
  final String label;
  final String value;
  final double? width;

  const VerifiedLabelValue({
    super.key,
    required this.label,
    required this.value,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.tr, style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                value,
                style: CustomTextStyles.bodyMediumBlack,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: appTheme.skyBlue),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "Verification complete".tr,
                  style: CustomTextStyles.labelSmallSkyBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

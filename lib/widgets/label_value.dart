import 'package:mindsight_admin_page/app_export.dart';

class LabelValue extends StatelessWidget {
  final String label;
  final String value;

  const LabelValue({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.tr, style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 16),
          Text(value, style: CustomTextStyles.bodyMediumBlack),
        ],
      ),
    );
  }
}

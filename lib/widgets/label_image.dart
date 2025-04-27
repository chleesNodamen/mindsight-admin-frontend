import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/widgets/image_actions_widget.dart';

class LabelImage extends StatelessWidget {
  final String label;
  final String url;
  final bool isCircular;

  const LabelImage({
    super.key,
    required this.label,
    required this.url,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 460,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.tr, style: CustomTextStyles.labelMediumGray),
          const SizedBox(height: 16),
          ImageActionsWidget(imageUrl: url, isCircular: isCircular),
        ],
      ),
    );
  }
}

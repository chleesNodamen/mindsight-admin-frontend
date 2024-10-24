import 'package:mindsight_admin_page/app_export.dart';

class CustomCheckboxWidget extends StatelessWidget {
  final bool isChecked;
  final String label;
  final ValueChanged<bool> onChanged;

  const CustomCheckboxWidget({
    super.key,
    required this.isChecked,
    required this.label,
    required this.onChanged,
  });

  void _handleTap() {
    onChanged(!isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                _handleTap();
              },
              activeColor: appTheme.skyBlue,
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (!states.contains(MaterialState.selected)) {
                  return Colors.transparent;
                }
                return null;
              }),
            ),
            const SizedBox(width: 8),
            Text(label,
                style: CustomTextStyles.bodyMediumBlack
                    .copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(width: 24)
          ],
        ),
      ),
    );
  }
}

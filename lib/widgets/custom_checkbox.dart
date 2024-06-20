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
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 17.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                _handleTap();
              },
              activeColor: Colors.blue,
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (!states.contains(MaterialState.selected)) {
                  return Colors.transparent;
                }
                return null;
              }),
            ),
            Text(label, style: CustomTextStyles.bodyMediumBlack),
            const SizedBox(width: 24)
          ],
        ),
      ),
    );
  }
}

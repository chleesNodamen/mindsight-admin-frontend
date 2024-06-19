import 'package:mindsight_admin_page/app_export.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function() onTap;

  const SideMenuItem({Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
      return HorizontalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
  }
}

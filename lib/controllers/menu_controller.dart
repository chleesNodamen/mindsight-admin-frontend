import 'package:mindsight_admin_page/app_export.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = DashboardViewDisplayName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case DashboardViewDisplayName:
        return _customIcon(Icons.trending_up, itemName);
      case MemberManageViewDisplayName:
        return _customIcon(Icons.drive_eta, itemName);
      case ContentManageViewDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case ActivityManageViewDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case TermsManageViewDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case AdminSettingsViewDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      // case authenticationPageDisplayName:
      //   return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22, color: appTheme.black);

    return Icon(
      icon,
      color: isHovering(itemName) ? appTheme.black : appTheme.grayScale10,
    );
  }
}

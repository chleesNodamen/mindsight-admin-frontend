import 'package:mindsight_admin_page/app_export.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = dashboardPageDisplayName.obs;

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
      case dashboardPageDisplayName:
        return _customIcon(Icons.trending_up, itemName);
      case memberManagePageDisplayName:
        return _customIcon(Icons.drive_eta, itemName);
      case contentManagePageDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case activityManagePageDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case termsManagePageDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case adminSettingsPageDisplayName:
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

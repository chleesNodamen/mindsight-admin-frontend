import 'package:mindsight_admin_page/app_export.dart';

class SubMenuItem {
  final String name;
  final String route;
  final Function inited;

  SubMenuItem(this.name, this.route, this.inited);
}

class SideMenuController extends GetxController {
  // static MenuController instance = Get.find();
  static SideMenuController get to => Get.find<SideMenuController>();

  var activeItem = dashboardPageDisplayName.obs;
  var hoverItem = "".obs;
  RxString activeSubItem = "".obs;
  Map<String, List<SubMenuItem>> subMenuItems = {
    memberManagePageDisplayName: [
      SubMenuItem(
          memberManagePageSubMenuDisplayName, AppRoutes.memberManage, () {}),
      SubMenuItem(inactiveMemberManagePageDisplayName,
          AppRoutes.inactiveMemberManage, () {}),
    ],
    contentManagePageDisplayName: [
      SubMenuItem(
          contentManageContentDisplayName, AppRoutes.contentManage, () {}),
      SubMenuItem(
          contentPracticeDisplayName, AppRoutes.contentPracticeManage, () {}),
      SubMenuItem(
          contentChallengeDisplayName, AppRoutes.contentChallengeManage, () {}),
    ],
    adminSettingsPageDisplayName: [
      SubMenuItem(myAccountManageDisplayName, AppRoutes.adminSettings, () {}),
      SubMenuItem(
          subAdminSettingsDisplayName, AppRoutes.subAdminSettings, () {}),
    ],
    settlementManagePageDisplayName: [
      SubMenuItem(settlementManagePageSubMenuDisplayName,
          AppRoutes.settlementManage, () {}),
      SubMenuItem(revenueShareManagePageDisplayName,
          AppRoutes.revenueShareManage, () {}),
    ],
  };

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  setActiveSubItem(String itemName) {
    activeSubItem = subMenuItems[itemName]![0].name.obs;
  }

  changeActiveSubItem(String itemName) {
    activeSubItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  onHoverSubItem(String itemName) {
    if (!isActiveSubItem(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

  isActiveSubItem(String itemName) => activeSubItem.value == itemName;

  Widget returnIconFor(String itemName, bool full) {
    switch (itemName) {
      case dashboardPageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.dashboard.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
      case memberManagePageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.member.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
      case contentManagePageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.content.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
      case activityManagePageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.feedback.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
      case adminSettingsPageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.settings.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
      case settlementManagePageDisplayName:
        return CustomImageView(
            imagePath:
                '${IconConstant.aabbcc.replaceAll('.svg', '')}${full ? '_full' : ''}.svg');
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

  bool hasSubMenu(String itemName) {
    return subMenuItems.containsKey(itemName);
  }
}

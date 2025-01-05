import 'package:mindsight_admin_page/app_export.dart';

class SubMenuItem {
  final String name;
  final String route;
  final Function inited;

  SubMenuItem(this.name, this.route, this.inited);
}

class SideMenuController extends GetxController {
  static SideMenuController get to => Get.find<SideMenuController>();

  var sideMenuItemRoutes = <MenuItem>[].obs;

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
    masterManagePageDisplayName: [
      SubMenuItem(
          masterManagePageSubMenuDisplayName, AppRoutes.masterManage, () {}),
      SubMenuItem(inactiveMasterManagePageDisplayName,
          AppRoutes.inactiveMasterManage, () {}),
    ],
    companyManagePageDisplayName: [
      SubMenuItem(
          companyManagePageSubMenuDisplayName, AppRoutes.companyManage, () {}),
      SubMenuItem(inactiveCompanyManagePageDisplayName,
          AppRoutes.inactiveCompanyManage, () {}),
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
      SubMenuItem(
          myAccountManagePageDisplayName, AppRoutes.masterDetails, () {}),
      SubMenuItem(
          myCompanyManagePageDisplayName, AppRoutes.companyManage, () {}),
      SubMenuItem(etcSettingPageDisplayName, AppRoutes.etcAdminSetting, () {}),
    ],
    settlementManagePageDisplayName: [
      SubMenuItem(settlementManagePageSubMenuDisplayName,
          AppRoutes.settlementManage, () {}),
      SubMenuItem(revenueShareManagePageDisplayName,
          AppRoutes.revenueShareManage, () {}),
    ],
  };

  @override
  void onInit() {
    super.onInit();
    setSideMenuItemRoutes();
  }

  // sideMenuItemRoutes 설정 메서드
  void setSideMenuItemRoutes() {
    sideMenuItemRoutes.value = Account.isAdmin
        ? [
            MenuItem(dashboardPageDisplayName, AppRoutes.dashboard, () {}),
            MenuItem(
                memberManagePageDisplayName, AppRoutes.memberManage, () {}),
            MenuItem(
                masterManagePageDisplayName, AppRoutes.masterManage, () {}),
            MenuItem(
                companyManagePageDisplayName, AppRoutes.companyManage, () {}),
            MenuItem(
                contentManagePageDisplayName, AppRoutes.contentManage, () {}),
            MenuItem(
                activityManagePageDisplayName, AppRoutes.activityManage, () {}),
            MenuItem(settlementManagePageDisplayName,
                AppRoutes.settlementManage, () {}),
            MenuItem(
                adminSettingsPageDisplayName, AppRoutes.masterDetails, () {}),
          ]
        : [
            MenuItem(
                contentManagePageDisplayName, AppRoutes.contentManage, () {}),
            MenuItem(settlementManagePageDisplayName,
                AppRoutes.settlementManage, () {}),
            MenuItem(
                adminSettingsPageDisplayName, AppRoutes.masterDetails, () {}),
          ];
  }

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
    if (itemName == dashboardPageDisplayName) {
      return CustomImageView(
        imagePath: IconConstant.dashboard,
        color: !full ? appTheme.white.withOpacity(0.8) : null,
      );
    } else if (itemName == memberManagePageDisplayName) {
      return CustomImageView(
        imagePath: IconConstant.member,
        color: !full ? appTheme.white.withOpacity(0.8) : null,
      );
    } else if (itemName == masterManagePageDisplayName) {
      return CustomImageView(
        imagePath: IconConstant.member,
        color: !full ? appTheme.white.withOpacity(0.8) : null,
      );
    } else if (itemName == companyManagePageDisplayName) {
      return CustomImageView(
        imagePath: IconConstant.company,
        color: !full ? appTheme.white.withOpacity(0.8) : null,
      );
    } else if (itemName == contentManagePageDisplayName) {
      return CustomImageView(
        imagePath: IconConstant.content,
        color: !full ? appTheme.white.withOpacity(0.8) : null,
      );
    } else if (itemName == activityManagePageDisplayName) {
      return CustomImageView(
        imagePath: IconConstant.feedback,
        color: !full ? appTheme.white.withOpacity(0.8) : null,
      );
    } else if (itemName == adminSettingsPageDisplayName) {
      return CustomImageView(
        imagePath: IconConstant.settings,
        color: !full ? appTheme.white.withOpacity(0.8) : null,
      );
    } else if (itemName == settlementManagePageDisplayName) {
      return CustomImageView(
        imagePath: IconConstant.receiptLong,
        color: !full ? appTheme.white.withOpacity(0.8) : null,
      );
    } else {
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

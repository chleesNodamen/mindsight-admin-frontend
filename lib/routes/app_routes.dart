const rootRoute = "/";

const dashboardPageRoute = "/dashboard";
const dashboardPageDisplayName = "Dashboard";

const memberManagePageRoute = "/member_manage";
const memberManagePageDisplayName = "Manage Members";

const contentManagePageDisplayName = "Manage Content";
const contentManagePageRoute = "/content_manage";

const activityManagePageDisplayName = "Manage Activity";
const activityManagePageRoute = "/activity_manage";

const termsManagePageDisplayName = "Manage Terms";
const termsManagePageRoute = "/terms_manage";

const adminSettingsPageDisplayName = "Admin Settings";
const adminSettingsPageRoute = "/admin_settings";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(dashboardPageDisplayName, dashboardPageRoute),
  MenuItem(memberManagePageDisplayName, memberManagePageRoute),
  MenuItem(contentManagePageDisplayName, contentManagePageRoute),
  MenuItem(activityManagePageDisplayName, activityManagePageRoute),
  MenuItem(adminSettingsPageDisplayName, adminSettingsPageRoute),
  MenuItem(termsManagePageDisplayName, termsManagePageRoute),
  // MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];

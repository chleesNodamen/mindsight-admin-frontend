import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/account_role.dart';

class MenuItem {
  final String name;
  final String route;
  final Function inited;

  MenuItem(this.name, this.route, this.inited);
}

const dashboardPageRoute = "/dashboard";
String dashboardPageDisplayName = "Dashboard";

const memberManagePageRoute = "/member_manage";
String memberManagePageDisplayName = "Member management";
String memberManagePageSubMenuDisplayName = "Member list";

const memberDetailsPageRoute = "/member_details";
String memberDetailsPageDisplayName = "Member details";

const memberEditPageRoute = "/member_edit";
String memberEditPageDisplayName = "Member info Edit";

const inactiveMemberManagePageRoute = "/inactive_member_manage";
String inactiveMemberManagePageDisplayName = "Inactive Member management";

const masterManagePageRoute = "/master_manage";
String masterManagePageDisplayName = "Master management";
String masterManagePageSubMenuDisplayName = "Master list";

const inactiveMasterManagePageRoute = "/inactive_master_manage";
String inactiveMasterManagePageDisplayName = "Inactive Master management";

const masterDetailsPageRoute = "/master_details";
String masterDetailsPageDisplayName = "Master Details";

const masterEditPageRoute = "/master_edit";
String masterEditPageDisplayName = "Master info edit";

const companyManagePageRoute = "/company_manage";
String companyManagePageDisplayName = "Company management";
String companyManagePageSubMenuDisplayName = "Company list";

const inactiveCompanyManagePageRoute = "/inactive_company_manage";
String inactiveCompanyManagePageDisplayName = "Inactive company management";

const contentManagePageRoute = "/content_manage";
String contentManagePageDisplayName = "Content management";
String contentManageContentDisplayName = "Content list";
String contentPracticeDisplayName = "Practice plan management";
String contentChallengeDisplayName = "Challenge management";

const activityManagePageRoute = "/activity_manage";
String activityManagePageDisplayName = "Activity record management";

const activityHistoryPageRoute = "/activity_history";
String activityHistoryPageDisplayName = "Activity record detail";

const settlementManagePageRoute = "/settlement_manage";
String settlementManagePageDisplayName = "Sales and Settlement";
String settlementManagePageSubMenuDisplayName = "Streaming settlement";

const revenueShareManagePageRoute = "/revenue_share_manage";
String revenueShareManagePageDisplayName = "CP Profit Margin";

const adminSettingsPageRoute = "/admin_settings";
String adminSettingsPageDisplayName = "Settings";
String myAccountManagePageDisplayName = "Manage My Account";
String myCompanyManagePageDisplayName = "Manage My Company";
String etcSettingPageDisplayName = "Other settings";
// const subAdminSettingsDisplayName = "Sub admin management";

const authenticationPageRoute = "/auth";
String authenticationPageDisplayName = "Log out";

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder16,
          color: appTheme.skyBlue,
        ),
        width: 297,
        // height: 912,
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 58,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 24),
                      child: CustomImageView(
                        imagePath: "assets/logo.png",
                        width: 154,
                        height: 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        Account.isAdmin
                            ? AccountRole.admin.displayName.tr
                            : AccountRole.master.displayName.tr,
                        style: CustomTextStyles.labelLargeWhite,
                      ),
                    ),
                    // const SizedBox(width: 69),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: SideMenuController.to.sideMenuItemRoutes
                  .map((item) => SideMenuItem(
                      itemName: item.name,
                      onTap: () {
                        if (!SideMenuController.to.isActive(item.name)) {
                          item.inited();
                          SideMenuController.to.changeActiveItemTo(item.name);
                          if (SideMenuController.to.hasSubMenu(item.name)) {
                            SideMenuController.to.setActiveSubItem(item.name);
                          }
                          Get.offAllNamed(item.route);
                        }
                      }))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder12,
                      color: appTheme.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: IconConstant.powerOn,
                          ),
                          Text(
                            "Login info".tr,
                            style: CustomTextStyles.titleSmallBlack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        Account.email,
                        style: CustomTextStyles.labelLargeBlack,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Account.signinTime,
                        style: CustomTextStyles.labelLargeGray,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomElevatedButton(
                        onPressed: () {
                          _logout();
                        },
                        height: 30,
                        text: 'Logout'.tr,
                        buttonTextStyle: CustomTextStyles.labelLargeBlack,
                        buttonStyle: CustomButtonStyles.fillBackground,
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _logout() async {
    Account.signOutSuccess();
    PrefUtils.to.setSigninId("");

    await Get.offAllNamed(AppRoutes.auth);
  }
}

import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/account_role.dart';

class MenuItem {
  final String name;
  final String route;
  final Function inited;

  MenuItem(this.name, this.route, this.inited);
}

String dashboardPageDisplayName = "Dashboard";
String memberManagePageDisplayName = "Member management";
String memberManagePageSubMenuDisplayName = "Member list";
String memberDetailsPageDisplayName = "Member details";
String memberEditPageDisplayName = "Member info Edit";
String inactiveMemberManagePageDisplayName = "Inactive Member management";
String masterManagePageDisplayName = "Master management";
String masterManagePageSubMenuDisplayName = "Master list";
String inactiveMasterManagePageDisplayName = "Inactive Master management";
String masterDetailsPageDisplayName = "Master Details";
String masterEditPageDisplayName = "Master info edit";
String companyManagePageDisplayName = "Company management";
String companyManagePageSubMenuDisplayName = "Company list";
String inactiveCompanyManagePageDisplayName = "Inactive company management";
String contentManagePageDisplayName = "Content management";
String contentManageContentDisplayName = "Content list";
String contentPracticeDisplayName = "Daily plan management";
String contentChallengeDisplayName = "Challenge management";
String activityManagePageDisplayName = "Activity record management";
String activityHistoryPageDisplayName = "Activity record detail";
String settlementManagePageDisplayName = "Sales and Settlement";
String settlementManagePageSubMenuDisplayName = "Streaming Details";
String masterSettlementManagePageDisplayName = "Master Settlement";
String adminSettingsPageDisplayName = "Settings";
String myAccountManagePageDisplayName = "Manage My Account";
String myCompanyManagePageDisplayName = "Manage My Company";
String etcSettingPageDisplayName = "Other settings";
// const subAdminSettingsDisplayName = "Sub admin management";
String authenticationPageDisplayName = "Log out";
String helpPageDisplayName = "Help";
String noticesPageDisplayName = "Notice";
String inquiriesPageDisplayName = "1:1 Inquiries";
String faqPageDisplayName = "FAQ";
String masterFreeBoardPageDisplayName = "Free Board";

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    if (!Account.isLogined) {
      return _buildLogo();
    }
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

  Widget _buildLogo() {
    return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder16,
              color: appTheme.skyBlue,
            ),
            width: 297,
            // height: 912,
            child: ListView(children: [
              Column(mainAxisSize: MainAxisSize.min, children: [
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
                          AccountRole.master.displayName.tr,
                          style: CustomTextStyles.labelLargeWhite,
                        ),
                      ),
                      // const SizedBox(width: 69),
                    ])
              ])
            ])));
  }

  void _logout() async {
    Account.signInClear();

    await Get.offAllNamed(AppRoutes.auth);
  }
}

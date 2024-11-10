import 'package:mindsight_admin_page/app_export.dart';

class MenuItem {
  final String name;
  final String route;
  final Function inited;

  MenuItem(this.name, this.route, this.inited);
}

const dashboardPageRoute = "/dashboard";
const dashboardPageDisplayName = "대시보드";

const memberManagePageRoute = "/member_manage";
const memberManagePageDisplayName = "회원 관리";
const memberManagePageSubMenuDisplayName = "회원 목록";

const memberDetailsPageRoute = "/member_details";
const memberDetailsPageDisplayName = "회원 상세";

const memberEditPageRoute = "/member_edit";
const memberEditPageDisplayName = "회원 정보 수정";

const inactiveMemberManagePageRoute = "/inactive_member_manage";
const inactiveMemberManagePageDisplayName = "비활성 회원 관리";

const masterManagePageRoute = "/master_manage";
const masterManagePageDisplayName = "마스터 관리";
const masterManagePageSubMenuDisplayName = "마스터 목록";

const inactiveMasterManagePageRoute = "/inactive_master_manage";
const inactiveMasterManagePageDisplayName = "비승인 마스터 관리";

const masterDetailsPageRoute = "/master_details";
const masterDetailsPageDisplayName = "마스터 상세";

const masterEditPageRoute = "/master_edit";
const masterEditPageDisplayName = "마스터 정보 수정";

const companyManagePageRoute = "/company_manage";
const companyManagePageDisplayName = "회사 관리";
const companyManagePageSubMenuDisplayName = "회사 목록";

const inactiveCompanyManagePageRoute = "/inactive_company_manage";
const inactiveCompanyManagePageDisplayName = "비승인 회사 관리";

const contentManagePageDisplayName = "콘텐츠 관리";
const contentManagePageRoute = "/content_manage";
const contentManageContentDisplayName = "콘텐츠 목록";
const contentPracticeDisplayName = "Practice plan 관리";
const contentChallengeDisplayName = "Challenge 관리";

const activityManagePageDisplayName = "활동 기록 관리";
const activityManagePageRoute = "/activity_manage";

const activityHistoryPageDisplayName = "활동 기록 상세";
const activityHistoryPageRoute = "/activity_history";

const settlementManagePageRoute = "/settlement_manage";
const settlementManagePageDisplayName = "매출 및 정산";
const settlementManagePageSubMenuDisplayName = "스트리밍 정산";

const revenueShareManagePageRoute = "/revenue_share_manage";
const revenueShareManagePageDisplayName = "CP 수익율";

const adminSettingsPageDisplayName = "관리자 설정";
const myAccountManageDisplayName = "내 계정 관리";
const subAdminSettingsDisplayName = "서브 관리자 관리";
const adminSettingsPageRoute = "/admin_settings";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(dashboardPageDisplayName, AppRoutes.dashboard, () {}),
  MenuItem(memberManagePageDisplayName, AppRoutes.memberManage, () {}),
  MenuItem(masterManagePageDisplayName, AppRoutes.masterManage, () {}),
  MenuItem(companyManagePageDisplayName, AppRoutes.companyManage, () {}),
  MenuItem(contentManagePageDisplayName, AppRoutes.contentManage, () {}),
  MenuItem(activityManagePageDisplayName, AppRoutes.activityManage, () {}),
  MenuItem(settlementManagePageDisplayName, AppRoutes.settlementManage, () {}),
  MenuItem(adminSettingsPageDisplayName, AppRoutes.adminSettings, () {}),
];

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

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
                        "Admin",
                        style: CustomTextStyles.labelLargeWhite,
                      ),
                    ),
                    const SizedBox(width: 69),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItemRoutes
                  .map((item) => SideMenuItem(
                      itemName: item.name,
                      onTap: () {
                        // if (item.route == authenticationPageRoute) {
                        //   Get.offAllNamed(authenticationPageRoute);
                        //   SideMenuController.to
                        //       .changeActiveItemTo(dashboardPageDisplayName);
                        // }
                        if (!SideMenuController.to.isActive(item.name)) {
                          item.inited();
                          SideMenuController.to.changeActiveItemTo(item.name);
                          if (SideMenuController.to.hasSubMenu(item.name)) {
                            SideMenuController.to.setActiveSubItem(item.name);
                          }
                          Get.offAllNamed(item.route);
                          // Logger.log("사이드 메뉴에서 offAllNamed ${item.route}");
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
                            "로그인 정보",
                            style: CustomTextStyles.titleSmallBlack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        // 'ms_content@nodamen.com',
                        PrefUtils.to.getSigninId(),
                        style: CustomTextStyles.labelLargeBlack,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        // '2024-01-12-11:32:23',
                        PrefUtils.to.getSigninTime(),
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
                        text: '로그아웃',
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
    PrefUtils.to.setIsLogined(false);
    await Get.offAllNamed(AppRoutes.auth);
  }
}

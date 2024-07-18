import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/theme/custom_button_style.dart';
import 'package:mindsight_admin_page/theme/custom_text_style.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: appTheme.skyBlue,
        ),
        width: 297,
        height: 912,
        child: ListView(
          children: [
            // if (ResponsiveWidget.isSmallScreen(context))
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
                        if (item.route == authenticationPageRoute) {
                          Get.offAllNamed(authenticationPageRoute);
                          menuController
                              .changeActiveItemTo(dashboardPageDisplayName);
                        }
                        if (!menuController.isActive(item.name)) {
                          menuController.changeActiveItemTo(item.name);
                          if (menuController.hasSubMenu(item.name)) {
                            menuController.setActiveSubItem(item.name);
                          }
                          Get.toNamed(item.route);
                          item.inited;
                        }
                      }))
                  .toList(),
            ),
            const SizedBox(height: 105),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
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
                            '로그인 정보',
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

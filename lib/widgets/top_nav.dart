import 'package:mindsight_admin_page/app_export.dart';
import 'custom_text.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Image.asset(
                    "assets/logo.png",
                    width: 300,
                  ),
                ),
              ],
            )
          : IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                key.currentState?.openDrawer();
              }),
      title: Row(
        children: [
          Visibility(
            visible: !ResponsiveWidget.isSmallScreen(context),
            child: Text('Admin', style: CustomTextStyles.labelLargeWhite),
          ),
          Expanded(child: Container()),
          IconButton(
              icon: Icon(
                Icons.settings,
                color: appTheme.black,
              ),
              onPressed: () {}),
          Stack(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: appTheme.black.withOpacity(.7),
                  ),
                  onPressed: () {}),
              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  width: 12,
                  height: 12,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: appTheme.primary,
                      borderRadius: BorderRadiusStyle.roundedBorder32,
                      border: Border.all(color: appTheme.grayScale1, width: 2)),
                ),
              )
            ],
          ),
          Container(
            width: 1,
            height: 22,
            color: appTheme.grayScale6,
          ),
          const SizedBox(
            width: 24,
          ),
          CustomText(
            text: "Santos Enoque",
            color: appTheme.grayScale6,
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
                color: appTheme.primary.withOpacity(.5),
                borderRadius: BorderRadiusStyle.roundedBorder32),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusStyle.roundedBorder32),
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: appTheme.grayScale1,
                child: Icon(
                  Icons.person_outline,
                  color: appTheme.black,
                ),
              ),
            ),
          )
        ],
      ),
      iconTheme: IconThemeData(color: appTheme.black),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );

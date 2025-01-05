import 'dart:async';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_model.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class ReloadHandler {
  static Future<void> autoSignin() async {
    if (!CustomHttpClient.to.isAccessTokenInited || AppConstant.test) {
      String? autoLoginId = PrefUtils.to.getSigninId();
      String? autoLoginPassword = PrefUtils.to.getSigninPassword();

      if (AppConstant.test) {
        autoLoginId = AppConstant.testEmail;
        autoLoginPassword = AppConstant.testPassword;
      }

      // autoLoginId = AppConstant.testEmail;
      // autoLoginPassword = AppConstant.testPassword;

      if (autoLoginId.isNotEmpty && autoLoginPassword.isNotEmpty) {
        Logger.info("자동Login $autoLoginId $autoLoginPassword");

        MasterSigninModel masterSigninModel =
            await MasterSigninRepository().post(MasterSigninReqPost(
          email: autoLoginId,
          password: autoLoginPassword,
        ));
        String path = html.window.location.href
            .substring(0, html.window.location.href.lastIndexOf('/'));

        String page = html.window.location.href
            .substring(html.window.location.href.lastIndexOf('/') + 1);

        Logger.info("page $page");

        if (masterSigninModel.isSuccess) {
          if (Account.isAdmin) {
            if (!AppConstant.test) {
              SideMenuController.to
                  .changeActiveItemTo(dashboardPageDisplayName);
              SideMenuController.to.changeActiveSubItem("");

              if (page.isNotEmpty) {
                html.window.location.href = "$path${AppRoutes.dashboard}";
                Logger.info("리로드: ${html.window.location.href}");
              } else {
                AppRoutes.initialRoute = AppRoutes.dashboard;
              }
            }
          } else {
            if (!AppConstant.test) {
              SideMenuController.to
                  .changeActiveItemTo(contentManagePageDisplayName);
              SideMenuController.to
                  .changeActiveSubItem(contentManageContentDisplayName);

              if (page.isNotEmpty) {
                html.window.location.href = "$path${AppRoutes.contentManage}";
                Logger.info("리로드: ${html.window.location.href}");
              } else {
                AppRoutes.initialRoute = AppRoutes.contentManage;
              }
            }
          }
        }
      } else {
        Logger.info("자동Login None status");
      }
    }
  }
}

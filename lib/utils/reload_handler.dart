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

      if (autoLoginId.isNotEmpty && autoLoginPassword.isNotEmpty) {
        Logger.info("자동로그인 $autoLoginId $autoLoginPassword");

        MasterSigninModel masterSigninModel =
            await MasterSigninRepository().post(MasterSigninReqPost(
          email: autoLoginId,
          password: autoLoginPassword,
        ));
        var path = html.window.location.href
            .substring(0, html.window.location.href.lastIndexOf('/'));
        if (masterSigninModel.isSuccess) {
          if (Account.isAdmin) {
            if (!AppConstant.test) {
              SideMenuController.to
                  .changeActiveItemTo(dashboardPageDisplayName);
              SideMenuController.to.changeActiveSubItem("");

              html.window.location.href = "$path${AppRoutes.auth}";
              Logger.info("앱 로드: ${html.window.location.href}");
            }
          } else {
            if (!AppConstant.test) {
              SideMenuController.to
                  .changeActiveItemTo(contentManagePageDisplayName);
              SideMenuController.to
                  .changeActiveSubItem(contentManageContentDisplayName);

              html.window.location.href = "$path${AppRoutes.contentManage}";
              Logger.info("앱 로드: ${html.window.location.href}");
            }
          }
        }
      } else {
        Logger.info("자동로그인 없음");
      }
    }
  }
}

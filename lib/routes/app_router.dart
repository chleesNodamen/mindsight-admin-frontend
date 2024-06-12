import 'package:flutter/material.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage.dart';
import 'package:mindsight_admin_page/presentation/terms_manage/terms_manage.dart';
import 'package:mindsight_admin_page/routes/app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case dashboardPageRoute:
      return _getPageRoute(const DashboardPage());
    case memberManagePageRoute:
      return _getPageRoute(const MemberManagePage());
    case contentManagePageRoute:
      return _getPageRoute(const ContentManagePage());
    case activityManagePageRoute:
      return _getPageRoute(const ActivityManagePage());
    case termsManagePageRoute:
      return _getPageRoute(const TermsManagePage());
    case adminSettingsPageRoute:
      return _getPageRoute(const AdminSettingsPage());
    default:
      return _getPageRoute(const DashboardPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

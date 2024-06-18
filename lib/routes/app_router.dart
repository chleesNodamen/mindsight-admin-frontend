import 'package:flutter/material.dart';
import 'package:mindsight_admin_page/presentation/activity_manage/activity_manage_view.dart';
import 'package:mindsight_admin_page/presentation/admin_settings/admin_settings_view.dart';
import 'package:mindsight_admin_page/presentation/content_manage/content_manage_view.dart';
import 'package:mindsight_admin_page/presentation/dashboard/dashboard_view.dart';
import 'package:mindsight_admin_page/presentation/member_manage/member_manage_view.dart';
import 'package:mindsight_admin_page/presentation/terms_manage/terms_manage_view.dart';
import 'package:mindsight_admin_page/routes/app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case DashboardViewRoute:
      return _getPageRoute(const DashboardView());
    case MemberManageViewRoute:
      return _getPageRoute(const MemberManageView());
    case ContentManageViewRoute:
      return _getPageRoute(const ContentManageView());
    case ActivityManageViewRoute:
      return _getPageRoute(const ActivityManageView());
    case TermsManageViewRoute:
      return _getPageRoute(const TermsManageView());
    case AdminSettingsViewRoute:
      return _getPageRoute(const AdminSettingsView());
    default:
      return _getPageRoute(const DashboardView());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
